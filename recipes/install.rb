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

package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(node['filebeat']['package_url']))

remote_file package_file do
  source node['filebeat']['package_url']
  not_if { ::File.exist?(package_file) }
end

package 'filebeat' do
  source package_file
  options '--force-confdef --force-confold'
  provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
end
