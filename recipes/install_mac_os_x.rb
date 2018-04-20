#
# Cookbook Name:: filebeat
# Recipe:: install_mac_os_x
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
