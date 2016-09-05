// pull in desired CSS/SASS files
require( '../styles/global.css' );
require( '../styles/app.css' );
require( '../styles/form.css' );
require( '../styles/wind-direction.css' );
require( '../styles/available-days.css' );

var Elm = require('../elm/Main');
var app = Elm.Main.embed( document.getElementById('Main'),
                          { randomSeed: Math.floor(Math.random() * 0xFFFFFF) }
                        );
var mymap,
    selectedIcon,
    markers,
    markersMap,
    layerGroup;


selectedIcon = L.icon({
  iconUrl: 'img/marker-icon-selected@1x.png',
  iconRetinaUrl: 'img/marker-icon-selected@2x.png',
  shadowUrl: 'img/marker-shadow.png',
  iconSize:    [25, 41],
	iconAnchor:  [12, 41],
	popupAnchor: [1, -34],
	tooltipAnchor: [16, -28],
	shadowSize:  [41, 41]
});

function onSpotClick( spot, e ) {
  app.ports.selectSpot.send( spot.id );
};

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

app.ports.setMapBoundary.subscribe(function(country) {
  //mymap.fitBounds([
	//  [country.swLatitude, country.swLongitude],
	//  [country.neLatitude, country.neLongitude]
  //]);
});

app.ports.setMarkers.subscribe(function(spots) {
  markersMap = {};
  if(layerGroup != undefined){
    mymap.removeLayer(layerGroup);
  }
  markers = spots.map(
    spot => {
      var marker =  L.marker([spot.latitude, spot.longitude])
            .bindPopup(L.popup({closeButton: false, closeOnClick: false}).setContent(spot.name))
            .on('click', (e) => onSpotClick(spot, e) );
      markersMap[spot.id] = marker;
      return marker;
    }
  );
  layerGroup = L.featureGroup( markers );
  layerGroup.addTo(mymap);
  mymap.fitBounds(layerGroup.getBounds().pad(0.1));

});

app.ports.setSelectedMarker.subscribe(function(selectedInfo) {
  var prevSelectedSpot = selectedInfo.prevSelectedSpot;
  var newSelectedSpot = selectedInfo.newSelectedSpot;

  markersMap[newSelectedSpot.id].setIcon(selectedIcon).openPopup();
  mymap.setView([newSelectedSpot.latitude, newSelectedSpot.longitude], 12);

  if(prevSelectedSpot != undefined){
    markersMap[prevSelectedSpot.id].setIcon(new L.Icon.Default()).closePopup();
  }
});


// Wait until DOM element exists before attaching map
// That's what requestAnimationFrame does
function attachMap() {
  if (document.querySelectorAll('#Map').length == 0) {
    window.requestAnimationFrame(attachMap);
  }
  mymap = L.map('Map', {
    maxZoom: 14
  });
  mymap.setView([38.668356, -2.109375], 2);
  L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/light-v9/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiamduYXRjaCIsImEiOiJjaXJ3YWJvaGkwMGdkaHhrdzR0YXEwemFyIn0.CVofMKGll1SVcBtzW_vN1A').addTo(mymap);

};
attachMap();
