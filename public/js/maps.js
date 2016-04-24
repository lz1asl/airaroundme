var map;

function initMap() {
    // Initialize the google maps with default settings
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 0, lng: 0},
        styles: styleSheet,
        zoom: 13,
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.TERRAIN
    });

    // Set the center of the map to the geolocation if allowed by the browser
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            map.setCenter({
                lat: position.coords.latitude,
                lng: position.coords.longitude
            });

            // Call the search button to apply the markers
            $("#search-button").click();
        });
    }

    // Create the search box and link it to the UI element.
    var input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(input);
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
        searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
        var places = searchBox.getPlaces();

        if (places.length == 0) {
            return;
        }

        // For each place get the bounds and set them
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function(place) {
            if (place.geometry.viewport) {
                bounds.union(place.geometry.viewport);
            } else {
                bounds.extend(place.geometry.location);
            }
        });
        map.fitBounds(bounds);

        // Call the search button to apply the markers
        $("#search-button").click();
    });

    /**
     * Apply landmark files on the map
     */
    var baseURL = 'https://airaroundme.herokuapp.com/sampledata/';

/*    $.each(retrieveLandmarkFiles(), function(index, fileName) {
        applyMapLandmarks(baseURL + fileName, map);
    });*/
}

function retrieveLandmarkFiles() {
    // TODO: Replace with an API call to retrieve the kml filenames
    return [
        'AIRS_CO-1Day.kml',
        'AIRS_Dust-1Day.kml',
        'AIRS_Precip-1Day.kml',
        'AIRS_SO2-1Day.kml',
        'Prata_SO2-1Day.kml'
    ];
}

function applyMapLandmarks(url, map) {
    var options = {
        suppressInfoWindows: true,
        preserveViewport: false,
        map: map
    };

    var kmlLayer = new google.maps.KmlLayer(url, options);
}