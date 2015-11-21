#
# Cookbook Name:: filebeat
# Recipe:: install
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

if node['filebeat']['package_url'] == 'auto'
  package_url = value_for_platform_family(
    'debian' =>        "https://download.elastic.co/beats/filebeat/filebeat_#{node['filebeat']['version']}_amd64.deb",
    %w(rhel fedora) => "https://download.elastic.co/beats/filebeat/filebeat-#{node['filebeat']['version']}-x86_64.rpm",
    'windows' =>       "https://download.elastic.co/beats/filebeat/filebeat-#{node['filebeat']['version']}-windows.zip"
  )
else
  package_url = node['filebeat']['package_url']
end

package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

remote_file 'filebeat_package_file' do
  path package_file
  source package_url
  not_if { ::File.exist?(package_file) }
end

package 'filebeat' do
  source package_file
  options '--force-confdef --force-confold' if node['platform_family'] == 'debian'
  provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
  not_if { node['platform'] == 'windows' }
end

directory node['filebeat']['windows']['base_dir'] do
  recursive true
  action :create
  only_if { node['platform'] == 'windows' }
end

windows_zipfile node['filebeat']['windows']['base_dir'] do
  source package_file
  action :unzip
  only_if { node['platform'] == 'windows' }
  not_if  { ::File.exist?(node['filebeat']['windows']['base_dir'] + "/filebeat-#{node['filebeat']['version']}-windows" + '/install-service-filebeat.ps1') }
end
