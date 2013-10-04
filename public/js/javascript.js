
function initialize() {

 var locations = [
 ['Alpha Omega', 38.470539, -122.429129, 3],
 ['Beaulieu Vineyard', 38.460051, -122.422074, 2],
 ['V. Sattui Winery', 38.489041, -122.448241, 1],
 ['V. Sattui Winery', 38.489041, -122.448241, 1],
 ];

 var myLatlng = new google.maps.LatLng(38.489041, -122.448241);
 var mapOptions = {
  zoom: 12,
  center: myLatlng,
  mapTypeId: google.maps.MapTypeId.ROADMAP
}
var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  // var image = '/views/bordeaux_sm.png';

  var marker, i;
  for (i=0; i < locations.length-1; i++)
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i][1], locations[i][2]),
      map: map,
      title: locations[i][0],
      icon: '../images/bordeaux_sm.png'
    });
}

google.maps.event.addDomListener(window, 'load', initialize);
