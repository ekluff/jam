var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var labelIndex = 0;

function initMap() {

  var portlandCenter = { lat: 45.52, lng: -122.68 };

  var sessionMap = new google.maps.Map(document.getElementById('map'), {
    zoom: 11,
    center: portlandCenter
  });


  var latitudeArr = document.getElementsByClassName('lat')
  var longitudeArr = document.getElementsByClassName('lng')
  var sessionDate = document.getElementsByClassName('date')
  var sessionID = document.getElementsByClassName('id')
  var sessionTime = document.getElementsByClassName('time')
  var sessionInstrument = document.getElementsByClassName('instrument')

  for(var i = 0; i < latitudeArr.length; i++){
    addMarker({lat: parseFloat(latitudeArr[i].innerHTML), lng: parseFloat(longitudeArr[i].innerHTML)}, sessionMap)
  };



  var contentString = '<div id="content">'+
  '<div id="siteNotice">'+
  '</div>'+
  '<h3><a href="/jams/'+
  sessionID[i]+
  '">'+
  sessionDate[i]+
  '</a></h3>'+
  '<p>'+
  sessionTime[i]+
  '</p>'+
  '<p>'+
  sessionInstrument[i]+
  '</p>'+
  '</div>'+
  '</div>';

  var infowindow = new google.maps.InfoWindow({
    content: contentString
  });

  function addMarker(location, map) {
    var marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map,
      animation: google.maps.Animation.DROP
    });
    marker.addListener('click', function() {
      infowindow.open(map, marker);
    });
  }


  google.maps.event.addDomListener(window, 'load', initMap);


}
