filebeat_install_preview 'default'

filebeat_config 'default' do
  config node['filebeat_test']['filebeat_config']
end

node['filebeat_test']['prospectors'].each do |p_name, p_config|
  filebeat_prospector p_name do
    config p_config
  end
end

filebeat_service 'default'
