filebeat_prospector 'test1' do
  type 'log'
  fields 'type' => 'test1_logs'
  type 'log'
  input_type 'log'
  paths %w[/var/log/test1.log]
  recursive_glob_enabled false
  encoding 'utf-8'
  exclude_lines ['^DBG']
  include_lines ['^WARN', '^ERR']
  exclude_files ['\.gz$']
  tags ['kitchen']
  fields 'engine' => 'kitchen'
  fields_under_root true
  ignore_older '1h'
  close_inactive '1m'
  close_renamed true
  close_removed true
  close_eof false
  close_timeout '0'
  clean_inactive '2h'
  clean_removed true
  scan_frequency '30s'
  # scan_sort #v6
  # scan_order #v6
  document_type 'log'
  harvester_buffer_size 16_384
  max_bytes 10_485_760
  json_keys_under_root true
  json_overwrite_keys false
  json_add_error_key true
  json_message_key 'log'
  multiline_pattern '^\['
  multiline_negate true
  multiline_match 'after'
  # multiline_flush_pattern #v6
  multiline_max_lines 500
  multiline_timeout '5s'
  tail_files false
  pipeline 'bigespipeline'
  symlinks false
  backoff '1s'
  max_backoff '10s'
  backoff_factor 2
  harvester_limit 0
  enabled true
end
