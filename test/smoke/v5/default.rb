# # encoding: utf-8

# Inspec test for recipe elastic_beats_repo::v5

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if %w[redhat fedora amazon].include?(os[:family])
  describe file('/etc/yum.repos.d/beats.repo') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/5.x/yum} }
  end
else
  describe file('/etc/apt/sources.list.d/beats.list') do
    its('content') { should match %r{https://artifacts.elastic.co/packages/5.x/apt} }
  end
end

describe package('filebeat') do
  it { should be_installed }
  its('version') { should match '5.6.9' }
end

describe service('filebeat') do
  it { should be_installed }
  it { should be_running }
end

if os.release !~ /^7\.|^2\./
  describe service('filebeat') do
    it { should be_enabled }
  end
end
