#
# Cookbook Name:: filebeat
# Recipe:: config
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

directory node['filebeat']['prospectors_dir'] do
  recursive true
  action :create
end

file node['filebeat']['conf_file'] do
  content JSON.parse(node['filebeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, 'service[filebeat]' if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
end

prospectors = node['filebeat']['prospectors']

prospectors.each do |prospector, configuration|
  file "prospector-#{prospector}" do
    path ::File.join(node['filebeat']['prospectors_dir'], "prospector-#{prospector}.yml")
    content JSON.parse(configuration.to_json).to_yaml.lines.to_a[1..-1].join
    notifies :restart, 'service[filebeat]' if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
  end
end

powershell 'install filebeat as service' do
  code "#{node['filebeat']['windows']['base_dir']}/filebeat-#{node['filebeat']['version']}-windows/install-service-filebeat.ps1"
  only_if { node['platform'] == 'windows' }
end

ruby_block 'delay filebeat service start' do
  block do
  end
  notifies :start, 'service[filebeat]'
  not_if { node['filebeat']['disable_service'] }
end

service_action = node['filebeat']['disable_service'] ? [:disable, :stop] : [:enable, :nothing]

service 'filebeat' do
  supports :status => true, :restart => true
  action service_action
end
