<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Maps.aspx.cs" Inherits="_Maps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Maps</title>
    <style>
        html, body, #map-canvas {
            height: 350px;
            width: 500px;
            overflow:hidden;
        }
    </style>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false">
    </script>

    <script type="text/javascript">
        
        function initialize(markers) {
            
            //var markers = [
            //{
            //    "title": "Panipat",
            //    "lat": 29.3928,
            //    "lng": 76.9695,
            //    "description": "Panipat"
            //},
            //{
            //    "title": "Gurgaon",
            //    "lat": 28.4601,
            //    "lng": 77.0193,
            //    "description": "Gurgaon"
            //}];
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
            if (markers.length == 1) {

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
            }
            map.fitBounds(bounds);
        }
    </script>
</head>
<body>
    <form id="form2" runat="server">
        <div id="map_canvas" style="width:500px;height:350px"></div>
       
    </form>
</body>
</html>
