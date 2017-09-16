filebeat Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-filebeat.svg)](https://github.com/vkhatri/chef-filebeat) [![Build Status](https://travis-ci.org/vkhatri/chef-filebeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-filebeat)

This is a [Chef] cookbook to manage [Filebeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/filebeat).


## Most Recent Release

```ruby
cookbook 'filebeat', '~> 1.1.0'
```


## From Git

```ruby
cookbook 'filebeat', github: 'vkhatri/chef-filebeat',  tag: 'v1.1.0'
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

Also works on Solaris zones given a physical Solaris 11.2 server. For that, use the .kitchen.zone.yml file. Check usage at (https://github.com/criticalmass/kitchen-zone). You will need an url to a filebeat package that works on Solaris 11.2. Checkout Building-Filebeat-On-Solaris11.md for instructions to build a filebeat package.


## Supported Chef

- Chef 12 (last tested on 12.21.4)

- Chef 13 (last tested on 13.3.42)


## Supported Filebeat

- 1.x (dropped test support in cookbook version v1.0.0)
- 5.x
- 6.x


## Major Changes

Refer CHANGELOG.md.


## Cookbook Dependency

- windows
- apt
- yum
- yum-plugin-versionlock
- runit


## Recipes

- `filebeat::attributes` - cookbook derived default attributes

- `filebeat::config` - configure filebeat

- `filebeat::default` - default recipe (use it for run_list)

- `filebeat::install_package` - install filebeat package for linux platform

- `filebeat::install_package_preview` - install filebeat preview (alpha/beta) package for linux platform

- `filebeat::install_solaris` - install filebeat package for solaris platform

- `filebeat::install_windows` - install filebeat for windows platform

- `filebeat::prospectors` - configure filebeat prospectors via node attribute `node['filebeat']['prospectors']`

- `filebeat::service` - configure filebeat service


## LWRP filebeat_prospector

LWRP `filebeat_prospector` creates filebeat prospector configuration yaml file under directory `node['filebeat']['prospectors_dir']` with file name `lwrp-prospector-#{resource_name}.yml`.


**LWRP example**

```ruby
filebeat_prospector 'messages' do
  paths ['/var/log/messages']
  document_type 'apache'
  ignore_older '24h'
  scan_frequency '15s'
  harvester_buffer_size 16384
  fields 'type' => 'apacheLogs'
end
```

**LWRP Options**

- *action* (optional)	- default :create, options: :create, :delete
- *type* (optional, String) - filebeat prospector configuration attribute
- *input_type* (optional, String) - filebeat prospector configuration attribute
- *paths* (optional, String)	- filebeat prospector configuration attribute
- *recursive_glob_enabled* (optional, TrueClass/FalseClass) - filebeat prospector configuration attribute
- *encoding* (optional, String)	- filebeat prospector configuration attribute
- *exclude_lines* (optional, Array) - A list of regular expressions to match the lines that you want filebeat to exclude. Filebeat drops any lines that match a regular expression in the list. By default, no lines are dropped.
- *include_lines* (optional, Array) - A list of regular expressions to match the lines that you want filebeat to include. Filebeat exports only the lines that match a regular expression in the list. By default, all lines are exported.
- *exclude_files* (optional, Array) - A list of regular expressions to match the files that you want filebeat prospector instance to exclude.
- *tags* (optional, Array)   - filebeat prospector configuration attribute
- *fields* (optional, Hash)	- filebeat prospector configuration attribute
- *fields_under_root* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *ignore_older* (optional, String)	- filebeat prospector configuration attribute
- *close_inactive* (optional, String)  - filebeat prospector configuration attribute
- *close_renamed* (optional, String)  - filebeat prospector configuration attribute
- *close_eof* (optional, String)  - filebeat prospector configuration attribute
- *close_timeout* (optional, String)  - filebeat prospector configuration attribute
- *clean_inactive* (optional, String)  - filebeat prospector configuration attribute
- *clean_removed* (optional, String)  - filebeat prospector configuration attribute
- *scan_frequency* (optional, String) - filebeat prospector configuration attribute
- *scan_sort* (optional, String) - filebeat prospector configuration attribute `scan.sort`
- *scan_order* (optional, String) - filebeat prospector configuration attribute `sort.order`
- *document_type* (optional, String)	- filebeat prospector configuration attribute
- *harvester_buffer_size* (optional, Integer)	- filebeat prospector configuration attribute
- *max_bytes* (optional, Integer) - filebeat prospector configuration attribute
- *json_keys_under_root* (optional, String) - filebeat prospector configuration attribute `json.keys_under_root`
- *json_overwrite_keys* (optional, String)  - filebeat prospector configuration attribute `json.overwrite_keys`
- *json_add_error_key* (optional, String) - filebeat prospector configuration attribute `json.add_error_key`
- *json_message_key* (optional, String) - filebeat prospector configuration attribute `json.message_key`
- *multiline_pattern* (optional, String) - filebeat prospector configuration attribute `multiline.pattern`
- *multiline_negate* (optional, String) - filebeat prospector configuration attribute `multiline.negate`
- *multiline_match* (optional, String) - filebeat prospector configuration attribute `multiline.match`
- *multiline_flush_pattern* (optional, String) - filebeat prospector configuration attribute `multiline.flush_pattern`
- *multiline_max_lines* (optional, String) - filebeat prospector configuration attribute `multiline.max_lines`
- *multiline_timeout* (optional, String) - filebeat prospector configuration attribute `multiline.timeout`
- *tail_files* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *pipeline* (optional, String)	- filebeat prospector configuration attribute
- *symlinks* (optional, String)	- filebeat prospector configuration attribute
- *backoff* (optional, String)	- filebeat prospector configuration attribute
- *max_backoff* (optional, String)	- filebeat prospector configuration attribute
- *backoff_factor* (optional, Integer)	- filebeat prospector configuration attribute
- *harvester_limit* (optional, Integer)	- filebeat prospector configuration attribute
- *enabled* (optional, TrueClass/FalseClass) - filebeat prospector configuration attribute
- *close_older* (optional, String)  - filebeat prospector configuration attribute
- *force_close_files* (optional, TrueClass/FalseClass)	- filebeat prospector configuration attribute
- *multiline* (optional, Hash)	- Multiline configuration hash. Options: `pattern`: <regex pattern to match>, `negate`: [true/false], `match`: [before/after]


## How to Add Filebeat Output Configuration via Node Attribute

Filebeat output configuration can be added to attribute `node['filebeat']['config']`.

```json
  "default_attributes": {
    "filebeat": {
      "config": {
        "output.elasticsearch": {
          "enable": true,
          "hosts": "127.0.0.1:9200"
        },
        "output.redis": {
          "enable": true,
          "option ..": "value .."
        },
        "{output.redis|output.elasticsearch|output.kafka|output.file|output.console|output.logstash| ..}": {
          "option ..": "value ..",
        }
      }
    }
  }

```

Above filebeat output configuration will be added to `filebeat.yml` file.


## How to Add Filebeat Prospectors via Node Attribute

Individual prospector configuration file can also be added using attribute `default['filebeat']['prospectors']`. Each prospector configuration will be created using LWRP.
For more prospector options, check out LWRP `filebeat_prospector`

```json
  "default_attributes": {
    "filebeat": {
      "prospectors": {

        "system_logs": {
          "paths": [
            "/var/log/messages",
            "/var/log/syslog"
          ],
          "type": "log",
          "fields": {
            "type": "system_logs"
          },
          "option ...": "value ..."
        },

        "apache_logs": {
          "paths": [
            "/var/log/apache/*.log"
          ],
          "type": "log",
          "ignore_older": "24h",
          "scan_frequency": "15s",
          "harvester_buffer_size": 16384,
          "fields": {
            "type": "apache_logs"
          },
          "option ...": "value ..."
        },

        "prospector ...": {
          "option ...": "value ..."
        }

      }
    }
  }

```

Above configuration will create three different prospector files - `lwrp-prospector-system_logs.yml, lwrp-prospector-secure_logs.yml and lwrp-prospector-apache_logs.yml` under `node['filebeat']['prospectors_dir']`.


## Core Attributes

* `default['filebeat']['version']` (default: `5.6.0`): filebeat version

* `default['filebeat']['ignore_version']` (default: `false`): ignore filebeat version for `package` install

* `default['filebeat']['setup_repo']` (default: `true`): setup `apt` or `yum` repository if set to `true`

* `default['filebeat']['release']` (default: `1`): filebeat release for yum package

* `default['filebeat']['service']['init_style']` (default: `init`): filebeat service init system, options: init, runit

* `default['filebeat']['package_url']` (default: `auto`): package url for windows installation

* `default['filebeat']['log_dir']` (default: `/var/log/filebeat`): filebeat logging directory

* `default['filebeat']['conf_dir']` (default: `/etc/filebeat`): filebeat yaml configuration file directory

* `default['filebeat']['conf_file']` (default: `/etc/filebeat/filebeat.yml`): filebeat configuration file

* `default['filebeat']['notify_restart']` (default: `true`): whether to restart filebeat service on configuration file change

* `default['filebeat']['disable_service']` (default: `false`): whether to stop and disable filebeat service

* `default['filebeat']['prospectors_dir']` (default: `/etc/filebeat/conf.d`): prospectors configuration file directory

* `default['filebeat']['prospectors']` (default: `{}`): prospectors configuration via node attribute

* `default['filebeat']['modules']` (default: `{}`): modules configuration via node attribute

* `default['filebeat']['delete_prospectors_dir']` (default: `false`): delete and create prospectors configuration directory if set to true

* `default['filebeat']['purge_prospectors_dir']` (default: `false`): purge files under prospectors configuration directory if set to true, except `node-prospector-*` (created by node attribute) and `lwrp-prospector-` (created by LWRP)


## Configuration File filebeat.yml Attributes

* `default['filebeat']['config']['filebeat.prospectors']` (default: `[]`): filebeat prospectors configuration

* `default['filebeat']['config']['filebeat.modules']` (default: `[]`): filebeat prospectors configuration

* `default['filebeat']['config']['filebeat.registry_file']` (default: `/var/lib/filebeat/registry`): filebeat services to capture packets

* `default['filebeat']['config']['filebeat.config_dir']` (default: `node['filebeat']['prospectors_dir']`): filebeat prospectors configuration files folder

For more attribute info check `attributes/config.rb`.


## Filebeat YUM/APT Repository Attributes

* `default['filebeat']['yum']['description']` (default: ``): beats yum repository attribute

* `default['filebeat']['yum']['gpgcheck']` (default: `true`): beats yum repository attribute

* `default['filebeat']['yum']['enabled']` (default: `true`): beats yum repository attribute

* `default['filebeat']['yum']['baseurl']` (default: `https://packages.elastic.co/beats/yum/el/$basearch`): beatsyum repository attribute

* `default['filebeat']['yum']['gpgkey']` (default: `https://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats yum repository attribute

* `default['filebeat']['yum']['metadata_expire']` (default: `3h`): beats yum repository attribute

* `default['filebeat']['yum']['action']` (default: `:create`): beats yum repository attribute


* `default['filebeat']['apt']['description']` (default: `calculated`): beats apt repository attribute

* `default['filebeat']['apt']['components']` (default: `['stable', 'main']`): beats apt repository attribute

* `default['filebeat']['apt']['uri']` (default: `https://packages.elastic.co/beats/apt`): beats apt repository attribute

* `default['filebeat']['apt']['key']` (default: `http://packages.elasticsearch.org/GPG-KEY-elasticsearch`): beats apt repository attribute

* `default['filebeat']['apt']['action']` (default: `:add`): filebeat apt repository attribute


## Other Attributes

* `default['filebeat']['service']['name']` (default: `filebeat`): filebeat service name

* `default['filebeat']['service']['retries']` (default: `:0`): filebeat service resource attribute

* `default['filebeat']['service']['retry_delay']` (default: `:2`): filebeat service resource attribute


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
