#
# Cookbook:: filebeat
# Resource:: filebeat_config
#

default_config = { 'filebeat.inputs' => [], 'filebeat.prospectors' => [], 'filebeat.modules' => [], 'prospectors' => [] }

resource_name :filebeat_config

property :service_name, String, default: 'filebeat'
property :filebeat_install_resource_name, String, default: 'default'
property :config, Hash, default: default_config
property :conf_file, [String, NilClass]
property :disable_service, [true, false], default: false
property :notify_restart, [true, false], default: true
property :config_sensitive, [true, false], default: false

default_action :create

action :create do
  install_preview_resource = check_beat_resource(Chef.run_context, :filebeat_install_preview, new_resource.filebeat_install_resource_name)
  install_resource = check_beat_resource(Chef.run_context, :filebeat_install, new_resource.filebeat_install_resource_name)
  filebeat_install_resource = install_preview_resource || install_resource
  raise "could not find resource filebeat_install[#{new_resource.filebeat_install_resource_name}] or filebeat_install_preview[#{new_resource.filebeat_install_resource_name}]" if filebeat_install_resource.nil?

  new_resource.conf_file = new_resource.conf_file || default_conf_file(filebeat_install_resource.conf_dir)

  config = new_resource.config.dup
  logging_files_path = platform?('windows') ? "#{filebeat_install_resource.conf_dir}/logs" : filebeat_install_resource.log_dir

  config['logging.files']['path'] ||= logging_files_path

  if filebeat_install_resource.version.to_f >= 7.0
    config['filebeat.registry.path'] = platform?('windows') ? "#{filebeat_install_resource.conf_dir}/registry" : '/var/lib/filebeat/registry'
  else
    config['filebeat.registry_file'] = platform?('windows') ? "#{filebeat_install_resource.conf_dir}/registry" : '/var/lib/filebeat/registry'
  end

  if filebeat_install_resource.version.to_f >= 6.0
    config['filebeat.config.inputs'] ||= {
      'enabled' => true,
      'path' => "#{filebeat_install_resource.prospectors_dir}/*.yml",
    }
  else
    config['filebeat.config_dir'] = filebeat_install_resource.prospectors_dir
  end

  # Filebeat and psych v1.x don't get along.
  if Psych::VERSION.start_with?('1')
    defaultengine = YAML::ENGINE.yamler
    YAML::ENGINE.yamler = 'syck'
  end

  file new_resource.conf_file do
    content JSON.parse(config.to_json).to_yaml.lines.to_a[1..-1].join
    notifies :restart, "service[#{new_resource.service_name}]" if new_resource.notify_restart && !new_resource.disable_service
    mode '600'
    sensitive new_resource.config_sensitive
  end

  # ...and put this back the way we found them.
  YAML::ENGINE.yamler = defaultengine if Psych::VERSION.start_with?('1')
end

action :delete do
  filebeat_install_resource = find_beat_resource(Chef.run_context, :filebeat_install, new_resource.filebeat_install_resource_name)
  new_resource.conf_file = new_resource.conf_file || default_conf_file(filebeat_install_resource.conf_dir)

  file new_resource.conf_file do
    action :delete
  end
end

action_class do
  include ::Filebeat::Helpers
end
