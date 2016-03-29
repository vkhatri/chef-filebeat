name 'filebeat'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures Elastic Filebeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.8'
source_url 'https://github.com/vkhatri/chef-filebeat' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-filebeat/issues' if respond_to?(:issues_url)

depends 'windows'
depends 'powershell'
depends 'apt'
depends 'yum'

%w(windows ubuntu centos amazon redhat fedora).each do |os|
  supports os
end
