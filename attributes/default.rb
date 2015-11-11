default['filebeat']['version'] = '1.0.0-rc2'
default['filebeat']['disable_service'] = false
default['filebeat']['package_url'] = 'auto'

default['filebeat']['notify_restart'] = true
default['filebeat']['enable_localhost_output'] = true
default['filebeat']['conf_dir'] = '/etc/filebeat'
default['filebeat']['prospectors_dir'] = ::File.join(node['filebeat']['conf_dir'], 'conf.d')
default['filebeat']['conf_file'] = ::File.join(node['filebeat']['conf_dir'], 'filebeat.yml')

default['filebeat']['windows'] = {
  'base_dir' => 'C:/opt/filebeat/'
}
