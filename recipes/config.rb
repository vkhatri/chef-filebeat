#
# Cookbook Name:: filebeat
# Recipe:: config
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
  sensitive true
end

include_recipe 'filebeat::prospectors'

# ...and put this back the way we found them.
YAML::ENGINE.yamler = defaultengine if Psych::VERSION.start_with?('1')
