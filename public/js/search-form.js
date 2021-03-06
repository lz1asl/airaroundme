function clearMarkers() {
    for (var i = 0; i < mapMarkers.length; i++) {
        mapMarkers[i].setMap(null);
    }
    mapMarkers = [];
}

var searchData = function () {
    var bounds = map.getBounds();

    var center = bounds.getCenter();
    var northEast = bounds.getNorthEast();

    // Earth radius in miles
    var earthRadius = 3963.0;

    // Convert lat or lng to radians
    var lat1 = center.lat() / 57.2958,
        lon1 = center.lng() / 57.2958,
        lat2 = northEast.lat() / 57.2958,
        lon2 = northEast.lng() / 57.2958;

    // Calculate the distance in miles
    var radius = earthRadius * Math.acos(Math.sin(lat1) * Math.sin(lat2) +
            Math.cos(lat1) * Math.cos(lat2) * Math.cos(lon2 - lon1));

    var body = {
        lat: map.center.lat(),
        lon: map.center.lng(),
        radius: radius,
        types: options
    };

    $.ajax({
        url: "reports/search",
        type: "POST",
        data: JSON.stringify(body),
        contentType: "application/json",
        success: function(landmarks) {
            // Clear all the markers
            clearMarkers();

            // Update map notification
            if(landmarks.length > 0) {
                $("#map-warning-notification").show();
                setTimeout(function() {
                    $("#map-warning-notification").hide();
                }, 5000);
            } else {
                $("#map-clean-notification").show();
                setTimeout(function() {
                    $("#map-clean-notification").hide();
                }, 5000);
            }

            $.each(landmarks, function (i, landmark) {
                var infoWindow = new google.maps.InfoWindow({
                    content: landmark.title
                });

                var marker = new google.maps.Marker({
                    position: {
                        lat: landmark.lat,
                        lng: landmark.lng
                    },
                    map: map,
                    icon: 'http://maps.google.com/mapfiles/ms/micons/' + landmark.icon + '.png'
                });

                marker.addListener('click', function() {
                    infoWindow.open(map, marker);
                });

                mapMarkers.push(marker);
            });

        },
        failure: function(json) {
            console.error('Cannot load the symptoms options: ' + JSON.parse(json))
        }
    });
};


$(document).ready(function() {
    // Hide the map notifications
    $("#map-warning-notification").hide();
    $("#map-clean-notification").hide();

    // Search on the map
    $("#search-button").click(function(e){
        e.preventDefault();
        searchData();
    });
});