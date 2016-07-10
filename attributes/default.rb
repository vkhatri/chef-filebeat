default['filebeat']['version'] = '1.2.3'
default['filebeat']['disable_service'] = false
default['filebeat']['package_url'] = 'auto'
default['filebeat']['package_force_overwrite'] = true

default['filebeat']['notify_restart'] = true
default['filebeat']['windows'] = { 'base_dir' => 'C:/opt/filebeat' }
default['filebeat']['solaris'] = {
  'base_dir' => '/opt',
  'manifest_directory' => '/var/svc/manifest/application'
}
default['filebeat']['conf_dir'] = if node['platform'] == 'windows'
                                    "#{node['filebeat']['windows']['base_dir']}/filebeat-#{node['filebeat']['version']}-windows"
                                  else
                                    '/etc/filebeat'
                                  end
default['filebeat']['conf_file'] = if node['platform'] == 'windows'
                                     "#{node['filebeat']['conf_dir']}/filebeat.yml"
                                   else
                                     ::File.join(node['filebeat']['conf_dir'], 'filebeat.yml')
                                   end
default['filebeat']['prospectors_dir'] = if node['platform'] == 'windows'
                                           "#{node['filebeat']['conf_dir']}/conf.d"
                                         else
                                           ::File.join(node['filebeat']['conf_dir'], 'conf.d')
                                         end
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
default['filebeat']['apt']['distribution'] = ''
# apt package install options
default['filebeat']['apt']['options'] = "-o Dpkg::Options::='--force-confnew'"
default['filebeat']['apt']['action'] = :add
default['filebeat']['apt']['key'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['filebeat']['service']['retries'] = 0
default['filebeat']['service']['retry_delay'] = 2
