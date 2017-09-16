class Chef
  class Provider
    # provides filebeat_prospector
    class FilebeatProspector < Chef::Provider::LWRPBase
      provides :filebeat_prospector if respond_to?(:provides)

      def whyrun_supported?
        true
      end

      use_inline_resources

      action :create do
        converge_by "create filebeat prospector configuration #{new_resource.name}" do
          prospector_file
        end
      end

      action :delete do
        converge_by "delete filebeat prospector configuration #{new_resource.name}" do
          prospector_file
        end
      end

      protected

      def prospector_content
        content = {}
        content['type'] = new_resource.type if new_resource.type
        content['input_type'] = new_resource.input_type if new_resource.input_type
        content['paths'] = new_resource.paths if new_resource.paths
        content['recursive_glob'] = { 'enabled' => new_resource.recursive_glob_enabled } if new_resource.recursive_glob_enabled
        content['encoding'] = new_resource.encoding if new_resource.encoding
        content['exclude_lines'] = new_resource.exclude_lines if new_resource.exclude_lines
        content['include_lines'] = new_resource.include_lines if new_resource.include_lines
        content['exclude_files'] = new_resource.exclude_files if new_resource.exclude_files
        content['tags'] = new_resource.tags if new_resource.tags
        content['fields'] = new_resource.fields if new_resource.fields
        content['fields_under_root'] = new_resource.fields_under_root if new_resource.fields_under_root
        content['ignore_older'] = new_resource.ignore_older if new_resource.ignore_older
        content['close_inactive'] = new_resource.close_inactive if new_resource.close_inactive
        content['close_renamed'] = new_resource.close_renamed if new_resource.close_renamed
        content['close_removed'] = new_resource.close_removed if new_resource.close_removed
        content['close_eof'] = new_resource.close_eof if new_resource.close_eof
        content['close_timeout'] = new_resource.close_timeout if new_resource.close_timeout
        content['clean_inactive'] = new_resource.clean_inactive if new_resource.clean_inactive
        content['clean_removed'] = new_resource.clean_removed if new_resource.clean_removed
        content['scan_frequency'] = new_resource.scan_frequency if new_resource.scan_frequency
        content['scan.sort'] = new_resource.scan_sort if new_resource.scan_sort
        content['scan.order'] = new_resource.scan_order if new_resource.scan_order
        content['document_type'] = new_resource.document_type if new_resource.document_type # deprecated in 5.5
        content['harvester_buffer_size'] = new_resource.harvester_buffer_size if new_resource.harvester_buffer_size
        content['max_bytes'] = new_resource.max_bytes if new_resource.max_bytes
        content['json.keys_under_root'] = new_resource.json_keys_under_root if new_resource.json_keys_under_root
        content['json.overwrite_keys'] = new_resource.json_overwrite_keys if new_resource.json_overwrite_keys
        content['json.add_error_key'] = new_resource.json_add_error_key if new_resource.json_add_error_key
        content['json.message_key'] = new_resource.json_message_key if new_resource.json_message_key
        content['multiline.pattern'] = new_resource.multiline_pattern if new_resource.multiline_pattern
        content['multiline.negate'] = new_resource.multiline_negate if new_resource.multiline_negate
        content['multiline.match'] = new_resource.multiline_match if new_resource.multiline_match
        content['multiline.flush_pattern'] = new_resource.multiline_flush_pattern if new_resource.multiline_flush_pattern
        content['multiline.max_lines'] = new_resource.multiline_max_lines if new_resource.multiline_max_lines
        content['multiline.timeout'] = new_resource.multiline_timeout if new_resource.multiline_timeout
        content['tail_files'] = new_resource.tail_files if new_resource.tail_files
        content['pipeline'] = new_resource.pipeline if new_resource.pipeline
        content['symlinks'] = new_resource.symlinks if new_resource.symlinks
        content['backoff'] = new_resource.backoff if new_resource.backoff
        content['max_backoff'] = new_resource.max_backoff if new_resource.max_backoff
        content['backoff_factor'] = new_resource.backoff_factor if new_resource.backoff_factor
        content['harvester_limit'] = new_resource.harvester_limit if new_resource.harvester_limit
        content['enabled'] = new_resource.enabled if new_resource.enabled

        # v1.x
        content['close_older'] = new_resource.close_older if new_resource.close_older
        content['force_close_files'] = new_resource.force_close_files if new_resource.force_close_files
        content['multiline'] = new_resource.multiline if new_resource.multiline

        file_content = { 'filebeat' => { 'prospectors' => [content] } }.to_yaml
        file_content
      end

      def prospector_file
        # When action is set it is an array.  Using is_a because symbols respond to []
        action = if new_resource.action.is_a?(Array)
                   raise("Unexpected number of actions: #{new_resource.action}") if new_resource.action.length != 1
                   new_resource.action[0]
                 else
                   new_resource.action
                 end

        file_content = if action == :create
                         prospector_content
                       else
                         {}
                       end

        t = file "prospector_#{new_resource.name}" do
          path ::File.join(node['filebeat']['prospectors_dir'], "lwrp-prospector-#{new_resource.name}.yml")
          content file_content
          notifies :restart, "service[#{node['filebeat']['service']['name']}]" if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
          mode 0o600
          action action
        end
        t.updated?
      end
    end
  end
end
