filebeat_prospector 'test1' do
  paths %w[/var/log/test1.log]
  type 'log'
  fields 'type' => 'test1_logs'
end

filebeat_prospector 'test2' do
  paths %w[/var/log/test2.log]
  type 'log'
  fields 'type' => 'test2_logs'
end
