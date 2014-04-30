 // Geolocation 
function initialize() {
  map = document.getElementById('geo_item');

  if(navigator.geolocation) {
    geocoder = new google.maps.Geocoder();
    navigator.geolocation.getCurrentPosition(function(position) {
      var latlng = new google.maps.LatLng(
        position.coords.latitude, position.coords.longitude
      );

      geocoder.geocode({'latLng': latlng}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          if (results[0]) {
            document.getElementById('item_location').value =
              results[0].formatted_address;
          } else {
            alert('No results found');
          }
        } else {
          alert('Geocoder failed due to: ' + status);
        }
      });
      
    }, function() {
      'Error: The Geolocation service failed.';
    });
  } else {
    // Browser doesn't support Geolocation
    'Error: Your browser doesn\'t support geolocation.';
  }
}