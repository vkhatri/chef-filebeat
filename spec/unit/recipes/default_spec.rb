require 'spec_helper'

describe 'filebeat::lwrp_test' do
  ############
  # filebeat_install
  ############
  shared_examples_for 'filebeat_install' do
    context 'linux_platforms' do
      it 'create filebeat install resource' do
        expect(chef_run).to create_filebeat_install('default')
      end

      it 'install filebeat package' do
        expect(chef_run).to install_package('filebeat')
      end

      it 'create prospector directory /etc/filebeat/conf.d' do
        expect(chef_run).to create_directory('/etc/filebeat/conf.d')
      end

      it 'create filebeat log directory /var/log/filebeat' do
        expect(chef_run).to create_directory('/var/log/filebeat')
      end
    end
  end

  context 'rhel-install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_install'], platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat_install'

    it 'adds elastic yum repository' do
      expect(chef_run).to create_elastic_repo('default')
    end

    it 'include yum-plugin-versionlock::default recipe' do
      expect(chef_run).to include_recipe('yum-plugin-versionlock::default')
    end

    it 'update yum_version_lock filebeat' do
      expect(chef_run).to update_yum_version_lock('filebeat')
    end
  end

  context 'ubuntu-install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_install'], platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat_install'

    it 'adds elastic apt repository' do
      expect(chef_run).to create_elastic_repo('default')
    end

    it 'add apt_preference filebeat' do
      expect(chef_run).to add_apt_preference('filebeat')
    end
  end

  context 'windows-install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_install'], platform: 'windows', version: '2012R2') do |node|
        node.automatic['platform_family'] = 'windows'
        node.automatic['kernel']['machine'] = 'x86_64'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    it 'create prospector directory C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/conf.d' do
      expect(chef_run).to create_directory('C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/conf.d')
    end

    it 'create prospector directory C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/logs' do
      expect(chef_run).to create_directory('C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/logs')
    end

    it 'download filebeat package file' do
      expect(chef_run).to create_remote_file('filebeat_package_file')
    end

    it 'create filebeat base dir C:/opt/filebeat' do
      expect(chef_run).to create_directory('C:/opt/filebeat')
    end

    it 'unzip filebeat package file to C:/opt/filebeat' do
      expect(chef_run).to unzip_windows_zipfile('C:/opt/filebeat')
    end

    it 'run powershell_script to install filebeat as service' do
      expect(chef_run).to run_powershell_script('install filebeat as service')
    end
  end

  ############
  # filebeat_service
  ############
  shared_examples_for 'filebeat_service' do
    context 'linux_platforms' do
      it 'create filebeat service resource' do
        expect(chef_run).to create_filebeat_service('default')
      end

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

  context 'rhel-service' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_service'], platform: 'centos', version: '6.8') do |node|
        node.automatic['platform_family'] = 'rhel'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat_service'
  end

  context 'ubuntu-service' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_service'], platform: 'ubuntu', version: '14.04') do |node|
        node.automatic['platform_family'] = 'debian'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat_service'
  end

  context 'windows-service' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['filebeat_service'], platform: 'windows', version: '2012R2') do |node|
        node.automatic['platform_family'] = 'windows'
        node.automatic['kernel']['machine'] = 'x86_64'
      end.converge(described_recipe)
    end

    let(:node) { chef_run.node }

    include_examples 'filebeat_service'
  end

  ############
  # filebeat_config
  ############
  # context 'rhel-config' do
  #   let(:chef_run) do
  #     ChefSpec::SoloRunner.new(step_into: ['filebeat_config'], platform: 'centos', version: '6.8') do |node|
  #       node.automatic['platform_family'] = 'rhel'
  #     end.converge(described_recipe)
  #   end
  #
  #   let(:node) { chef_run.node }
  #
  #   it 'configure /etc/filebeat/filebeat.yml' do
  #     expect(chef_run).to create_file('/etc/filebeat/filebeat.yml')
  #   end
  # end
  #
  # context 'ubuntu-config' do
  #   let(:chef_run) do
  #     ChefSpec::SoloRunner.new(step_into: ['filebeat_config'], platform: 'ubuntu', version: '14.04') do |node|
  #       node.automatic['platform_family'] = 'debian'
  #     end.converge(described_recipe)
  #   end
  #
  #   let(:node) { chef_run.node }
  #
  #   it 'configure /etc/filebeat/filebeat.yml' do
  #     expect(chef_run).to create_file('/etc/filebeat/filebeat.yml')
  #   end
  # end
  #
  # context 'windows-config' do
  #   let(:chef_run) do
  #     ChefSpec::SoloRunner.new(step_into: ['filebeat_config'], platform: 'windows', version: '2012R2') do |node|
  #       node.automatic['platform_family'] = 'windows'
  #       node.automatic['kernel']['machine'] = 'x86_64'
  #     end.converge(described_recipe)
  #   end
  #
  #   let(:node) { chef_run.node }
  #
  #   it 'configure C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/filebeat.yml' do
  #     expect(chef_run).to create_file('C:/opt/filebeat/filebeat-6.3.0-windows-x86_64/filebeat.yml')
  #   end
  # end
end
