#
# Cookbook Name:: filebeat
# Recipe:: default
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

if node['filebeat']['enable_localhost_output']
  node.default['filebeat']['config']['output']['elasticsearch']['hosts'] = ['localhost:9200']
  node.default['filebeat']['config']['output']['logstash']['hosts'] = ['localhost:5044']
end

include_recipe 'filebeat::install'
include_recipe 'filebeat::config'
