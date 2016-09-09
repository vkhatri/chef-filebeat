default['filebeat']['yum']['baseurl'] = 'https://packages.elastic.co/beats/yum/el/$basearch'
default['filebeat']['yum']['description'] = 'Elastic Beats Repository'
default['filebeat']['yum']['gpgcheck'] = true
default['filebeat']['yum']['enabled'] = true
default['filebeat']['yum']['gpgkey'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
default['filebeat']['yum']['metadata_expire'] = '3h'
default['filebeat']['yum']['action'] = :create

default['filebeat']['apt']['uri'] = 'https://packages.elastic.co/beats/apt'
default['filebeat']['apt']['description'] = 'Elastic Beats Repository'
default['filebeat']['apt']['components'] = %w(stable main)
default['filebeat']['apt']['distribution'] = ''
# apt package install options
default['filebeat']['apt']['options'] = "-o Dpkg::Options::='--force-confnew'"
default['filebeat']['apt']['action'] = :add
default['filebeat']['apt']['key'] = 'https://packages.elasticsearch.org/GPG-KEY-elasticsearch'
