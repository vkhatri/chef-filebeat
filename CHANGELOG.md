filebeat CHANGELOG
==================

1.5.0
-----
- Virender Khatri - Updated filebeat version to v6.2.4

- Jean Rouge - Making it possible to pass additional command line arguments to the filebeat service

- Virender Khatri - Updated tests and clean up

- Michael Burns - Updated default_spec.rb

- Michael Burns - Use unzip_windows_zipfile for unit test

- Oleksiy Kovyrin - Enable sensitive flag for filebeat file resource

1.4.0
-----

- Virender Khatri - Updated filebeat version v6.0.1

1.3.0
-----

- Virender Khatri - Use cookbook elastic_beats_repo

- Virender Khatri - Updated filebeat version v5.6.4

1.2.0
-----

- Antek S. Baranski - Adding filebeat on Mac OS X install support

- Virender Khatri - Update filebeat version v5.6.3

- Virender Khatri - Added RC preview version support

1.1.0
-----

- Diogo Costa - PR Fix incorrect access to multiline_pattern attribute #116

- Virender Khatri - Update file beat version v5.6.0 #117

- Virender Khatri - Add test recipe missing prospector resource attributes #118

- Virender Khatri - Match prospector resource attributes type with documentation #119

- Virender Khatri - Add test recipe for v6 #120

- Virender Khatri - Updated .kitchen.yml, dokken sync

1.0.0
-----

- Virender Khatri - LWRP `filebeat_prospector` now creates configuration file with a prefix `lwrp-prospector-#{resource name}`, #73

- Virender Khatri - Prospectors via node attribute `node['filebeat']['prospectors']` now uses LWRP `filebeat_prospector` instead of creating JSON file with a prefix `node-prospector-#{prospector name}`, #114

- Virender Khatri - Added prospectors configuration files purge capability, #73, #103

  * Added new attribute `default['filebeat']['delete_prospectors_dir']` (default: `false`). If set to true, cookbook always delete and re-create prospectors configuration directory
  * Added new attribute `default['filebeat']['purge_prospectors_dir']` (default: `false`): If set to true, purge files under prospectors configuration directory, except `lwrp-prospector-` (created by LWRP)

  >>> Note: Set attribute `default['filebeat']['delete_prospectors_dir']` or `default['filebeat']['purge_prospectors_dir']` as per your requirement.

- Virender Khatri - Dropped support for Chef <12.x, #110

- Virender Khatri - No longer activelt test/support Filebeat v1.x, #113

- Virender Khatri - Updated Kitchen Tests
  * Created Chef 12.x and 13.x tests, #108
  * Use Pinned Travis chef-dk version
  * Use stable chef-dk version
  * Added Amazon, Debian and, Fedora tests
  * Added Filebeat preview release support
  * Added Filebeat test cookbook

- Virender Khatri - Added recent Filebeat prospector option to LWRP filebeat_prospector, #100

- Virender Khatri - Updated Filebeat version to v5.5.2

- Virender Khatri - Added Filebeat Preview (alpha/beta) version support, #112

- Virender Khatri - Created separate cookbooks for prospectors and service

- Virender Khatri - Updated attributes to use new . convention, issue #

- Virender Khatri - Added apt install option --force-yes, #104


0.5.0
-----

- Virender Khatri - Updated Beats Version to v5.4.2

- Virender Khatri - Updated config file permissions to 0600

- Virender Khatri - Optional apt/yum repository setup #98

- Dmitry Krasnoukhov - Allow to customize filebeat service name

0.4.9
-----

- Virender Khatri - Updated Beats Version to v5.2.2

0.4.8
-----

- Kyle Gochenour - PR #89, correct spool_size to use the correct parameter

- Virender Khatri - Issue #91, allow to ignore package verson in favor of pre installed filebeat packages

- Virender Khatri - PR #94, Travis CI Fix

- Len Smith - PR #93, Added check to avoid restart if service is disabled or notify restart is set to false

0.4.7
-----

- Tom Michaud - PR #86, Supports prospector 'tags' attribute

- Virender Khatri - Fixed Issue #88, Filebeat 5.2.0 Released, Unable to Install on Ubuntu

- Virender Khatri - Updated default version to v5.2.0

0.4.6
-----

- William Soula - PR #83, upgrade to filebeat 5.1.2, fix for #84

0.4.5
-----

