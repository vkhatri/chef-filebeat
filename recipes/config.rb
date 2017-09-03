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

directory node['filebeat']['log_dir']

file node['filebeat']['conf_file'] do
  content JSON.parse(node['filebeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, "service[#{node['filebeat']['service']['name']}]" if node['filebeat']['notify_restart'] && !node['filebeat']['disable_service']
  mode 0o600
end

include_recipe 'filebeat::prospectors'

# ...and put this back the way we found them.
YAML::ENGINE.yamler = defaultengine if Psych::VERSION.start_with?('1')
