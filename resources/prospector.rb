#
# Cookbook Name:: filebeat
# Resource:: filebeat_prospector
#

resource_name :filebeat_prospector

property :service_name, String, default: 'filebeat'
property :filebeat_install_resource_name, String, default: 'default'
property :prefix, String, default: 'lwrp-prospector-'
property :config, [Array, Hash], default: {}
property :cookbook_file_name, [String, NilClass], default: nil
property :cookbook_file_name_cookbook, [String, NilClass], default: nil
property :disable_service, [TrueClass, FalseClass], default: false
property :notify_restart, [TrueClass, FalseClass], default: true
property :config_sensitive, [TrueClass, FalseClass], default: false

default_action :create

action :create do
  install_preview_resource = check_beat_resource(Chef.run_context, :filebeat_install_preview, new_resource.filebeat_install_resource_name)
  install_resource = check_beat_resource(Chef.run_context, :filebeat_install, new_resource.filebeat_install_resource_name)
  filebeat_install_resource = install_preview_resource || install_resource
  raise "could not find resource filebeat_install[#{new_resource.filebeat_install_resource_name}] or filebeat_install_preview[#{new_resource.filebeat_install_resource_name}]" if filebeat_install_resource.nil?

  config = new_resource.config.dup
  config = [config] unless new_resource.config.is_a?(Array)

  # Filebeat and psych v1.x don't get along.
  if Psych::VERSION.start_with?('1')
    defaultengine = YAML::ENGINE.yamler
    YAML::ENGINE.yamler = 'syck'
  end

  # file_content = { 'filebeat' => { 'prospectors' => config } }.to_yaml
  file_content = JSON.parse({ 'filebeat' => { 'prospectors' => config } }.to_json).to_yaml.lines.to_a[1..-1].join

  # ...and put this back the way we found them.
  YAML::ENGINE.yamler = defaultengine if Psych::VERSION.start_with?('1')

  if new_resource.cookbook_file_name && new_resource.cookbook_file_name_cookbook
    cookbook_file "prospector_#{new_resource.name}" do
      path ::File.join(filebeat_install_resource.prospectors_dir, "#{new_resource.prefix}#{new_resource.name}.yml")
      source new_resource.cookbook_file_name
      cookbook new_resource.cookbook_file_name_cookbook
      notifies :restart, "service[#{new_resource.service_name}]" if new_resource.notify_restart && !new_resource.disable_service
      mode 0o600
      sensitive new_resource.config_sensitive
    end
  else
    file "prospector_#{new_resource.name}" do
      path ::File.join(filebeat_install_resource.prospectors_dir, "#{new_resource.prefix}#{new_resource.name}.yml")
      content file_content
      notifies :restart, "service[#{new_resource.service_name}]" if new_resource.notify_restart && !new_resource.disable_service
      mode 0o600
      sensitive new_resource.config_sensitive
    end
  end
end

action :delete do
  filebeat_install_resource = find_beat_resource(Chef.run_context, :filebeat_install, new_resource.filebeat_install_resource_name)
  file "prospector_#{new_resource.name}" do
    path ::File.join(filebeat_install_resource.prospectors_dir, "#{new_resource.prefix}#{new_resource.name}.yml")
    action :delete
  end
end

action_class do
  include ::Filebeat::Helpers
end
