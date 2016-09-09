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
                                         "#{node['filebeat']['windows']['base_dir']}/filebeat-#{node['filebeat']['version']}-windows"
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
