#
# Cookbook Name:: filebeat
# Recipe:: attributes
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

node.default['filebeat']['log_dir'] = if node['platform'] == 'windows'
                                        "#{node['filebeat']['conf_dir']}/logs"
                                      else
                                        '/var/log/filebeat'
                                      end

node.default['elastic_beats_repo']['version'] = node['filebeat']['version']
