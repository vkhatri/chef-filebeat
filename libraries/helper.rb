require 'fileutils'

def purge_prospectors_dir(prospectors_dir)
  valid_prospectors = []

  # collect lwrp filebeat_prospector prospectors
  run_context.resource_collection.select { |resource| valid_prospectors.push("lwrp-prospector-#{resource.name}.yml") if resource.resource_name == :filebeat_prospector }

  # prospectors yml files to clean up
  extra_prospectors = Dir.entries(prospectors_dir).reject { |a| valid_prospectors.include?(a) || a.match(/^custom-prospector-.*yml$/) }.sort
  extra_prospectors -= ['.', '..']

  extra_prospectors.each do |prospector|
    prospector_file = ::File.join(prospectors_dir, prospector)
    FileUtils.rm prospector_file
    Chef::Log.warn("deleted filebeat prospector configuration file #{prospector_file}")
  end

  Chef::Log.info("\n could not find any filebeat prospector configuration file to purge") if extra_prospectors.empty?
end

def machine_arch
  node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'x86'
end

def win_package_url(version, package_url)
  package_url = if version < '5.0'
                  package_url == 'auto' ? "https://download.elastic.co/beats/filebeat/filebeat-#{version}-windows.zip" : package_url
                else
                  package_url == 'auto' ? "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{version}-windows-#{machine_arch}.zip" : package_url
                end
  package_url
end

def default_config_dir(version, windows_base_dir)
  conf_dir = if node['platform'] == 'windows'
               if version < '5.0'
                 "#{windows_base_dir}/filebeat-#{version}-windows"
               else
                 "#{windows_base_dir}/filebeat-#{version}-windows-#{machine_arch}"
               end
             else
               '/etc/filebeat'
             end
  conf_dir
end

def default_conf_file(conf_dir)
  node['platform'] == 'windows' ? "#{conf_dir}/filebeat.yml" : ::File.join(conf_dir, 'filebeat.yml')
end

def default_prospectors_dir(conf_dir)
  node['platform'] == 'windows' ? "#{conf_dir}/conf.d" : ::File.join(conf_dir, 'conf.d')
end

def check_beat_resource(run_context, resource_type, resource_name = 'default')
  run_context.resource_collection.find(resource_type => resource_name)
rescue StandardError
  nil
end

def find_beat_resource(run_context, resource_type, resource_name = 'default')
  run_context.resource_collection.find(resource_type => resource_name)
end

def default_log_dir(conf_dir)
  node['platform'] == 'windows' ? "#{conf_dir}/logs" : '/var/log/filebeat'
end
