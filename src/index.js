// pull in desired CSS/SASS files
//require( './styles/app.css' );

var Elm = require( './Main' );
Elm.embed( Elm.Main, document.getElementById( 'main' ), { swap: false } );
