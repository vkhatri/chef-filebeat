# https://www.elastic.co/guide/en/beats/filebeat/current/configuration-filebeat-options.html
class Chef
  class Resource
    # provides filebeat_prospector
    class FilebeatProspector < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :filebeat_prospector if respond_to?(:resource_name)
        @provides = :filebeat_prospector
        @provider = Chef::Provider::FilebeatProspector
        @action = :create
        @allowed_actions = %i[create delete nothing]
        @name = name
      end

      def sensitive(arg = nil)
        set_or_return(
          :sensitive, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => true
        )
      end

      def type(arg = nil)
        set_or_return(
          :type, arg,
          :kind_of => String,
          :equal_to => %w[log stdin redis],
          :default => nil
        )
      end

      def input_type(arg = nil)
        set_or_return(
          :input_type, arg,
          :kind_of => String,
          :equal_to => %w[log stdin],
          :default => nil
        )
      end

      def paths(arg = nil)
        set_or_return(
          :paths, arg,
          :required => true,
          :kind_of => Array,
          :default => nil
        )
      end

      def recursive_glob_enabled(arg = nil)
        set_or_return(
          :recursive_glob_enabled, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def encoding(arg = nil)
        set_or_return(
          :encoding, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def exclude_lines(arg = nil)
        set_or_return(
          :exclude_lines, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def include_lines(arg = nil)
        set_or_return(
          :include_lines, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def exclude_files(arg = nil)
        set_or_return(
          :exclude_files, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def tags(arg = nil)
        set_or_return(
          :tags, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def fields(arg = nil)
        set_or_return(
          :fields, arg,
          :kind_of => Hash,
          :default => nil
        )
      end

      def fields_under_root(arg = nil)
        set_or_return(
          :fields_under_root, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def ignore_older(arg = nil)
        set_or_return(
          :ignore_older, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def close_inactive(arg = nil)
        set_or_return(
          :close_inactive, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def close_renamed(arg = nil)
        set_or_return(
          :close_renamed, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def close_removed(arg = nil)
        set_or_return(
          :close_removed, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def close_eof(arg = nil)
        set_or_return(
          :close_eof, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def close_timeout(arg = nil)
        set_or_return(
          :close_timeout, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def clean_inactive(arg = nil)
        set_or_return(
          :clean_inactive, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def clean_removed(arg = nil)
        set_or_return(
          :clean_removed, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def scan_frequency(arg = nil)
        set_or_return(
          :scan_frequency, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def scan_sort(arg = nil)
        set_or_return(
          :scan_sort, arg,
          :kind_of => String,
          :equal_to => %w[modtime filename],
          :default => nil
        )
      end

      def scan_order(arg = nil)
        set_or_return(
          :scan_order, arg,
          :kind_of => String,
          :equal_to => %w[asc desc],
          :default => nil
        )
      end

      def document_type(arg = nil)
        set_or_return(
          :document_type, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def harvester_buffer_size(arg = nil)
        set_or_return(
          :harvester_buffer_size, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def max_bytes(arg = nil)
        set_or_return(
          :max_bytes, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def json_keys_under_root(arg = nil)
        set_or_return(
          :json_keys_under_root, arg,
          :kind_of => [TrueClass, FalseClass]
        )
      end

      def json_overwrite_keys(arg = nil)
        set_or_return(
          :json_overwrite_keys, arg,
          :kind_of => [TrueClass, FalseClass]
        )
      end

      def json_add_error_key(arg = nil)
        set_or_return(
          :json_add_error_key, arg,
          :kind_of => [TrueClass, FalseClass]
        )
      end

      def json_message_key(arg = nil)
        set_or_return(
          :json_message_key, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def multiline_pattern(arg = nil)
        set_or_return(
          :multiline_pattern, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def multiline_negate(arg = nil)
        set_or_return(
          :multiline_negate, arg,
          :kind_of => [TrueClass, FalseClass]
        )
      end

      def multiline_match(arg = nil)
        set_or_return(
          :multiline_match, arg,
          :kind_of => String,
          :equal_to => %w[before after],
          :default => nil
        )
      end

      def multiline_flush_pattern(arg = nil)
        set_or_return(
          :multiline_flush_pattern, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def multiline_max_lines(arg = nil)
        set_or_return(
          :multiline_max_lines, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def multiline_timeout(arg = nil)
        set_or_return(
          :multiline_timeout, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def tail_files(arg = nil)
        set_or_return(
          :tail_files, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def pipeline(arg = nil)
        set_or_return(
          :pipeline, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def symlinks(arg = nil)
        set_or_return(
          :symlinks, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def backoff(arg = nil)
        set_or_return(
          :backoff, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def max_backoff(arg = nil)
        set_or_return(
          :max_backoff, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def backoff_factor(arg = nil)
        set_or_return(
          :backoff_factor, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def harvester_limit(arg = nil)
        set_or_return(
          :harvester_limit, arg,
          :kind_of => Integer,
          :default => nil
        )
      end

      def enabled(arg = nil)
        set_or_return(
          :enabled, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => true
        )
      end

      # v1.x
      def close_older(arg = nil)
        set_or_return(
          :close_older, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def force_close_files(arg = nil)
        set_or_return(
          :force_close_files, arg,
          :kind_of => [TrueClass, FalseClass],
          :default => nil
        )
      end

      def multiline(arg = nil)
        set_or_return(
          :multiline, arg,
          :kind_of => Hash,
          :default => nil
        )
      end
    end
  end
end
