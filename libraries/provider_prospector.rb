class Chef
  class Provider
    # provides filebeat_prospector
    class FilebeatProspector < Chef::Provider
      provides :filebeat_prospector if respond_to?(:provides)

      def initialize(*args)
        super
      end

      def whyrun_supported?
        true
      end

      def load_current_resource
        true
      end

      def action_create
        new_resource.updated_by_last_action(prospector_file)
      end

      def action_delete
        new_resource.updated_by_last_action(prospector_file)
      end

      protected

      def prospector_file
        content = {}
        if new_resource.action == :create
          content['paths'] = new_resource.paths if new_resource.paths
          content['type'] = new_resource.type if new_resource.type
          content['encoding'] = new_resource.encoding if new_resource.encoding
          content['fields_under_root'] = new_resource.fields_under_root if new_resource.fields_under_root
          content['ignore_older'] = new_resource.ignore_older if new_resource.ignore_older
          content['document_type'] = new_resource.document_type if new_resource.document_type
          content['input_type'] = new_resource.input_type if new_resource.input_type
          content['scan_frequency'] = new_resource.scan_frequency if new_resource.scan_frequency
          content['harvester_buffer_size'] = new_resource.harvester_buffer_size if new_resource.harvester_buffer_size
          content['tail_files'] = new_resource.tail_files if new_resource.tail_files
          content['backoff'] = new_resource.backoff if new_resource.backoff
          content['max_backoff'] = new_resource.max_backoff if new_resource.max_backoff
          content['backoff_factor'] = new_resource.backoff_factor if new_resource.backoff_factor
          content['force_close_files'] = new_resource.force_close_files if new_resource.force_close_files
          content['fields'] = new_resource.fields if new_resource.fields
          content['include_lines'] = new_resource.include_lines if new_resource.include_lines
          content['exclude_lines'] = new_resource.exclude_lines if new_resource.exclude_lines
          content['multiline'] = new_resource.multiline if new_resource.multiline
        end

        file_content = { 'filebeat' => { 'prospectors' => [content] } }.to_yaml

        t = Chef::Resource::File.new("prospector_#{new_resource.name}", run_context)
        t.path ::File.join(node['filebeat']['prospectors_dir'], "prospector-#{new_resource.name}.yml")
        t.content file_content
        t.notifies :restart, 'service[filebeat]'
        t.run_action new_resource.action
        t.updated?
      end
    end
  end
end
