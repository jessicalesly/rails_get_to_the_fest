function autocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    var festAddress = document.getElementById('fest_address');


    if (festAddress) {
      var autocomplete = new google.maps.places.Autocomplete(festAddress, { types: [ 'geocode' ], componentRestrictions: {country: "fr"} });
      google.maps.event.addDomListener(festAddress, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { autocomplete };
