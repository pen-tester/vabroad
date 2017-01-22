﻿<%@ Page Language="C#" MasterPageFile="~/MasterPageNoCss.master" AutoEventWireup="true"
    CodeFile="defaultmap.aspx.cs" Inherits="Default" Title="<%# GetTitle () %>" EnableEventValidation="False"
    %>

<%@ OutputCache Duration="600" VaryByParam="*" %>


<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="Server">
   <style type="text/css">
        #map-canvas {
            height: 900px;
            width:800px;
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
                zoom: 11,
                styles: [{ "featureType": "landscape", "stylers": [{ "hue": "#F1FF00" }, { "saturation": -27.4 }, { "lightness": 9.4 }, { "gamma": 1 }] }, { "featureType": "road.highway", "stylers": [{ "hue": "#0099FF" }, { "saturation": -20 }, { "lightness": 36.4 }, { "gamma": 1 }] }, { "featureType": "road.arterial", "stylers": [{ "hue": "#00FF4F" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }, { "featureType": "road.local", "stylers": [{ "hue": "#FFB300" }, { "saturation": -38 }, { "lightness": 11.2 }, { "gamma": 1 }] }, { "featureType": "water", "stylers": [{ "hue": "#00B6FF" }, { "saturation": 4.2 }, { "lightness": -63.4 }, { "gamma": 1 }] }, { "featureType": "poi", "stylers": [{ "hue": "#9FFF00" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }],
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
            map.fitBounds(bounds);
        }
    </script>
    
    
    <div>
        <h1 style="width:100%;font-family:Verdana;font-size:36px;color:#3c3c3c;" align="center">  Vacation Rentals, B&Bs, Resorts & Hotels </h1>
    </div>
    <br />
    <div id="map_canvas" style="width: 933px; height: 490px;"></div>

    <div>
        <%--<asp:Label ID="Title" runat="server" Visible="false" Text="Vacations-Abroad: vacation Beach Rentals, Family Apartments, Resorts, Boutique Hotels"></asp:Label>--%>
        <asp:Label ID="Title" runat="server" Visible="false" Text="Vacations Abroad: Beach Rentals, Vacation Apartments, Family Resorts, Small Boutique Hotels"></asp:Label>
        <asp:Label ID="Keywords" runat="server" Visible="false" Text="Vacation Beach Rentals, Vacation Apartments, Family Vacation Resorts, Small Boutique Hotels, Beach Vacation Rentals, Family Beach Apartments, Family Beach Resorts, Boutique Resorts, Boutique Beach Rentals"></asp:Label>
        <%--<asp:Label ID="Description" runat="server" Visible="false" Text="Vacations-Abroad: Vacation Beach Rentals, Vacation Apartments, Family Vacation Resorts, Small Boutique Hotels"></asp:Label>--%>
        <asp:Label ID="Description" runat="server" Visible="false" Text="Vacations-Abroad. Vacation Rentals, Beach Resorts, and Small Boutique Hotels in Africa, Asia, Europe, North America, Oceania and South America"></asp:Label>
        <br>
        <asp:Label ID="lblInfo" runat="server" ForeColor="Red"></asp:Label>
    </div>
    <!-- Start of StatCounter Code for Default Guide -->
    <script type="text/javascript">
        var sc_project = 3336280;
        var sc_invisible = 1;
        var sc_security = "510252c5";
    </script>

    <script type="text/javascript" src="http://www.statcounter.com/counter/counter.js"></script>
    <noscript>
        <div class="statcounter">
            <a title="site stats" href="http://statcounter.com/" target="_blank">
                <img class="statcounter" src="http://c.statcounter.com/3336280/0/510252c5/1/" alt="site stats"></a>
        </div>
    </noscript>
   <script type="text/javascript">
        document.getElementById("ctl00_dvLft").style.paddingTop = "50px";
    </script>
</asp:Content>
