filebeat_install 'default'

filebeat_config 'default' do
  config node['filebeat_test']['filebeat_config']
  # filebeat_install_resource_name 'default'
end

node['filebeat_test']['prospectors'].each do |p_name, p_config|
  filebeat_prospector p_name do
    config p_config
    # filebeat_install_resource_name 'default'
  end
end

filebeat_service 'default' do
  # filebeat_install_resource_name 'default'
  purge_prospectors_dir true
end
