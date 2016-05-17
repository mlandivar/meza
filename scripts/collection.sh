#!/bin/sh
#
# run like: sudo bash collection.sh
#           sudo sh collection.sh
#           sudo zsh collection.sh
#           sudo ./collection.sh
​
# get wiki 1.25 Collection Extension: https://www.mediawiki.org/wiki/Special:ExtensionDistributor/Collection
wget [link from webpg that is periodically modified]

# put in /opt/meza/htdocs/mediawiki/extensions
tar -xzf Collection-REL1_25-d898236.tar.gz -C /opt/meza/htdocs/mediawiki/extensions

# add this stuff to localsettings...
# // Collection extension
# require_once("$IP/extensions/Collection/Collection.php");
# // configuration borrowed from wmf-config/CommonSettings.php
# // in operations/mediawiki-config
# $wgCollectionFormatToServeURL['rdf2latex'] =
# $wgCollectionFormatToServeURL['rdf2text'] = 'http://localhost:17080';
​
# // MediaWiki namespace is not a good default
# $wgCommunityCollectionNamespace = NS_PROJECT;
​
# // Sidebar cache doesn't play nice with this
# $wgEnableSidebarCache = false;
​
# $wgCollectionFormats = array(
# 		'rdf2latex' => 'PDF',
# 		'rdf2text' => 'Plain text',
# );
​
# $wgLicenseURL = "http://creativecommons.org/licenses/by-sa/3.0/";
# $wgCollectionPortletFormats = array( 'rdf2latex', 'rdf2text' );
​
​
​
​
# Get the required packages...
# From: https://wikitech.wikimedia.org/wiki/OCG#Installing_a_development_instance
OCG=/path/to/ocg   # /opt/meza/ocg
mkdir $OCG ; cd $OCG
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator mw-ocg-service
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/bundler mw-ocg-bundler
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/latex_renderer mw-ocg-latexer
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Collection/OfflineContentGenerator/text_renderer mw-ocg-texter
# If the following code gives errors with or w/o using sudo, login as root and run it.
for f in mw-ocg-service mw-ocg-bundler mw-ocg-latexer mw-ocg-texter ; do
	cd $f ; npm install ; cd ..
done
​
​
# take some notes on the fact that the directory structure is differnt from what it says here:
# https://github.com/wikimedia/mediawiki-extensions-Collection-OfflineContentGenerator-latex_renderer/blob/master/README.md
​
​
# more required stuff:
yum install -y librsvg2 librsvg2-devel librsvg2-tools libjpeg-turbo-utils perl-Tk perl-Digest-MD5 poppler-utils
​
​
# Ref: https://www.centos.org/forums/viewtopic.php?t=54410
# https://www.tug.org/texlive/quickinstall.html
# Do TeXlive download here: https://www.tug.org/texlive/acquire-netinstall.html
​wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
​# decompress (requires sudo)
mkdir /usr/local/texlive
tar -xzf install-tl-20160405.tar.gz -C /usr/local/texlive
./usr/local/texlive/install-tl-20160405/install-tl
# Select I for install (the install will take about 2 hrs)

# Ref: https://github.com/wikimedia/mediawiki-extensions-Collection-OfflineContentGenerator-bundler
# test with and you must actually be in the designated directory (mw-ocg-bundler or mw-ocg-latexer). using the path in the command isn't enough.
bin/mw-ocg-bundler -v -o us.zip -h en.wikipedia.org "United States"

"$OCG/mw-ocg-bundler/bin/mw-ocg-bundler" -v -o /opt/meza/logs/us.zip -h en.wikipedia.org "United States"
"$OCG/mw-ocg-latexer/bin/mw-ocg-latexer" -o /opt/meza/logs/out.pdf
