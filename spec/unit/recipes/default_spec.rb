require 'spec_helper'

describe 'filebeat::default' do
  shared_examples_for 'filebeat' do
    context 'all_platforms' do
      it 'run ruby_block delay filebeat service start' do
        expect(chef_run).to run_ruby_block('delay filebeat service start')
      end

      it 'enable filebeat service' do
        expect(chef_run).to enable_service('filebeat')
      end
    end
  end

  context 'rhel' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.4') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

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
  end

  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

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

    it 'include recipe filebeat::install_package' do
      expect(chef_run).to include_recipe('filebeat::install_package')
    end

    it 'install filebeat package' do
      expect(chef_run).to install_package('filebeat')
    end
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.automatic['platform_family'] = 'windows'
      end.converge(described_recipe)
    end

    include_examples 'filebeat'

    it 'create prospector directory C:/opt/filebeat/filebeat-1.2.1-windows/conf.d' do
      expect(chef_run).to create_directory('C:/opt/filebeat/filebeat-1.2.1-windows/conf.d')
    end

    it 'configure C:/opt/filebeat/filebeat-1.2.1-windows/filebeat.yml' do
      expect(chef_run).to create_file('C:/opt/filebeat/filebeat-1.2.1-windows/filebeat.yml')
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
  end
end
