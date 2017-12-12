# https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration-details.html

# ===== filebeat.yml configuration =====
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-general.html
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-global-options.html
default['filebeat']['config']['filebeat.prospectors'] = []
default['filebeat']['config']['filebeat.modules'] = []
# default['filebeat']['config']['filebeat.spool_size'] = 2048
# default['filebeat']['config']['filebeat.publish_async'] = false
# default['filebeat']['config']['filebeat.idle_timeout'] =  '5s'
# [evaluated] default['filebeat']['config']['filebeat.registry_file'] =  '${path.data}/registry'
# [evaluated] default['filebeat']['config']['filebeat.config_dir'] =
# default['filebeat']['config']['filebeat.shutdown_timeout'] = 0
# default['filebeat']['config']['name'] =
# default['filebeat']['config']['tags'] = ["service-X", "web-tier"]
# default['filebeat']['config']['fields'] = {'env' => 'test'}
# default['filebeat']['config']['fields_under_root'] = false
# default['filebeat']['config']['max_procs'] =

# ===== add filebeat prospectors using node attribute example =====
default['filebeat']['prospectors'] = {}
=begin
apache_logs = {
    'paths' => ["/var/log/apache/*.log"],
    'input_type' => "log",
    'fields' => {  'logtype' => "apache"  },
    'document_type' => "apache",
    'fields_under_root' => true
}
default['filebeat']['prospectors']['access'] = apache_logs
=end

# ===== filebeat output configration =====
#
# elasticsearch output
# https://www.elastic.co/guide/en/beats/filebeat/current/elasticsearch-output.html
# default['filebeat']['config']['output.elasticsearch']['enable'] = true
# default['filebeat']['config']['output.elasticsearch']['hosts'] = ['127.0.0.1:9200']

# logstash output
# https://www.elastic.co/guide/en/beats/filebeat/current/logstash-output.html
# default['filebeat']['config']['output.logstash']['enable'] = true
# default['filebeat']['config']['output.logstash']['hosts'] = ['127.0.0.1:5044']

# redis output
# https://www.elastic.co/guide/en/beats/filebeat/current/redis-output.html
# default['filebeat']['config']['output.redis']['enable'] = true
# default['filebeat']['config']['output.redis']['host'] = 'locahost'

# kafka output
# https://www.elastic.co/guide/en/beats/filebeat/current/kafka-output.html
# default['filebeat']['config']['output.redis']['enable'] = true
# default['filebeat']['config']['output.redis']['host'] = ['kafka1:9092', 'kafka2:9092', 'kafka3:9092']

# file output
# https://www.elastic.co/guide/en/beats/filebeat/current/file-output.html
# default['filebeat']['config']['output.file']['path'] = '/tmp/filebeat'
# default['filebeat']['config']['output.file']['filename'] = 'filebeat'
# default['filebeat']['config']['output.file']['rotate_every_kb'] = 1_000
# default['filebeat']['config']['output.file']['number_of_files'] = 7

# console output
# https://www.elastic.co/guide/en/beats/filebeat/current/console-output.html
# default['filebeat']['config']['output.console']['enable'] true

# logging
# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-logging.html
# default['filebeat']['config']['logging.metrics.enabled'] = true
# default['filebeat']['config']['logging.metrics.period'] = '30s'
# default['filebeat']['config']['logging.level'] = 'info'
# default['filebeat']['config']['logging.to_files'] = true
# [evaluated] default['filebeat']['config']['logging.files']['path'] =
# default['filebeat']['config']['logging.files']['name'] = 'filebeat'
# default['filebeat']['config']['logging.files']['rotateeverybytes'] = 10485760
# default['filebeat']['config']['logging.files']['keepfiles'] = 7
