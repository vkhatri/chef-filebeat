#
# Cookbook Name:: filebeat
# Recipe:: install_package_preview
#

if %w[fedora rhel amazon].include?(node['platform_family'])
  package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i686'
  package_family = 'rpm'
elsif node['platform_family'] == 'debian'
  package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : 'i386'
  package_family = 'deb'
else
  raise "platform_family #{node['platform_family']} not supported"
end

package_url = node['filebeat']['package_url'] == 'auto' ? "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{node['filebeat']['version']}-#{package_arch}.#{package_family}" : node['filebeat']['package_url']
package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

package 'apt-transport-https' if node['platform_family'] == 'debian'

remote_file 'filebeat_package_file' do
  path package_file
  source package_url
  not_if { ::File.exist?(package_file) }
end

package 'filebeat' do # ~FC109
  source package_file
  provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
end
