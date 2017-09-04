#
# Cookbook Name:: filebeat
# Recipe:: install_package_preview
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

package 'filebeat' do
  source package_file
  provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
end
