// pull in desired CSS/SASS files
require( '../styles/global.css' );
require( '../styles/app.css' );
require( '../styles/form.css' );
require( '../styles/wind-direction.css' );
require( '../styles/available-days.css' );

var Elm = require('../elm/Main');
Elm.Main.embed( document.getElementById( 'Main' ) );
