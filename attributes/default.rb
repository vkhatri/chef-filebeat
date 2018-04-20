default['filebeat']['version'] = '6.2.4'
default['filebeat']['release'] = '1'
default['filebeat']['delete_prospectors_dir'] = false
default['filebeat']['purge_prospectors_dir'] = false
default['filebeat']['disable_service'] = false
default['filebeat']['package_url'] = 'auto'
default['filebeat']['package_force_overwrite'] = true

default['filebeat']['ignore_version'] = false
default['filebeat']['setup_repo'] = true
default['filebeat']['notify_restart'] = true
default['filebeat']['windows'] = { 'base_dir' => 'C:/opt/filebeat' }
default['filebeat']['solaris'] = {
  'base_dir' => '/opt',
  'manifest_directory' => '/var/svc/manifest/application'
}

default['filebeat']['service']['init_style'] = 'init' # or runit
default['filebeat']['service']['name'] = 'filebeat'
# see https://www.elastic.co/guide/en/beats/filebeat/current/command-line-options.html
default['filebeat']['service']['additional_command_line_options'] = ''
default['filebeat']['service']['ignore_failure'] = false
default['filebeat']['service']['retries'] = 0
default['filebeat']['service']['retry_delay'] = 2

default['filebeat']['arch'] = node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'x86'

default['filebeat']['log_dir'] = '/var/log/filebeat'
default['filebeat']['apt']['options'] = "-o Dpkg::Options::='--force-confnew' --force-yes"
