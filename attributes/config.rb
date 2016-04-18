# https://github.com/elastic/filebeat/blob/master/etc/filebeat.yml
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration.html
#

# prospector configuration files
default['filebeat']['prospectors'] = {}
# prospector configuration
default['filebeat']['config']['filebeat']['prospectors'] = []
# default['filebeat']['config']['filebeat']['spool_size'] = 1024
# default['filebeat']['config']['filebeat']['idle_timeout'] =  '5s'
default['filebeat']['config']['filebeat']['registry_file'] = if node['platform'] == 'windows'
                                                               "#{node['filebeat']['conf_dir']}/registry"
                                                             else
                                                               '/var/lib/filebeat/registry'
                                                             end
default['filebeat']['config']['filebeat']['config_dir'] = node['filebeat']['prospectors_dir']
=begin
# Add Prospectors using Node Attribute Example
apache_logs = {
    'paths' => ["/var/log/apache/*.log"],
    'input_type' => "log",
    'fields' => {  'logtype' => "apache"  },
    'document_type' => "apache",
    'fields_under_root' => true
}
default['filebeat']['prospectors']['access']['filebeat']['prospectors'] = [apache_logs]
=end
default['filebeat']['config']['output'] = {}
# elasticsearch host info
# default['filebeat']['config']['output']['elasticsearch']['enabled'] = true
# default['filebeat']['config']['output']['elasticsearch']['hosts'] = []
# default['filebeat']['config']['output']['elasticsearch']['save_topology'] = false
# default['filebeat']['config']['output']['elasticsearch']['max_retries'] = 3
# default['filebeat']['config']['output']['elasticsearch']['bulk_max_size'] = 1000
# default['filebeat']['config']['output']['elasticsearch']['flush_interval'] = nil
# default['filebeat']['config']['output']['elasticsearch']['protocol'] = 'http'
# default['filebeat']['config']['output']['elasticsearch']['username'] = nil
# default['filebeat']['config']['output']['elasticsearch']['password'] = nil
# default['filebeat']['config']['output']['elasticsearch']['index'] = 'filebeat'
# default['filebeat']['config']['output']['elasticsearch']['path'] = '/elasticsearch'

# Logstash Output config info
# default['filebeat']['config']['output']['logstash']['enabled'] = false
# default['filebeat']['config']['output']['logstash']['hosts'] = []
# default['filebeat']['config']['output']['logstash']['loadbalance'] = true
# default['filebeat']['config']['output']['logstash']['save_topology'] = true
# default['filebeat']['config']['output']['logstash']['index'] = 'filebeat'

# Logging Output configs
# default['filebeat']['config']['logging']['to_files'] = true
# if node['platform'] == 'windows'
#  default['filebeat']['config']['logging']['files']['path'] = '"#{node['filebeat']['conf_dir']}/logs"'
# end
# default['filebeat']['config']['logging']['files']['rotateeverybytes'] = 10485760
# default['filebeat']['config']['logging']['level'] = 'info'

# default['filebeat']['config']['output']['file']['enabled'] = false
# default['filebeat']['config']['output']['file']['path'] = '/tmp/filebeat'
# default['filebeat']['config']['output']['file']['filename'] = 'filebeat'
# default['filebeat']['config']['output']['file']['rotate_every_kb'] = 1_000
# default['filebeat']['config']['output']['file']['number_of_files'] = 7
# default['filebeat']['config']['procs']['enabled'] = false
# default['filebeat']['config']['procs']['enabled']['monitored'] = [{'process' => 'mysqld', 'cmdline_grep' => 'mysqld]
