filebeat Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-filebeat.svg)](https://github.com/vkhatri/chef-filebeat) [![Build Status](https://travis-ci.org/vkhatri/chef-filebeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-filebeat)

This is a [Chef] cookbook to manage [Filebeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/filebeat).


## Most Recent Release

```ruby
cookbook 'filebeat', '~> 2.1.0'
```


## From Git

```ruby
cookbook 'filebeat', github: 'vkhatri/chef-filebeat',  tag: 'v2.1.0'
```


## Repository

```
https://github.com/vkhatri/chef-filebeat
```


## Supported OS

- Windows
- Amazon Linux
- CentOS
- Fedora
- Ubuntu
- Debian
- Mac OSX

Also works on Solaris zones given a physical Solaris 11.2 server. For that, use the .kitchen.zone.yml file. Check usage at (https://github.com/criticalmass/kitchen-zone). You will need an url to a filebeat package that works on Solaris 11.2. Checkout Building-Filebeat-On-Solaris11.md for instructions to build a filebeat package.


## Supported Chef

- Chef 12 (last tested on 12.21.4)

- Chef 13 (last tested on 13.3.42)


## Supported Filebeat

- 5.x
- 6.x


## Cookbook Dependency

- `homebrew`
- `elastic_repo`
- `yum-plugin-versionlock`
- `runit`
- `windows`


## Recipes

- lwrp_test - LWRP examples recipe


## LWRP Resources

- `filebeat_config` - filebeat configuration resource

- `filebeat_install` - filebeat install resource

- `filebeat_install_preview` - filebeat preview package install resource

- `filebeat_service` - filebeat service resource

- `filebeat_prospector` - filebeat prospector resource


## Limitations

The Mac OSX setup only allows for package installs and depends on brew, this means that version selection and preview build installs are not supported.


## LWRP filebeat_install

LWRP `filebeat_install` installs filebeat, creates log/prospectors directories, and also enable filebeat service.

Below attributes are derived using helper methods and also used by other LWRP.

- `conf_dir`
- `prospectors_dir`
- `log_dir`

**LWRP example**

```ruby
filebeat_install 'default' do
  [options ..]
end
```


**LWRP Options**

- *action* (optional)	- default `:create`, options: :create, :delete
- *version* (optional, String)	- default `6.3.0`, filebeat version
- *release* (optional, String)	- default `1`, filebeat release version, used by `rhel` family package resource
- *setup_repo* (optional, Boolean) - default `true`, set to `false`, to skip elastic repository setup using cookbook `elastic_repo`
- *ignore_package_version* (optional, Boolean) - default `false`, set to true, to install latest available yum/apt filebeat package
- *service_name* (optional, String) - default `filebeat`, filebeat service name, must be common across resources
- *disable_service* (optional, Boolean) - default `false`, set to `true`, to disable filebeat service
- *notify_restart* (optional, Boolean) - default `true`, set to `false`, to ignore filebeat service restart notify
- *delete_prospectors_dir* (optional, Boolean) - default `false`, set to `true`, to purge prospectors directory by deleting and recrating prospectors directory
- *conf_dir* (optional, String, NilClass) - default `nil`, filebeat configuration directory, this attribute is derived by helper method
- *prospectors_dir* (optional, String, NilClass) - default `nil`, filebeat prospectors directory, this attribute is derived by helper method
- *log_dir* (optional, String, NilClass) - default `nil`, filebeat log directory, this attribute is derived by helper method
- *windows_package_url* (optional, String) - default `auto`, windows filebeat package url
- *windows_base_dir* (optional, String) - default `C:/opt/filebeat`, filebeat windows base directory
- *apt_options* (optional, Array) - default `%w[stable main]`, filebeat package resource attribute for `debian` platform family
- *elastic_repo_options* (optional, Hash) - default `{}`, resource elastic_repo options, `filebeat_install` attribute `version` overrides `elasti_repo_options` key `version` value. Check out [elastic_repo cookbook](https://github.com/vkhatri/chef-elastic-repo) for more details.


## LWRP filebeat_service

LWRP `filebeat_service` configures `filebeat` service.


**LWRP example**

```ruby
filebeat_service 'default' do
  [options ..]
end
```

**LWRP Options**

- *action* (optional)	- default `:create`, options: :create, :delete
- *filebeat_install_resource_name* (optional, String) - default `default`, filebeat_install/filebeat_install_preview resource name, set this attribute if LWRP resource name is other than `default`
- *service_name* (optional, String) - default `filebeat`, filebeat service name, must be common across resources
- *disable_service* (optional, Boolean) - default `false`, set to `true`, to disable filebeat service
- *notify_restart* (optional, Boolean) - default `true`, set to `false`, to ignore filebeat service restart notify
- *purge_prospectors_dir* (optional, Boolean) - default `false`, set to `true`, to purge prospectors
- *runit_filebeat_cmd_options* (optional, Boolean) - default `''`, set to `true`, runit filebeat service command line options
- *ignore_failure* (optional, Boolean) - default `false`, set to `true`, to ignore filebeat service failures
- *retries* (optional, Integer) - default `2`, filebeat service resource attribute
- *retry_delay* (optional, Integer) - default `0`, filebeat service resource attribute


## LWRP filebeat_config

LWRP `filebeat_config` creates filebeat configuration yaml file `/etc/filebeat/filebeat.yml`.

Below filebeat configuration parameters gets overwritten by the LWRP.

- `filebeat.registry_file`
- `filebeat.config_dir`
- `logging.files`


**LWRP example**

```ruby
conf = {
  'filebeat.modules' => [],
  'prospectors' => [],
  'logging.level' => 'info',
  'logging.to_files' => true,
  'logging.files' => { 'name' => 'filebeat' },
  'output.elasticsearch' => { 'hosts' => ['127.0.0.1:9200'] }
}

filebeat_config 'default' do
  config conf
  action :create
end
```

Above LWRP Resource will create a file `/etc/filebeat/conf.d/lwrp-prospector-messages_log.yml` with content:

```yaml
filebeat.modules: []
prospectors: []
logging.level: info
logging.to_files: true
logging.files:
  path: "/var/log/filebeat"
output.elasticsearch:
  hosts:
  - 127.0.0.1:9200
filebeat.registry_file: "/var/lib/filebeat/registry"
filebeat.config_dir: "/etc/filebeat/conf.d"
```

**LWRP Options**

- *action* (optional)	- default `:create`, options: :create, :delete
- *filebeat_install_resource_name* (optional, String) - default `default`, filebeat_install/filebeat_install_preview resource name, set this attribute if LWRP resource name is other than `default`
- *config* (Hash) - default `{}` filebeat configuration options
- *sensitive* (optional, Boolean) - default `false`, filebeat configuration file chef resource attribute
- *service_name* (optional, String) - default `filebeat`, filebeat service name, must be common across resources
- *conf_file* (optional, String, NilClass) - default `nil`, filebeat configuration file, this attribute is derived by helper method
- *disable_service* (optional, Boolean) - default `false`, set to `true`, to disable filebeat service
- *notify_restart* (optional, Boolean) - default `true`, set to `false`, to ignore filebeat service restart notify


## LWRP filebeat_prospector

LWRP `filebeat_prospector` creates a filebeat prospector configuration yaml file under prospectors directory with file name `lwrp-prospector-#{resource_name}.yml`.


**LWRP example**

```ruby
conf = {
  'enabled' => true,
  'paths' => ['/var/log/messages'],
  'type' => 'log',
  'fields' => {'type' => 'messages_log'}
}

filebeat_prospector 'messages_log' do
  config conf
  action :create
end
```

Above LWRP Resource will create a file `/etc/filebeat/conf.d/lwrp-prospector-messages_log.yml` with content:

```yaml
filebeat:
  prospectors:
  - enabled: true
    paths:
    - "/var/log/messages"
    type: log
    fields:
      type: messages_log
```

**LWRP Options**

- *action* (optional)	- default `:create`, options: :create, :delete
- *filebeat_install_resource_name* (optional, String) - default `default`, filebeat_install/filebeat_install_preview resource name, set this attribute if LWRP resource name is other than `default`
- *config* (Hash) - default `{}` filebeat configuration options
- *sensitive* (optional, Boolean) - default `false`, filebeat configuration file chef resource attribute
- *service_name* (optional, String) - default `filebeat`, filebeat service name, must be common across resources
- *disable_service* (optional, Boolean) - default `false`, set to `true`, to disable filebeat service
- *notify_restart* (optional, Boolean) - default `true`, set to `false`, to ignore filebeat service restart notify


## How to Create Filebeat LWRP Resources via Node Attribute

Check out filebeat test cookbook [filebeat_test](test/cookbooks/filebeat_test).


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[Filebeat]: https://www.elastic.co/products/beats/filebeat
[Contributors]: https://github.com/vkhatri/chef-filebeat/graphs/contributors
