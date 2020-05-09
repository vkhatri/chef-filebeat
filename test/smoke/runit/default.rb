describe command('filebeat test config') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match 'Config OK' }
end
