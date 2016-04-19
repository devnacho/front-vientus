// pull in desired CSS/SASS files
require( '../styles/global.css' );
require( '../styles/app.css' );

var Elm = require( '../elm/Main' );
Elm.embed( Elm.Main, document.getElementById( 'Main' ), { swap: false } );
