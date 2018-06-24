filebeat_install 'default' do
  disable_service true
  notify_restart false
end

filebeat_config 'default' do
  config node['filebeat_test']['filebeat_config']
  notify_restart false
end

node['filebeat_test']['prospectors'].each do |p_name, p_config|
  filebeat_prospector p_name do
    config p_config
    notify_restart false
  end
end

filebeat_runit_service 'default'
