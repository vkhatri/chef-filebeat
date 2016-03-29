filebeat CHANGELOG
==================

This file is used to list changes made in each version of the filebeat cookbook.

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
