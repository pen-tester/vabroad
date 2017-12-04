$(document).ready(function () {
    var countryname = $('#countryname').val();
    var title = "Vacations Abroad is a directory of " + countryname + " Vacation Rentals and " + countryname + " Boutique Hotels";
    $('#footerlogo').attr({ "title": title, "alt": title });

    //Google map 
    initializeMap();
});

var map;
function initializeMap() {

    /* var markers = [
     {
        "title": "Panipat",
         "lat": 29.3928,
         "lng": 76.9695,
         "description": "Panipat"
     },
     {
         "title": "Gurgaon",
         "lat": 28.4601,
         "lng": 77.0193,
         "description": "Gurgaon"
     }];
     */
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {

        center: new google.maps.LatLng(markers[0].lat, markers[0].lng),
        //center: new google.maps.LatLng(-34.397, 150.644),
        zoom: 11,
        //styles: [{ "featureType": "landscape", "stylers": [{ "hue": "#F1FF00" }, { "saturation": -27.4 }, { "lightness": 9.4 }, { "gamma": 1 }] }, { "featureType": "road.highway", "stylers": [{ "hue": "#0099FF" }, { "saturation": -20 }, { "lightness": 36.4 }, { "gamma": 1 }] }, { "featureType": "road.arterial", "stylers": [{ "hue": "#00FF4F" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }, { "featureType": "road.local", "stylers": [{ "hue": "#FFB300" }, { "saturation": -38 }, { "lightness": 11.2 }, { "gamma": 1 }] }, { "featureType": "water", "stylers": [{ "hue": "#00B6FF" }, { "saturation": 4.2 }, { "lightness": -63.4 }, { "gamma": 1 }] }, { "featureType": "poi", "stylers": [{ "hue": "#9FFF00" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }],
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        marker: true
    };
    var infoWindow = new google.maps.InfoWindow();
    var map = new google.maps.Map(document.getElementById("googlemap"), mapOptions);
    for (i = 0; i < markers.length; i++) {
        var data = markers[i]
        var myLatlng = new google.maps.LatLng(data.lat, data.lng);
        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: data.title
        });
        bounds.extend(marker.position);
        (function (marker, data) {

            // Attaching a click event to the current marker
            google.maps.event.addListener(marker, "click", function (e) {
                window.open(data.URL);
                // infoWindow.setContent(data.description);
                //infoWindow.open(map, marker);
            });
        })(marker, data);
    }
    var icon = "https://www.vacations-abroad.com/assets/img/airports.png";
    for (i = 0; i < airports_markers.length; i++) {
        var data = airports_markers[i]
        var myLatlng = new google.maps.LatLng(data.lat, data.lng);
        var marker = new google.maps.Marker({
            position: myLatlng,
            icon:icon,
            map: map,
            title: data.title
        });
        bounds.extend(marker.position);
    }

    google.maps.event.addListener(map, 'zoom_changed', function () {
        zoomChangeBoundsListener =
            google.maps.event.addListener(map, 'bounds_changed', function (event) {
                if (this.getZoom() > 9 && this.initialZoom == true) {
                    // Change max/min zoom here
                    this.setZoom(9);
                    this.initialZoom = false;
                }
                google.maps.event.removeListener(zoomChangeBoundsListener);
            });
    });
    map.initialZoom = true;
    map.fitBounds(bounds);
}