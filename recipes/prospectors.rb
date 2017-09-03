#
# Cookbook Name:: filebeat
# Recipe:: prospectors
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

prospectors_dir_action = node['filebeat']['delete_prospectors_dir'] ? %i[delete create] : %i[create]

directory node['filebeat']['prospectors_dir'] do
  recursive true
  action prospectors_dir_action
end

prospectors = node['filebeat']['prospectors']

prospectors.each do |prospector, conf|
  config = conf.to_hash
  filebeat_prospector prospector do
    type config['type'] unless config['type'].nil?
    input_type config['input_type'] unless config['input_type'].nil?
    paths config['paths'] unless config['paths'].nil?
    recursive_glob_enabled config['recursive_glob_enabled'] unless config['recursive_glob_enabled'].nil?
    encoding config['encoding'] unless config['encoding'].nil?
    exclude_lines config['exclude_lines'] unless config['exclude_lines'].nil?
    include_lines config['include_lines'] unless config['include_lines'].nil?
    exclude_files config['exclude_files'] unless config['exclude_files'].nil?
    tags config['tags'] unless config['tags'].nil?
    fields config['fields'] unless config['fields'].nil?
    fields_under_root config['fields_under_root'] unless config['fields_under_root'].nil?
    ignore_older config['ignore_older'] unless config['ignore_older'].nil?
    close_inactive config['close_inactive'] unless config['close_inactive'].nil?
    close_renamed config['close_renamed'] unless config['close_renamed'].nil?
    close_removed config['close_removed'] unless config['close_removed'].nil?
    close_eof config['close_eof'] unless config['close_eof'].nil?
    close_timeout config['close_timeout'] unless config['close_timeout'].nil?
    clean_inactive config['clean_inactive'] unless config['clean_inactive'].nil?
    clean_removed config['clean_removed'] unless config['clean_removed'].nil?
    scan_frequency config['scan_frequency'] unless config['scan_frequency'].nil?
    scan_sort config['scan_sort'] unless config['scan_sort'].nil?
    scan_order config['scan_order'] unless config['scan_order'].nil?
    document_type config['document_type'] unless config['document_type'].nil?
    harvester_buffer_size config['harvester_buffer_size'] unless config['harvester_buffer_size'].nil?
    max_bytes config['max_bytes'] unless config['max_bytes'].nil?
    json_keys_under_root config['json_keys_under_root'] unless config['json_keys_under_root'].nil?
    json_overwrite_keys config['json_overwrite_keys'] unless config['json_overwrite_keys'].nil?
    json_add_error_key config['json_add_error_key'] unless config['json_add_error_key'].nil?
    json_message_key config['json_message_key'] unless config['json_message_key'].nil?
    multiline_pattern config['multiline_pattern'] unless config['multiline_pattern'].nil?
    multiline_negate config['multiline_negate'] unless config['multiline_negate'].nil?
    multiline_match config['multiline_match'] unless config['multiline_match'].nil?
    multiline_flush_pattern config['multiline_flush_pattern'] unless config['multiline_flush_pattern'].nil?
    multiline_max_lines config['multiline_max_lines'] unless config['multiline_max_lines'].nil?
    multiline_timeout config['multiline_timeout'] unless config['multiline_timeout'].nil?
    tail_files config['tail_files'] unless config['tail_files'].nil?
    pipeline config['pipeline'] unless config['pipeline'].nil?
    symlinks config['symlinks'] unless config['symlinks'].nil?
    backoff config['backoff'] unless config['backoff'].nil?
    max_backoff config['max_backoff'] unless config['max_backoff'].nil?
    backoff_factor config['backoff_factor'] unless config['backoff_factor'].nil?
    harvester_limit config['harvester_limit'] unless config['harvester_limit'].nil?
    enabled config['enabled'] unless config['enabled'].nil?
    close_older config['close_older'] unless config['close_older'].nil?
    force_close_files config['force_close_files'] unless config['force_close_files'].nil?
    multiline config['multiline'] unless config['multiline'].nil?
  end
end
