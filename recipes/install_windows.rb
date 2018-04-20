#
# Cookbook Name:: filebeat
# Recipe:: install_windows
#

package_url = if node['filebeat']['version'] < '5.0'
                node['filebeat']['package_url'] == 'auto' ? "https://download.elastic.co/beats/filebeat/filebeat-#{node['filebeat']['version']}-windows.zip" : node['filebeat']['package_url']
              else
                node['filebeat']['package_url'] == 'auto' ? "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{node['filebeat']['version']}-windows-#{node['filebeat']['arch']}.zip" : node['filebeat']['package_url']
              end

package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

remote_file 'filebeat_package_file' do
  path package_file
  source package_url
  not_if { ::File.exist?(package_file) }
end

directory node['filebeat']['windows']['base_dir'] do
  recursive true
  action :create
end

windows_zipfile node['filebeat']['windows']['base_dir'] do
  source package_file
  action :unzip
  not_if { ::File.exist?(node['filebeat']['conf_dir'] + '/install-service-filebeat.ps1') }
end
