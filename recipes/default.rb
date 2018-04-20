#
# Cookbook Name:: filebeat
# Recipe:: default
#

include_recipe 'filebeat::attributes'

# install filebeat
case node['platform']
when 'mac_os_x'
  include_recipe 'filebeat::install_mac_os_x'
when 'windows'
  include_recipe 'filebeat::install_windows'
when 'solaris2'
  include_recipe 'filebeat::install_solaris'
else
  if node['filebeat']['version'].scan(/rc|beta|alpha/).empty?
    include_recipe 'yum-plugin-versionlock::default' if %w[fedora rhel amazon].include?(node['platform_family'])
    include_recipe 'filebeat::install_package'
  else
    include_recipe 'filebeat::install_package_preview'
  end
end

# configure filebeat
include_recipe 'filebeat::config'

include_recipe 'filebeat::service'
