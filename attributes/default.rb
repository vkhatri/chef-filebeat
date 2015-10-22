default['filebeat']['version'] = '1.0.0-beta4'
default['filebeat']['disable_service'] = false

default['filebeat']['package_url'] = value_for_platform_family(
  'debian' =>        "https://download.elastic.co/beats/filebeat/filebeat_#{node['filebeat']['version']}_amd64.deb",
  %w(rhel fedora) => "https://download.elastic.co/beats/filebeat/filebeat-#{node['filebeat']['version']}-x86_64.rpm"
)
default['filebeat']['notify_restart'] = true
default['filebeat']['enable_localhost_output'] = true
default['filebeat']['conf_dir'] = '/etc/filebeat'
default['filebeat']['prospectors_dir'] = ::File.join(node['filebeat']['conf_dir'], 'conf.d')
default['filebeat']['conf_file'] = ::File.join(node['filebeat']['conf_dir'], 'filebeat.yml')
