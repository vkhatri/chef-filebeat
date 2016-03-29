default['filebeat']['version'] = '1.1.2'
default['filebeat']['disable_service'] = false
default['filebeat']['package_url'] = 'auto'

default['filebeat']['notify_restart'] = true
default['filebeat']['conf_dir'] = '/etc/filebeat'
default['filebeat']['prospectors_dir'] = ::File.join(node['filebeat']['conf_dir'], 'conf.d')
default['filebeat']['conf_file'] = ::File.join(node['filebeat']['conf_dir'], 'filebeat.yml')

default['filebeat']['windows'] = {
  'base_dir' => 'C:/opt/filebeat/'
}

default['filebeat']['yum']['baseurl'] = 'https://packages.elastic.co/beats/yum/el/$basearch'
default['filebeat']['yum']['description'] = 'Elastic Beats Repository'
default['filebeat']['yum']['gpgcheck'] = true
default['filebeat']['yum']['enabled'] = true
default['filebeat']['yum']['gpgkey'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['filebeat']['yum']['metadata_expire'] = '3h'
default['filebeat']['yum']['action'] = :create

default['filebeat']['apt']['uri'] = 'https://packages.elastic.co/beats/apt'
default['filebeat']['apt']['description'] = 'Elastic Beats Repository'
default['filebeat']['apt']['components'] = %w(stable main)
default['filebeat']['apt']['action'] = :add
default['filebeat']['apt']['key'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