- Virender Khatri - issue #78, fixed windows filebeat directory issue for v5.x

- Virender Khatri - use chefdk

- Virender Khatri - added kitchen dokken

0.4.4
-----

- Virender Khatri - fixed runit service

0.4.3
-----

- Michael Mosher - added json attributes to filebeat_prospector

- Virender Khatri - added v5.x support

- Virender Khatri - updated default filebeat version to v5.1.1

0.4.2
-----

- Andrei Scopenco - include yum-plugin-versionlock recipe for platform_family instead

0.4.1
-----

- Jesse Cotton - Add support for using runit instead of the default init system

0.4.0
-----

- Virender Khatri - fix for #60, HWRP does not restart filebeat service

0.3.9
-----

- Virender Khatri - fix for #65, added yum apt version lock

- Virender Khatri - updated beats version to v1.3.1

0.3.8
-----

- Virender Khatri - #68, config_dir attribute not getting set

0.3.7
-----

- Virender Khatri - Move derived attributes to recipe attributes

- Virender Khatri - Update filebeat version to v1.3.0

0.3.6
-----

- Arif Khan - Added Solaris Support

- Tom Noonan - Handle when new_resource.action is an array

- Virender Khatri - Updated filebeat config deprecated url reference

- Virender Khatri - Added service resource configurable attributes with default values

- Scott Nelson Windels - Add enable attribute back (used to be enabled, not it has been brought back as enable)

- Eric Herot - Only call powershell resource on windows machines

- Virender Khatri - Fix Travis

- Virender Khatri - Use powershell_script instead

- Scott Nelson Windels - Remove enabled attribute for now, as it isn't a feature in filebeat beyond the rc versions

0.3.4
-----

- Samuel Sampaio - added new filebeat prospector attributes

0.3.3
-----

- Virender Khatri - updated beats version to v1.2.3

0.3.2
-----

- Prerak Shah - Fixed Travis Errors

- Prerak Shah - Fixed Unit Tests

- Al Lefebvre - Added missing attribute for exclude_files

- Luke Lowery - Fixing issue with patterns and older versions of Ruby
                Updated YAML engine to adhere to ruby style guide

- Prerak Shah - Fixed default Install paths for windows

- Martin Smith - Respect service flags on package installation

- Azat Khadiev - Support spaces in file path for Windows



0.3.1
-----

- Virender Khatri - fix for #41

- Virender Khatri - added apt-get options, fix for #39

- Virender Khatri - bump filebeat version to v1.2.1

0.2.8
-----

- Spencer Owen - Adds a tag to berksfile

- Chris Barber - cleaning up mixmatch of tabs and spaces. fixed spelling error on prospector

- Eric Herot - Fix the formatting on the LWRP example in the README

- Roberto Rivera - Add include_lines and exclude lines.

- Sean Nolen - #33 added multiline support for LWRP

- Sean Nolen - #30 fixed rubocop error

- Seva Orlov - #34, restart filebeat on upgrade

- Virender Khatri - update to beat v1.1.2

0.2.7
-----

- Virender Khatri - #21, add yum_repository resource attribute metadata_expire

- Virender Khatri - #20, update to beat v1.0.1

0.2.6
-----

- Virender Khatri - #18, added LWRP resource for prospectors

- Virender Khatri - #15, fix kitchen test

0.2.5
-----

- Virender Khatri - disabled default output configuration and enable_localhost_output attributes

- Virender Khatri - #10, handle missing attribute node['filebeat']['windows']['version_string']

- Virender Khatri - #6, added specs

- Virender Khatri - #13, major changes to support repository package install

0.2.1
-----

- Virender Khatri - Added platforms metadata info

- Virender Khatri - #8, add missing dependency on powershell for windows platform

- Virender Khatri - #9, use resource powershell instead of powershell_script

0.2.0
-----
- Brandon Wilson - Include dpkg options to keep old config files when upgrading filebeat to a new release. Without specifying the dpkg options, dpkg will attempt to interactively ask if it should keep the old conf file, or replace it with the vendor supplied conf file which comes with the new version of the package. Since chef is running dpkg non-interactively, it causes dpkg to exit with code 1, and the chef run fails.

- Virender Khatri - Fix for #4, handle derived attribute for package_url

- Patrick Christopher - Added support for Windows OS

0.1.0
-----

- Virender Khatri - Initial release of filebeat

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
