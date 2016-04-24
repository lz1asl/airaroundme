$(document).ready(function() {
    // Search on the map
    $("#search-button").click(function(e) {
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
            radius: radius
        };

        e.preventDefault();

        $.ajax({
            url: "/search",
            type: "POST",
            data: JSON.stringify(body),
            contentType: "application/json",
            success: function(result) {
                debugger;
            }
        });
    });
});