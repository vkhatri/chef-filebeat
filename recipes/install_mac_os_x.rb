#
# Cookbook Name:: filebeat
# Recipe:: install_mac_os_x
#
# Copyright 2017, Antek S. Baranski
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

include_recipe 'homebrew'

# The brew package does not create the 'filebeat' directory in '/etc'.
directory '/etc/filebeat' do
  action :create
  mode 0o0755
  owner 'root'
  group 'wheel'
end

# Need to drop the .plist file before the package install as brew will try to start the service immediately.
cookbook_file '/Library/LaunchDaemons/co.elastic.filebeat.plist' do
  action :create
  content 'co.elastic.filebeat.plist'
end

# This install depends on brew for the installation of filebeat.
package 'filebeat' do
  action :install
end
