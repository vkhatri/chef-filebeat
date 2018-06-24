default['filebeat_test']['prospectors']['test'].tap do |t|
  t['enabled'] = true
  t['sensitive'] = false
  t['type'] = 'log'
  t['fields'] = { 'type' => 'test1_logs', 'engine' => 'kitchen' }
  t['type'] = 'log'
  t['input_type'] = 'log'
  t['paths'] = %w[/var/log/test1.log]
  t['recursive_glob_enabled'] = false
  t['encoding'] = 'utf-8'
  t['exclude_lines'] = ['^DBG']
  t['include_lines'] = ['^WARN', '^ERR']
  t['exclude_files'] = ['\.gz$']
  t['tags'] = ['kitchen']
  t['fields_under_root'] = true
  t['ignore_older'] = '1h'
  t['close_inactive'] = '1m'
  t['close_renamed'] = true
  t['close_removed'] = true
  t['close_eof'] = false
  t['close_timeout'] = '0'
  t['clean_inactive'] = '2h'
  t['clean_removed'] = true
  t['scan_frequency'] = '30s'
  t['scan_sort'] = 'modtime'
  t['scan_order'] = 'asc'
  t['document_type'] = 'log'
  t['harvester_buffer_size'] = 16_384
  t['max_bytes'] = 10_485_760
  t['json_keys_under_root'] = true
  t['json_overwrite_keys'] = false
  t['json_add_error_key'] = true
  t['json_message_key'] = 'log'
  t['multiline_pattern'] = '^\['
  t['multiline_negate'] = true
  t['multiline_match'] = 'after'
  t['multiline_flush_pattern'] = '^\[?[0-9]{10}\]'
  t['multiline_max_lines'] = 500
  t['multiline_timeout'] = '5s'
  t['tail_files'] = false
  t['pipeline'] = 'bigespipeline'
  t['symlinks'] = false
  t['backoff'] = '1s'
  t['max_backoff'] = '10s'
  t['backoff_factor'] = 2
  t['harvester_limit'] = 0
  t['enabled'] = true
end

default['filebeat_test']['prospectors']['secure_logs'].tap do |s|
  s['enabled'] = true
  s['paths'] = ['/var/log/secure']
  s['type'] = 'log'
  s['fields'] = { 'type' => 'secure_logs' }
end

default['filebeat_test']['prospectors']['syslog_logs'].tap do |s|
  s['enabled'] = true
  s['paths'] = ['/var/log/syslog']
  s['type'] = 'log'
  s['fields'] = { 'type' => 'syslog_logs' }
end

default['filebeat_test']['prospectors']['messages_log'].tap do |s|
  s['enabled'] = true
  s['paths'] = ['/var/log/messages']
  s['type'] = 'log'
  s['fields'] = { 'type' => 'messages_log' }
end

default['filebeat_test']['prospectors']['extra_log'].tap do |s|
  s['enabled'] = true
  s['paths'] = ['/var/log/*.log']
  s['type'] = 'log'
  s['fields'] = { 'type' => 'extra_log' }
  s['exclude_files'] = ['/var/log/messages', '/var/log/syslog', '/var/log/secure']
end

default['filebeat_test']['prospectors']['extra_log_list'] = [
  {
    'enabled' => true,
    'paths' => ['/var/log/*.logy'],
    'type' => 'log',
    'fields' => { 'type' => 'extra_log_y' },
    'exclude_files' => ['/var/log/messages', '/var/log/syslog', '/var/log/secure']
  },
  {
    'enabled' => true,
    'paths' => ['/var/log/*.logx'],
    'type' => 'log',
    'fields' => { 'type' => 'extra_log_x' },
    'exclude_files' => ['/var/log/messages', '/var/log/syslog', '/var/log/secure']
  }
]

default['filebeat_test']['filebeat_config'].tap do |c|
  # c['filebeat.prospectors'] = []
  c['filebeat.modules'] = []
  c['prospectors'] = []
  c['logging.level'] = 'info'
  c['logging.to_files'] = true
  c['logging.files'] = { 'name' => 'filebeat' }
  c['output.elasticsearch'] = { 'hosts' => ['127.0.0.1:9200'] }
end
