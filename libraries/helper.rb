require 'fileutils'

def purge_prospectors_dir
  valid_prospectors = []

  # collect lwrp filebeat_prospector prospectors
  run_context.resource_collection.select { |resource| valid_prospectors.push("lwrp-prospector-#{resource.name}.yml") if resource.is_a?(Chef::Resource::FilebeatProspector) }

  # prospectors yml files to clean up
  extra_prospectors = Dir.entries(node['filebeat']['prospectors_dir']).reject { |a| valid_prospectors.include?(a) || a.match(/^custom-prospector-.*yml$/) }.sort
  extra_prospectors -= ['.', '..']

  extra_prospectors.each do |prospector|
    prospector_file = ::File.join(node['filebeat']['prospectors_dir'], prospector)
    FileUtils.rm prospector_file
    Chef::Log.warn("deleted filebeat prospector configuration file #{prospector_file}")
  end

  Chef::Log.info("\n could not find any filebeat prospector configuration file to purge") if extra_prospectors.empty?
end
