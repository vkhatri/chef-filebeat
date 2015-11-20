filebeat CHANGELOG
==================

This file is used to list changes made in each version of the filebeat cookbook.

0.2.x
-----
- Patrick Christopher - add support for Windows deploys.


0.1.1
-----

- Brandon Wilson - Include dpkg options to keep old config files when upgrading filebeat to a new release. Without specifying the dpkg options, dpkg will attempt to interactively ask if it should keep the old conf file, or replace it with the vendor supplied conf file which comes with the new version of the package. Since chef is running dpkg non-interactively, it causes dpkg to exit with code 1, and the chef run fails.


0.1.0
-----

- Virender Khatri - Initial release of filebeat

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
