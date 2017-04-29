
$(document).ready(function () {

});



var markers = [
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

initialize(markers);


function initialize(markers) {
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        center: new google.maps.LatLng(markers[0].lat, markers[0].lng),
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.ROADMAP
        //  marker:true
    };
    var infoWindow = new google.maps.InfoWindow();
    var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
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