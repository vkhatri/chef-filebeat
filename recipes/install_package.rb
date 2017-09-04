#
# Cookbook Name:: filebeat
# Recipe:: install_package
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

version_string = %w[fedora rhel amazon].include?(node['platform_family']) ? "#{node['filebeat']['version']}-#{node['filebeat']['release']}" : node['filebeat']['version']

case node['platform_family']
when 'debian'
  package 'apt-transport-https'

  if node['filebeat']['setup_repo']
    # apt repository configuration
    apt_repository 'beats' do
      uri node['filebeat']['apt']['uri']
      components node['filebeat']['apt']['components']
      key node['filebeat']['apt']['key']
      distribution node['filebeat']['apt']['distribution']
      action node['filebeat']['apt']['action']
    end

    unless node['filebeat']['ignore_version'] # ~FC023
      apt_preference 'filebeat' do
        pin          "version #{node['filebeat']['version']}"
        pin_priority '700'
      end
    end
  end

when 'fedora', 'rhel', 'amazon'
  if node['filebeat']['setup_repo']
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

    unless node['filebeat']['ignore_version'] # ~FC023
      yum_version_lock 'filebeat' do
        version node['filebeat']['version']
        release node['filebeat']['release']
        action :update
      end
    end
  end
else
  raise "platform_family #{node['platform_family']} not supported"
end

package 'filebeat' do # ~FC009
  version version_string unless node['filebeat']['ignore_version']
  options node['filebeat']['apt']['options'] if node['filebeat']['apt']['options'] && node['platform_family'] == 'debian'
  notifies :restart, "service[#{node['filebeat']['service']['name']}]" if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
  if %w[rhel amazon].include?(node['platform_family'])
    flush_cache(:before => true)
    allow_downgrade true
  end
end
