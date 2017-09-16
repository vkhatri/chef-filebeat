require 'spec_helper'

describe 'filebeat::default' do
  shared_examples_for 'filebeat' do
    context 'all_platforms' do
      it 'run ruby_block delay run purge prospectors dir' do
        expect(chef_run).to run_ruby_block('delay run purge prospectors dir')
      end

      it 'run ruby_block delay filebeat service start' do
        expect(chef_run).to run_ruby_block('delay filebeat service start')
      end

      it 'enable filebeat service' do
        expect(chef_run).to enable_service('filebeat')
      end
    end
  end

  context 'runit' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['filebeat']['service']['init_style'] = 'runit'
        node.override['filebeat']['purge_prospectors_dir'] = true
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    it 'include runit::default recipe' do
      expect(chef_run).to include_recipe('runit::default')
    end

    it 'enable filebeat runit service' do
      expect(chef_run).to enable_runit_service('filebeat')
    end
  end

  context 'preview' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['filebeat']['version'] = '6.0.0-beta1'
        node.override['filebeat']['purge_prospectors_dir'] = true
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    it 'include filebeat::install_package_preview recipe' do
      expect(chef_run).to include_recipe('filebeat::install_package_preview')
    end

    it 'install filebeat package' do
      expect(chef_run).to install_package('filebeat')
    end

    it 'download filebeat package file' do
      expect(chef_run).to create_remote_file('filebeat_package_file')
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
        node.override['filebeat']['ignore_version'] = true
        node.override['filebeat']['purge_prospectors_dir'] = true
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat'

    it 'create prospector directory /etc/filebeat/conf.d' do
      expect(chef_run).to create_directory('/etc/filebeat/conf.d')
    end

    it 'configure /etc/filebeat/filebeat.yml' do
      expect(chef_run).to create_file('/etc/filebeat/filebeat.yml')
    end

    it 'adds beats yum repository' do
      expect(chef_run).to create_yum_repository('beats')
    end

    it 'include recipe filebeat::install_package' do
      expect(chef_run).to include_recipe('filebeat::install_package')
    end

    it 'install filebeat package' do
      expect(chef_run).to install_package('filebeat')
    end

    it "has correct default['filebeat']['config']['filebeat.registry_file']" do
      expect(node['filebeat']['config']['filebeat.registry_file']).to eq('/var/lib/filebeat/registry')
    end

    it "has correct default['filebeat']['config']['filebeat.config_dir']" do
      expect(node['filebeat']['config']['filebeat.config_dir']).to eq('/etc/filebeat/conf.d')
    end

    it "has correct default['filebeat']['conf_dir']" do
      expect(node['filebeat']['conf_dir']).to eq('/etc/filebeat')
    end

    it 'add yum_version_lock filebeat' do
      expect(chef_run).not_to update_yum_version_lock('filebeat')
    end
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
        node.override['filebeat']['ignore_version'] = true
        node.override['filebeat']['purge_prospectors_dir'] = true
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat'

    it 'create prospector directory /etc/filebeat/conf.d' do
      expect(chef_run).to create_directory('/etc/filebeat/conf.d')
    end

    it 'configure /etc/filebeat/filebeat.yml' do
      expect(chef_run).to create_file('/etc/filebeat/filebeat.yml')
    end

    it 'adds beats apt repository' do
      expect(chef_run).to add_apt_repository('beats')
    end

    it 'add apt_preference filebeat' do
      expect(chef_run).not_to add_apt_preference('filebeat')
    end

    it 'include recipe filebeat::install_package' do
      expect(chef_run).to include_recipe('filebeat::install_package')
    end

    it 'install filebeat package' do
      expect(chef_run).to install_package('filebeat')
    end

    it 'install apt-transport-https package' do
      expect(chef_run).to install_package('apt-transport-https')
    end

    it "has correct default['filebeat']['config']['filebeat.registry_file']" do
      expect(node['filebeat']['config']['filebeat.registry_file']).to eq('/var/lib/filebeat/registry')
    end

    it "has correct default['filebeat']['config']['filebeat.config_dir']" do
      expect(node['filebeat']['config']['filebeat.config_dir']).to eq('/etc/filebeat/conf.d')
    end

    it "has correct default['filebeat']['conf_dir']" do
      expect(node['filebeat']['conf_dir']).to eq('/etc/filebeat')
    end
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
        node.automatic['platform_family'] = 'windows'
        node.automatic['platform_family'] = 'windows'
        node.automatic['kernel']['machine'] = 'x86_64'
        node.override['filebeat']['purge_prospectors_dir'] = true
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat'

    it 'create prospector directory C:/opt/filebeat/filebeat-5.6.0-windows-x86_64/conf.d' do
      expect(chef_run).to create_directory('C:/opt/filebeat/filebeat-5.6.0-windows-x86_64/conf.d')
    end

    it 'configure C:/opt/filebeat/filebeat-5.6.0-windows/filebeat.yml' do
      expect(chef_run).to create_file('C:/opt/filebeat/filebeat-5.6.0-windows-x86_64/filebeat.yml')
    end

    it 'include recipe filebeat::install_windows' do
      expect(chef_run).to include_recipe('filebeat::install_windows')
    end

    it 'download filebeat package file' do
      expect(chef_run).to create_remote_file('filebeat_package_file')
    end

    it 'create filebeat base dir C:/opt/filebeat' do
      expect(chef_run).to create_directory('C:/opt/filebeat')
    end

    it 'unzip filebeat package file to C:/opt/filebeat' do
      expect(chef_run).to unzip_windows_zipfile_to('C:/opt/filebeat')
    end

    it 'run powershell_script to install filebeat as service' do
      expect(chef_run).to run_powershell_script('install filebeat as service')
    end

    it "has correct default['filebeat']['conf_dir']" do
      expect(node['filebeat']['conf_dir']).to eq('C:/opt/filebeat/filebeat-5.6.0-windows-x86_64')
    end

    it "has correct default['filebeat']['config']['filebeat.registry_file']" do
      expect(node['filebeat']['config']['filebeat.registry_file']).to eq('C:/opt/filebeat/filebeat-5.6.0-windows-x86_64/registry')
    end

    it "has correct default['filebeat']['config']['filebeat.config_dir']" do
      expect(node['filebeat']['config']['filebeat.config_dir']).to eq('C:/opt/filebeat/filebeat-5.6.0-windows-x86_64/conf.d')
    end
  end
end
