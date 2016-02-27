#
# Cookbook Name:: filebeat
# Recipe:: package
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

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'beats' do
    uri node['filebeat']['apt']['uri']
    components node['filebeat']['apt']['components']
    key node['filebeat']['apt']['key']
    action node['filebeat']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'beats' do
    description node['filebeat']['yum']['description']
    baseurl node['filebeat']['yum']['baseurl']
    gpgcheck node['filebeat']['yum']['gpgcheck']
    gpgkey node['filebeat']['yum']['gpgkey']
    enabled node['filebeat']['yum']['enabled']
    metadata_expire node['filebeat']['yum']['metadata_expire']
    action node['filebeat']['yum']['action']
  end
end

package 'filebeat' do
  version node['platform_family'] == 'rhel' ? node['filebeat']['version'] + '-1' : node['filebeat']['version']
  notifies :restart, 'service[filebeat]'
end
