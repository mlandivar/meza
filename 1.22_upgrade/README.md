# FOD Wiki Upgrades from 1.22

Several FOD wikis have the following configuration:

* MW 1.22.x
* SMW 1.8.x
* Various extensions installed at various versions

The EVA Wiki (and some others) have the following:

* MW 1.23.x
* SMW 2.1
* Mostly the same extensions but newer versions in some cases

The goal of all of the items in this directory is to bring those wikis up to speed with the EVA Wiki.

## Process

Below is an outline of the process used to bring a wiki up to the latest FOD version.

1. Backup files and database (for BME backup from dev, load to ops)

2. Upgrade MediaWiki
 ```bash
cd /wiki/<group> && git fetch origin && git checkout tags/1.23.latest && php maintenance/update.php --quick
```

3. Remove the following lines from LocalSettings.php (could be require_once, include_once, require, or include):
```php
require_once( "$IP/extensions/Validator/Validator.php" );
include_once( "$IP/extensions/SemanticMediaWiki/SemanticMediaWiki.php" );
require_once("$IP/extensions/SemanticResultFormats/SemanticResultFormats.php");
require_once "$IP/extensions/SubPageList/SubPageList.php";
```

4. Get Composer extensions
```bash
cd ./extensions && rm -rf ./SemanticMediaWiki && rm -rf ./SemanticResultFormats && rm -rf ./SubPageList

cd .. && composer require \
	mediawiki/semantic-media-wiki:~2.0 \
	mediawiki/semantic-result-formats:~2.0 \
	mediawiki/sub-page-list:~1.1 \
	mediawiki/semantic-meeting-minutes:~0.3

php maintenance/update.php --quick

php extensions/SemanticMediaWiki/maintenance/SMW_refreshData.php -d 50 -v
```


Current config info:
```
wiki  JSCMOD
---------------------------
MOD   9a40ec + local commit
EVA   c1925c
ROBO  c1925c
OSO   f62f8c
TOPO  c1925c	
MS    c1925c	
BME   9a40ec	

Commit   Commit date  Wikis
9a40ec   2014-04-07   MOD (has local commit)
9a40ec   2014-04-07   BME
c1925c   2014-02-03   EVA, ROBO, TOPO, MissionSystems
```