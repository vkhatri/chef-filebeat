#
# Cookbook Name:: filebeat
# Recipe:: install_solaris
#
# Copyright 2016, Virender Khatri
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

package_url = node['filebeat']['package_url'] == 'auto' ? "https://download.elastic.co/beats/filebeat/filebeat-#{node['filebeat']['version']}-solaris.zip" : node['filebeat']['package_url']

directory node['filebeat']['solaris']['base_dir'] do
  mode '0755'
  action :create
end

package 'gnu-tar'

node.default['ark']['tar'] = '/bin/gtar'

ark 'filebeat' do
  url package_url
  path node['filebeat']['solaris']['base_dir']
  action :put
  only_if { !Dir.exist?("#{node['filebeat']['solaris']['base_dir']}/filebeat") || node['filebeat']['package_force_overwrite'] }
  notifies :restart, "service[#{node['filebeat']['service']['name']}]"
end

directory node['filebeat']['solaris']['manifest_directory'] do
  action :create
end

template "#{node['filebeat']['solaris']['base_dir']}/filebeat/start-stop-filebeat.sh" do
  source 'filebeat/start-stop-filebeat.sh.erb'
  variables(
    name: 'filebeat',
    daemon_path: "#{node['filebeat']['solaris']['base_dir']}/filebeat/filebeat",
    conf_path: node['filebeat']['conf_file']
  )
  notifies :restart, "service[#{node['filebeat']['service']['name']}]"
end

template "#{node['filebeat']['solaris']['manifest_directory']}/filebeat.xml" do
  source 'filebeat/filebeat.xml.erb'
  variables(
    name: 'application/filebeat',
    script: "#{node['filebeat']['solaris']['base_dir']}/filebeat/start-stop-filebeat.sh"
  )
  notifies :run, 'execute[load filebeat manifest]', :immediately
end

smf_standard_locations = [
  '/lib/svc/manifest',
  '/var/svc/manifes'
]

load_manifest_command = smf_standard_locations.any? { |i| node['filebeat']['solaris']['manifest_directory'].start_with? i } ? 'svcadm restart svc:/system/manifest-import' : "svccfg import #{node['filebeat']['solaris']['manifest_directory']}/filebeat.xml"

execute 'load filebeat manifest' do
  action :nothing
  command load_manifest_command
  notifies :restart, "service[#{node['filebeat']['service']['name']}]"
end
