#
# Cookbook Name:: filebeat
# Resource:: filebeat_install_preview
#

resource_name :filebeat_install_preview

property :version, String, default: '6.0.0-rc2'
property :service_name, String, default: 'filebeat'
property :notify_restart, [TrueClass, FalseClass], default: true
property :disable_service, [TrueClass, FalseClass], default: false
property :delete_prospectors_dir, [TrueClass, FalseClass], default: false
property :package_url, String, default: 'auto'

property :conf_dir, [String, NilClass], default: nil
property :prospectors_dir, [String, NilClass], default: nil
property :log_dir, [String, NilClass], default: nil

property :windows_base_dir, String, default: 'C:/opt/filebeat'

property :apt_install_options, [String, NilClass], default: nil

default_action :create

action :create do
  new_resource.conf_dir = new_resource.conf_dir || default_config_dir(new_resource.version, new_resource.windows_base_dir)
  new_resource.prospectors_dir = new_resource.prospectors_dir || default_prospectors_dir(new_resource.conf_dir)
  new_resource.log_dir = new_resource.log_dir || default_log_dir(new_resource.conf_dir)

  with_run_context(:root) do
    edit_resource(:service, new_resource.service_name) do
      action :nothing
    end
  end

  if %w[fedora rhel amazon].include?(node['platform_family'])
    package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i686'
    package_family = 'rpm'
  elsif node['platform_family'] == 'debian'
    package_arch = node['kernel']['machine'] =~ /x86_64/ ? 'amd64' : 'i386'
    package_family = 'deb'
  else
    raise "platform_family #{node['platform_family']} not supported"
  end

  package_url = new_resource.package_url == 'auto' ? "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-#{new_resource.version}-#{package_arch}.#{package_family}" : new_resource.package_url
  package_file = ::File.join(Chef::Config[:file_cache_path], ::File.basename(package_url))

  remote_file 'filebeat_package_file' do
    path package_file
    source package_url
    not_if { ::File.exist?(package_file) }
  end

  package 'filebeat' do # ~FC109
    source package_file
    provider Chef::Provider::Package::Dpkg if node['platform_family'] == 'debian'
  end

  directory new_resource.log_dir

  prospectors_dir_action = new_resource.delete_prospectors_dir ? %i[delete create] : %i[create]

  directory new_resource.prospectors_dir do
    recursive true
    action prospectors_dir_action
  end
end

action :delete do
  with_run_context(:root) do
    edit_resource(:service, new_resource.service_name) do
      action :stop, :disable
    end
  end

  package 'filebeat' do
    action :remove
  end

  directory '/etc/filebeat' do
    action :delete
    recursive true
  end
end
