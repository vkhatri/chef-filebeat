#
# Cookbook Name:: filebeat
# Recipe:: service
#

if node['platform'] == 'windows' # ~FC023
  powershell_script 'install filebeat as service' do
    code "& '#{node['filebeat']['conf_dir']}/install-service-filebeat.ps1'"
  end
end

include_recipe 'runit::default' if node['filebeat']['service']['init_style'] == 'runit'

ruby_block 'delay run purge prospectors dir' do
  block do
  end
  notifies :run, 'ruby_block[purge_prospectors_dir]'
end

ruby_block 'purge_prospectors_dir' do
  block do
    purge_prospectors_dir
  end
  only_if { node['filebeat']['purge_prospectors_dir'] }
  action :nothing
end

ruby_block 'delay filebeat service start' do
  block do
  end
  notifies :start, "service[#{node['filebeat']['service']['name']}]"
  not_if { node['filebeat']['disable_service'] }
end

service_action = node['filebeat']['disable_service'] ? %i[disable stop] : %i[enable nothing]

if node['filebeat']['service']['init_style'] == 'runit'
  runit_cmd = "/usr/share/filebeat/bin/filebeat -c #{node['filebeat']['conf_file']} -path.home /usr/share/filebeat -path.config #{node['filebeat']['conf_dir']} -path.data /var/lib/filebeat -path.logs /var/log/filebeat #{node['filebeat']['service']['additional_command_line_options']}"
  runit_service node['filebeat']['service']['name'] do
    options(
      'user' => 'root',
      'cmd' => runit_cmd
    )
    default_logger true
    action service_action
    ignore_failure node['filebeat']['service']['ignore_failure']
  end
else
  service node['filebeat']['service']['name'] do
    provider Chef::Provider::Service::Solaris if node['platform_family'] == 'solaris2'
    retries node['filebeat']['service']['retries']
    retry_delay node['filebeat']['service']['retry_delay']
    supports :status => true, :restart => true
    action service_action
    ignore_failure node['filebeat']['service']['ignore_failure']
  end
end
