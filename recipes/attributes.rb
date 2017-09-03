#
# Cookbook Name:: filebeat
# Recipe:: attributes
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

node.default['filebeat']['conf_dir'] = if node['platform'] == 'windows'
                                         if node['filebeat']['version'] < '5.0'
                                           "#{node['filebeat']['windows']['base_dir']}/filebeat-#{node['filebeat']['version']}-windows"
                                         else
                                           "#{node['filebeat']['windows']['base_dir']}/filebeat-#{node['filebeat']['version']}-windows-#{node['filebeat']['arch']}"
                                         end
                                       else
                                         '/etc/filebeat'
                                       end
node.default['filebeat']['conf_file'] = if node['platform'] == 'windows'
                                          "#{node['filebeat']['conf_dir']}/filebeat.yml"
                                        else
                                          ::File.join(node['filebeat']['conf_dir'], 'filebeat.yml')
                                        end
node.default['filebeat']['prospectors_dir'] = if node['platform'] == 'windows'
                                                "#{node['filebeat']['conf_dir']}/conf.d"
                                              else
                                                ::File.join(node['filebeat']['conf_dir'], 'conf.d')
                                              end

# filebeat.yml configuration attributes
node.default['filebeat']['config']['filebeat.registry_file'] = if node['platform'] == 'windows'
                                                                 "#{node['filebeat']['conf_dir']}/registry"
                                                               else
                                                                 '/var/lib/filebeat/registry'
                                                               end

node.default['filebeat']['config']['filebeat.config_dir'] = node['filebeat']['prospectors_dir']

node.default['filebeat']['config']['logging.files']['path'] = if node['platform'] == 'windows'
                                                                "#{node['filebeat']['conf_dir']}/logs"
                                                              else
                                                                node['filebeat']['log_dir']
                                                              end

# filebeat repository attributes
if node['filebeat']['version'] < '5.0'
  node.default['filebeat']['yum']['baseurl'] = 'https://packages.elastic.co/beats/yum/el/$basearch'
  node.default['filebeat']['yum']['gpgkey'] = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
  node.default['filebeat']['apt']['uri'] = 'https://packages.elastic.co/beats/apt'
  node.default['filebeat']['apt']['key'] = 'https://packages.elastic.co/GPG-KEY-elasticsearch'
else
  major_version = node['filebeat']['version'].split('.')[0]
  node.default['filebeat']['yum']['baseurl'] = "https://artifacts.elastic.co/packages/#{major_version}.x/yum"
  node.default['filebeat']['yum']['gpgkey'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
  node.default['filebeat']['apt']['uri'] = "https://artifacts.elastic.co/packages/#{major_version}.x/apt"
  node.default['filebeat']['apt']['key'] = 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
end
