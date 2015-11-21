filebeat Cookbook
================

[![Cookbook](http://img.shields.io/badge/cookbook-v0.2.1-green.svg)](https://github.com/vkhatri/chef-filebeat) [![Build Status](https://travis-ci.org/vkhatri/chef-filebeat.svg?branch=master)](https://travis-ci.org/vkhatri/chef-filebeat)

This is a [Chef] cookbook to manage [Filebeat].


>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/filebeat).


## Most Recent Release

```
cookbook 'filebeat', '~> 0.2.1'
```

## From Git

```
cookbook 'filebeat', github: 'vkhatri/chef-filebeat'
```

## Repository

```
https://github.com/vkhatri/chef-filebeat
```

## Supported OS

This cookbook was tested on Windows, Amazon & Ubuntu Linux and expected to work on other RHEL platforms.

## Major Changes

### v0.2.x
- Removed default output configuration attributes for `elasticsearch`, `logstash` and `file`
- Removed attributed `default['filebeat']['enable_localhost_output']` as default `output` attributes are disabled

## Cookbook Dependency

- windows
- powershell

## Recipes

- `filebeat::default` - default recipe (use it for run_list)

- `filebeat::install` - install filebeat

- `filebeat::config` - configure filebeat


## Core Attributes


* `default['filebeat']['version']` (default: `1.0.0-rc2`): filebeat version

* `default['filebeat']['package_url']` (default: `auto`): package url

* `default['filebeat']['conf_dir']` (default: `/etc/filebeat`): filebeat yaml configuration file directory

* `default['filebeat']['conf_file']` (default: `/etc/filebeat/filebeat.yml`): filebeat configuration file

* `default['filebeat']['notify_restart']` (default: `true`): whether to restart filebeat service on configuration file change

* `default['filebeat']['disable_service']` (default: `false`): whether to stop and disable filebeat service

* `default['filebeat']['prospectors_dir']` (default: `/etc/filebeat/conf.d`): prospectors configuration file directory

* `default['filebeat']['prospectors']` (default: `{}`): prospectors configuration file

## Configuration File filebeat.yml Attributes

* `default['filebeat']['config']['filebeat']['prospectors']` (default: `[]`): filebeat interface device name

* `default['filebeat']['config']['filebeat']['registry_file']` (default: `/var/lib/filebeat/registry`): filebeat services to capture packets

* `default['filebeat']['config']['filebeat']['config_dir']` (default: `node['filebeat']['prospectors_dir']`): filebeat prospectors configuration files folder


* `default['filebeat']['config']['output']['elasticsearch']['enabled']` (default: `true`): enable elasticsearch output

* `default['filebeat']['config']['output']['elasticsearch']['hosts']` (default: `[]`): elasticsearch hosts

* `default['filebeat']['config']['output']['elasticsearch']['save_topology']` (default: `false`):


* `default['filebeat']['config']['output']['logstash']['enabled']` (default: `true`): enable logstash output

* `default['filebeat']['config']['output']['logstash']['hosts']` (default: `[]`): logstash hosts

* `default['filebeat']['config']['output']['logstash']['loadbalance']` (default: `true`): set true to load balance between logstash hosts

* `default['filebeat']['config']['output']['logstash']['index']` (default: `filebeat`): logstash index name

* `default['filebeat']['config']['output']['logstash']['tls']['enabled']` (default: `false`):

* `default['filebeat']['config']['output']['logstash']['save_topology']` (default: `false`):


* `default['filebeat']['config']['output']['file']['enabled']` (default: `false`):

* `default['filebeat']['config']['output']['file']['path']` (default: `/tmp/filebeat`):

* `default['filebeat']['config']['output']['file']['filename']` (default: `filebeat`):

* `default['filebeat']['config']['output']['file']['rotate_every_kb']` (default: `10240`):

* `default['filebeat']['config']['output']['file']['number_of_files']` (default: `7`):


For more attribute info, visit below links:

https://github.com/elastic/filebeat/blob/master/etc/filebeat.yml


## How to Add Filebeat Prospectors via Node Attribute

Individual propspectors configuration file can be added using attribute `default['filebeat']['prospectors']`. Each prospector configuration will
be created as a different yaml file under `default['filebeat']['prospector_dir']` with prefix `prospector-`

```
  "default_attributes": {
    "filebeat": {
      "prospectors": {
        "system_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/messages",
                  "/var/log/syslog"
                ],
                "type": "log",
                "fields": {
                  "type": "system_logs"
                }
              }
            ]
          }
        },
        "secure_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/secure",
                  "/var/log/auth.log"
                ],
                "type": "log",
                "fields": {
                  "type": "secure_logs"
                }
              }
            ]
          }
        },
        "apache_logs": {
          "filebeat": {
            "prospectors": [
              {
                "paths": [
                  "/var/log/apache/*.log"
                ],
                "type": "log",
                "ignore_older": "24h",
                "scan_frequency": "15s",
                "harvester_buffer_size": 16384,
                "fields": {
                  "type": "apache_logs"
                }
              }
            ]
          }
        }
      }
    }
  }

```


Above configuration will create three different prospector files - `prospector-system_logs.yml, prospector-secure_logs.yml and prospector-apache_logs.yml`

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
