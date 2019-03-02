name 'filebeat'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures Elastic Filebeat'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.3.1'
source_url 'https://github.com/vkhatri/chef-filebeat' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-filebeat/issues' if respond_to?(:issues_url)
chef_version '>= 12.14' if respond_to?(:chef_version)

depends 'homebrew', '~> 4.2'
depends 'elastic_repo', '>= 1.1.1'
depends 'yum-plugin-versionlock', '>= 0.1.2'
depends 'runit'
depends 'windows'

%w[windows debian ubuntu centos amazon redhat fedora].each do |os|
  supports os
end
