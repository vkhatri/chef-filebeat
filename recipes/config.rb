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

# Filebeat and psych v1.x don't get along.
if Psych::VERSION.start_with?('1')
  defaultengine = YAML::ENGINE.yamler
  YAML::ENGINE.yamler = 'syck'
end

directory node['filebeat']['prospectors_dir'] do
  recursive true
  action :create
end

file node['filebeat']['conf_file'] do
  content JSON.parse(node['filebeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, "service[#{node['filebeat']['service']['name']}]" if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
end

prospectors = node['filebeat']['prospectors']

prospectors.each do |prospector, configuration|
  file "prospector-#{prospector}" do
    path ::File.join(node['filebeat']['prospectors_dir'], "prospector-#{prospector}.yml")
    content JSON.parse(configuration.to_json).to_yaml.lines.to_a[1..-1].join
    notifies :restart, "service[#{node['filebeat']['service']['name']}]" if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
  end
end

if node['platform'] == 'windows' # ~FC023
  powershell_script 'install filebeat as service' do
    code "& '#{node['filebeat']['conf_dir']}/install-service-filebeat.ps1'"
  end
end

include_recipe 'runit::default' if node['filebeat']['service']['init_style'] == 'runit'

ruby_block 'delay filebeat service start' do
  block do
  end
  notifies :start, "service[#{node['filebeat']['service']['name']}]"
  not_if { node['filebeat']['disable_service'] }
end

service_action = node['filebeat']['disable_service'] ? [:disable, :stop] : [:enable, :nothing]

if node['filebeat']['service']['init_style'] == 'runit'
  runit_cmd = "/usr/share/filebeat/bin/filebeat -c #{node['filebeat']['conf_file']} -path.home /usr/share/filebeat -path.config #{node['filebeat']['conf_dir']} -path.data /var/lib/filebeat -path.logs /var/log/filebeat"
  runit_service node['filebeat']['service']['name'] do
    options(
      'user' => 'root',
      'cmd' => runit_cmd
    )
    default_logger true
    action service_action
  end
else
  service node['filebeat']['service']['name'] do
    provider Chef::Provider::Service::Solaris if node['platform_family'] == 'solaris2'
    retries node['filebeat']['service']['retries']
    retry_delay node['filebeat']['service']['retry_delay']
    supports :status => true, :restart => true
    action service_action
  end
end

# ...and put this back the way we found them.
YAML::ENGINE.yamler = defaultengine if Psych::VERSION.start_with?('1')
