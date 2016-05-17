// pull in desired CSS/SASS files
require( '../styles/global.css' );
require( '../styles/app.css' );
require( '../styles/form.css' );
require( '../styles/wind-direction.css' );
require( '../styles/available-days.css' );

var Elm = require('../elm/Main');
var app = Elm.Main.embed( document.getElementById( 'Main' ) );

app.ports.share.subscribe(function(network) {
  if(network === "Facebook"){
    window.open('https://www.facebook.com/dialog/share?app_id=307031336138092&display=popup&href=http://vient.us&redirect_uri=http://vient.us', 'sharer', 'width=626,height=400');
  } else if(network === "Twitter"){
    // TODO: Pass the title translated from Vientus in a tuple (Twitter, "Don't miss the windy days with")
    var title = "Don't miss the windy days with";
    var loc = "http://vient.us";
    window.open('http://twitter.com/share?url=' + loc + '&text=' + title + '&', 'twitterwindow', 'height=450, width=550, top='+(window.innerHeight/2 - 100) +', left='+window.innerWidth/4 +', toolbar=0, location=0, menubar=0, directories=0, scrollbars=0');
  }

});

