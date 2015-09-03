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

  for(var i = 0; i < latitudeArr.length; i++){
    addMarker({lat: parseFloat(latitudeArr[i].innerHTML), lng: parseFloat(longitudeArr[i].innerHTML)}, sessionMap)
  };



  function addMarker(location, map) {
    var marker = new google.maps.Marker({
      position: location,
      label: labels[labelIndex++ % labels.length],
      map: map,
      animation: google.maps.Animation.DROP
    });
  }


  // google.maps.event.addDomListener(window, 'load', initialize);


}
