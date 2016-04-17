// pull in desired CSS/SASS files
//require( './styles/app.css' );

var Elm = require( '../Elm/Main' );
Elm.embed( Elm.Main, document.getElementById( 'main' ), { swap: false } );
