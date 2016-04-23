var map,
    styleSheet;

styleSheet = [
    {
        "featureType": "water",
        "stylers": [
            {
                "color": "#19a0d8"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "weight": 6
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#e85113"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -40
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -20
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "lightness": -100
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels.icon"
    },
    {
        "featureType": "landscape",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "stylers": [
            {
                "lightness": 20
            },
            {
                "color": "#efe9e4"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "lightness": -100
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "hue": "#11ff00"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "lightness": 100
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [
            {
                "hue": "#4cff00"
            },
            {
                "saturation": 58
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "color": "#f0e4d3"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -25
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#efe9e4"
            },
            {
                "lightness": -10
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "simplified"
            }
        ]
    }
];

function initMap() {
    // Initialize the google maps with default settings
    map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: 0, lng: 0},
        styles: styleSheet,
        zoom: 10
    });

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

        // Clear out the old markers.
        markers.forEach(function(marker) {
            marker.setMap(null);
        });
        markers = [];

        // For each place, get the icon, name and location.
        var bounds = new google.maps.LatLngBounds();
        places.forEach(function(place) {
            var icon = {
                url: place.icon,
                size: new google.maps.Size(71, 71),
                origin: new google.maps.Point(0, 0),
                anchor: new google.maps.Point(17, 34),
                scaledSize: new google.maps.Size(25, 25)
            };

            // Create a marker for each place.
            markers.push(new google.maps.Marker({
                map: map,
                icon: icon,
                title: place.name,
                position: place.geometry.location
            }));

            if (place.geometry.viewport) {
                // Only geocodes have viewport.
                bounds.union(place.geometry.viewport);
            } else {
                bounds.extend(place.geometry.location);
            }
        });
        map.fitBounds(bounds);
    });

    // Set the center of the map to the geolocation if allowed by the browser
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            map.setCenter({
                lat: position.coords.latitude,
                lng: position.coords.longitude
            });
        });
    }
}