// pull in desired CSS/SASS files
require( './styles/hello.css' );

var Elm = require( './Main' );
Elm.embed( Elm.Main, document.getElementById( 'main' ), { swap: false } );
