#
# Cookbook Name:: filebeat
# Resource:: filebeat_runit_service
#

resource_name :filebeat_runit_service

property :service_name, String, default: 'filebeat'
property :filebeat_install_resource_name, String, default: 'default'
property :disable_service, [TrueClass, FalseClass], default: false
property :purge_prospectors_dir, [TrueClass, FalseClass], default: false
property :runit_filebeat_cmd_options, String, default: ''
property :ignore_failure, [TrueClass, FalseClass], default: false

property :retries, Integer, default: 2
property :retry_delay, Integer, default: 0
property :notify_restart, [TrueClass, FalseClass], default: false

default_action :create

action :create do
  install_preview_resource = check_beat_resource(Chef.run_context, :filebeat_install_preview, new_resource.filebeat_install_resource_name)
  install_resource = check_beat_resource(Chef.run_context, :filebeat_install, new_resource.filebeat_install_resource_name)
  filebeat_install_resource = install_preview_resource || install_resource
  raise "could not find resource filebeat_install[#{filebeat_install_resource_name}] or filebeat_install_preview[#{filebeat_install_resource_name}]" if filebeat_install_resource.nil?

  conf_file = default_conf_file(filebeat_install_resource.conf_dir)

  ruby_block 'delay run purge prospectors dir' do
    block do
    end
    notifies :run, 'ruby_block[purge_prospectors_dir]'
  end

  ruby_block 'purge_prospectors_dir' do
    block do
      purge_prospectors_dir(filebeat_install_resource.prospectors_dir)
    end
    only_if { new_resource.purge_prospectors_dir }
    action :nothing
  end

  ruby_block 'delay filebeat service start' do
    block do
    end
    notifies :start, "service[#{new_resource.service_name}]"
    not_if { new_resource.disable_service }
  end

  include_recipe 'runit::default'

  service_action = new_resource.disable_service ? %i[disable stop] : %i[enable nothing]

  runit_cmd = "/usr/share/filebeat/bin/filebeat -c #{conf_file} -path.home /usr/share/filebeat -path.config #{filebeat_install_resource.conf_dir} -path.data /var/lib/filebeat -path.logs #{filebeat_install_resource.log_dir} #{new_resource.runit_filebeat_cmd_options}"
  runit_service new_resource.service_name do
    options(
      'user' => 'root',
      'cmd' => runit_cmd
    )
    default_logger true
    action service_action
    ignore_failure new_resource.ignore_failure
    cookbook 'filebeat'
  end
end

action :delete do
end
