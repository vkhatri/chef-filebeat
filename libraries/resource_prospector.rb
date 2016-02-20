require 'chef/resource'
# https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-configuration-details.html

class Chef
  class Resource
    # filebeat prospector resource
    class FilebeatProspector < Chef::Resource
      identity_attr :name

      def initialize(name, run_context = nil)
        super
        @resource_name = :filebeat_prospector
        @provides = :filebeat_prospector
        @provider = Chef::Provider::FilebeatProspector
        @action = :create
        @allowed_actions = [:create, :delete, :nothing]
        @name = name
      end

      def paths(arg = nil)
        set_or_return(
          :paths, arg,
          :kind_of => Array,
          :default => nil
        )
      end

      def type(arg = nil)
        set_or_return(
          :type, arg,
          :kind_of => String,
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

      def document_type(arg = nil)
        set_or_return(
          :document_type, arg,
          :kind_of => String,
          :default => nil
        )
      end

      def input_type(arg = nil)
        set_or_return(
          :input_type, arg,
          :kind_of => String,
          :equal_to => %w(log stdin),
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

      def harvester_buffer_size(arg = nil)
        set_or_return(
          :harvester_buffer_size, arg,
          :kind_of => Integer,
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

      def force_close_files(arg = nil)
        set_or_return(
          :force_close_files, arg,
          :kind_of => [TrueClass, FalseClass],
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

      def exclude_lines(arg = nil)
        set_or_return(
          :exclude_lines, arg,
          :kind_of => Array,
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
