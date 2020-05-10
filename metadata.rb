name 'filebeat'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Installs/Configures Elastic Filebeat'
version '2.4.0'
source_url 'https://github.com/vkhatri/chef-filebeat'
issues_url 'https://github.com/vkhatri/chef-filebeat/issues'
chef_version '>= 12.14'

depends 'homebrew', '~> 4.2'
depends 'elastic_repo', '>= 1.2.0'
depends 'yum-plugin-versionlock', '>= 0.2.1'
depends 'runit'
depends 'windows'

%w(windows debian ubuntu centos amazon redhat fedora).each do |os|
  supports os
end
