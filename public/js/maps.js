var map;

function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 0, lng: 0},
        zoom: 8
    });

    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            map.setCenter({
                lat: position.coords.latitude,
                lng: position.coords.longitude
            });
        });
    }

}