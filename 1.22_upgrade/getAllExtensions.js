
var allExtensions = {};

var wikis = ["mod","eva","topo","oso","bme","missionsystems","robo"];
var wikiCompletionStatus = {
	// mod: false,
	// eva: false,
	// topo: false,
	// oso: false,
	// bme: false,
	// missionsystems: false,
	// robo: false
};

function allWikisComplete () {
	for ( var i in wikiCompletionStatus ) {
		if ( wikiCompletionStatus[i] === false ) {
			return false;
		}
	}
	return true;
}

function printWikiInfo () {
	var output = "Extension\t";

	for( var w in wikis ) {
		output += wikis[w] + "\t";
	}
	output += "\n";
	
	var extList = [];
	for( var e in allExtensions ) {
		extList.push( e );
	}
	extList.sort();

	for( var i in extList ) {
		e = extList[i];

		output += e + "\t";
		for( var w in wikis ) {
			var extOnWiki = allExtensions[e][ wikis[w] ]
			if ( extOnWiki ) {
				if ( extOnWiki.version ) {
					output += extOnWiki.version + "\t";
				}
				else if ( extOnWiki.git ) {
					output += "git: " + extOnWiki.git + "\t";
				}
				else {
					output += "No version info\t";
				}
			}
			else {
				output += "Not installed\t";
			}
		}
		output += "\n";
	}

	console.log( output );
}


for ( var w in wikis ) {
	var wikiName = wikis[w];
	wikiCompletionStatus[wikiName] = false; // initially not yet complete

	// request extension info from this wiki
	console.log( "requesting " + wikiName + " extensions" );
	$.getJSON(
		"https://mod2.jsc.nasa.gov/wiki/" + wikiName + "/api.php",
		{
			action: "query",
			meta: "siteinfo",
			siprop: "extensions",
			format: "json"
		},
		(function( wiki ){
			return function( response ) {
				console.log( "received " + wiki + " response; processing..." );
				var extensions = response.query.extensions

				for( var i in extensions ) {

					var e = extensions[i];
					if ( ! allExtensions[e.name] ) {
						allExtensions[e.name] = {};
					}

					allExtensions[e.name][wiki] = {
						version: ( e.version ? e.version : "" ),
						git: ( e["vcs-version"] ? e["vcs-version"].substring( 0, 6 ) : "" )
					};

				}
				
				// mark this wiki complete
				console.log( "complete recording " + wiki + " extensions" );
				wikiCompletionStatus[wiki] = true;

				// check if others are complete
				if ( allWikisComplete() ) {
					printWikiInfo();
				}


			};
		})( wikiName )
	);

}
