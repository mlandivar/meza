This is an overview of the directory structure used by a meza server. This does not include every single file, but attempts to list out directories and files used by the meza application.

```
/
|-- etc/ (Parsoid, ES, and MySQL are installed here)
|	|-- my.cnf -> /opt/meza/config/core/my.conf
|-- opt/
|	└-- meza/ (primary installation location for meza)
|		|-- config/
|		|	|-- core/ (config for meza application, not to be changed by meza admins)
|		|	|	|-- BlenderSettings.php (for landing page)
|		|	|	|-- config.sh (for meza)
|		|	|	|-- elasticsearch.repo
|		|	|	|-- elasticsearch.yml
|		|	|	|-- httpd.conf (for Apache)
|		|	|	|-- initd_parsoid.sh (run Parsoid as daemon)
|		|	|	|-- localsettings.js (configuration for Parsoid)
|		|	|	|-- LocalSettings.php (configuration for MediaWiki)
|		|	|	|-- logrotated_httpd (rotates Apache log files)
|		|	|	|-- memcached
|		|	|	|-- my.cnf (for MySQL)
|		|	|	└-- php.ini
|		|	|-- local/ (config for meza instance on a server)
|		|	|	|-- domain
|		|	|	|-- LandingPage.php (site-specific settings for landing page)
|		|	|	|-- postLocalSettings_allWikis.php
|		|	|	|-- preLocalSettings_allWikis.php
|		|	|	|-- primewiki (specifies which wiki is prime for user table, interwiki, etc)
|		|	|	|-- README.md
|		|	|	|-- remote-wiki-config.sh (copy/modify from template directory)
|		|	|	|-- saml20-idp-remote.php (copied/modified from template directory by saml.sh)
|		|	|	|-- saml-setup-config.sh (copy/modify from template directory)
|		|	|	└-- simplesaml_authsources.php (generated by saml.sh script if using SAML authentication)
|		|	└-- template/
|		|		|-- ifcfg-enp0s8 (host-only network settings for CentOS 7 on VirtualBox)
|		|		|-- ifcfg-eth1 (host-only network settings for CentOS 6 on VirtualBox)
|		|		|-- install.config.example.sh (allow run install.sh without any prompts)
|		|		|-- LandingPage.php
|		|		|-- more-extensions.php (example showing how to load non-core extensions)
|		|		|-- preLocalSettings_allWikis.php
|		|		|-- remote-wiki-config.example.sh (used to pull data from remote wikis for import)
|		|		|-- saml20-idp-remote.php (copied to local if using SAML authentication)
|		|		|-- saml_httpd.conf (added to core/httpd.conf if using SAML (FIXME: don't touch core))
|		|		|-- SAML-postLocalSettings.php
|		|		|-- SAML-preLocalSettings.php
|		|		|-- saml-setup-config.sh (used to setup SAML authentication with saml.sh if required)
|		|		└-- wiki-init/
|		|			|-- config/
|		|			|	|-- favicon.ico
|		|			|	|--	logo.png
|		|			|	|--	postLocalSettings.php
|		|			|	└-- preLocalSettings.php
|		|			└--	images/
|		|-- data/
|		|	|-- elasticsearch/
|		|	|	|-- data/ (indices for ES)
|		|	|	|-- plugins/ (plugins for ES)
|		|	|	└-- work/ (temp files for ES)
|		|	|-- mysql/
|		|	|	└-- databases/
|		|-- .gitignore
|		|-- htdocs/
|		|	|-- .htaccess
|		|	|-- index.php
|		|	|-- mediawiki/
|		|	|	|-- extensions/
|		|	|	|-- images/ (not used by meza, see /opt/meza/htdocs/wikis/<yourwikiname>/images/)
|		|	|	|-- LocalSettings.php -> /opt/meza/config/core/LocalSettings.php
|		|	|	|-- maintenance/
|		|	|	└--	(lots of standard MediaWiki stuff)
|		|	|-- WikiBlender/ (see github/jamesmontalvo3/WikiBlender)
|		|	|	|-- BlenderSettings.php -> /opt/meza/config/core/BlenderSettings.php
|		|	|	|-- .gitignore
|		|	|	|-- includes/
|		|	|	|	|-- Admin.php
|		|	|	|	|-- Landing.php
|		|	|	|	└-- WikiBlender.php
|		|	|	|-- index.php
|		|	|	|-- lib/
|		|	|		|-- masonry.pkgd.min.js
|		|	|		|-- underscore-min.js
|		|	|		|-- WikiBlender.css
|		|	|		└-- WikiBlender.js
|		|	└-- wikis/
|		|		|-- demo/
|		|		|	|-- config/ (config for each wiki)
|		|		|	|	|-- favicon.ico
|		|		|	|	|-- logo.png
|		|		|	|	|-- postLocalSettings.php
|		|		|	|	└-- preLocalSettings.php
|		|		|	└-- images/
|		|		└-- (other wikis yet to be created, same structure as /opt/meza/htdocs/wikis/demo)
|		|-- logs/
|		|	|-- <sometimestamp>_cmd.log (command start/stop times during meza install)
|		|	|-- <sometimestamp>_err.log (errors during meza install)
|		|	|-- <sometimestamp>_out.log (output from meza install)
|		|	|-- php.log (PHP logging when debug is on)
|		|	└-- user-unify-<sometimestamp>/ (lots of logging during user unification script)
|		|-- manual/ (lots of markdown files for documentation)
|		|-- scripts/
|		|	|-- create-wiki.sh
|		|	|-- dev-networking.sh
|		|	|-- elastic-rebuild-index.sh
|		|	|-- import-remote-wikis.sh
|		|	|-- import-wikis.sh
|		|	|-- install.sh
|		|	|-- mezaCreateUser.php
|		|	|-- saml.sh
|		|	|-- unifyUserTables.php
|		|	└-- vmsetupwin.bat
|		|-- simplesamlphp/ (everything here is generated by saml.sh, dir doesn't exist if not using SAML)
|		└-- sources/ (source directories for things installed by source)
|			|-- ImageMagick/
|			└-- php-5.6.14/
|-- tmp/ (Used by at least PHP and MW, probably by other applications)
└-- var/
	|-- lib/
	|	|-- mysql/
	|		└-- mysql.sock (MySQL socket file, used for local connections to MySQL)
	└-- log/
		|-- elasticsearch/
		|-- httpd/
		|-- mail/
		|-- mysqld.log
		└-- messages (system messages on CentOS)
```

### Notes

#### Log files
All logging goes to `/var/log` with one exception. PHP logging is merged into Apache logging. If MW debug is on, PHP logging also goes to `/opt/meza/logs/php.log`. Logging to apache is not done when using command line interface.

#### MySQL databases
Located in `/opt/meza/data/mysql/`. In previous meza releases, these were in `/var/lib/mysql/`.

#### Uploaded files
`/opt/meza/htdocs/wikis/<yourwikiname>/images/`

#### Configuration
Each wiki's config overrides the local meza config which overrides the core meza config.
-  (For each wiki): `/opt/meza/htdocs/wikis/<yourwikiname>/config/`
-  (For local meza): `/opt/meza/config/local/`
-  (Core meza app): `/opt/meza/config/core/`

