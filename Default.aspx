﻿<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="default.aspx.cs" Inherits="Default" Title="<%# GetTitle () %>" EnableEventValidation="False" %>

<%@ OutputCache Duration="100" VaryByParam="*" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations Abroad: Vacation Rentals and Boutique Hotels
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <meta name="google-site-verification" content="_9ddkudtxtgt4g9yE9vAW0eNeXoWvWEE0KlOQmQZraE" />
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
    <div class="scontainer">
        <div class="internalpage">
    <div class ="srow center">
  <div>
        <h1 style="width: 100%; font-family: Verdana; font-size: 28px; color: #3c3c3c;" align="center">Vacation Rentals, Boutique Hotels, Quaint B&Bs, Beach Resorts</h1>
    </div>
    <br />
    <div id="map_canvas" style="width: 90%; height: 485px;margin:0px auto; "></div>

    <div>
        <%--<asp:Label ID="Title" runat="server" Visible="false" Text="Vacations-Abroad: Vacation Rentals, B&Bs, Resorts, Hotels"></asp:Label>--%>
        <asp:label id="Title" runat="server" visible="false" text="Vacations Abroad: Vacation Rentals, B&Bs, Resorts, Hotels"></asp:label>
        <asp:label id="Keywords" runat="server" visible="false" text="Vacation Beach Rentals, Vacation Apartments, Family Vacation Resorts, Small Boutique Hotels, Beach Vacation Rentals, Family Beach Apartments, Family Beach Resorts, Boutique Resorts, Boutique Beach Rentals"></asp:label>
        <%--<asp:Label ID="Description" runat="server" Visible="false" Text="We constantly search the world to to find unique properties to make your vacation the best."></asp:Label>--%>
        <asp:label id="Description" runat="server" visible="false" text="Vacation Rentals and Boutique Hotels: %regions%.  We constantly search the world to find unique properties to make your vacation the best."></asp:label>
        <br>
        <asp:label id="lblInfo" runat="server" forecolor="Red"></asp:label>
    </div>
    <!-- Start of StatCounter Code for Default Guide -->
    <script type="text/javascript">
        var sc_project = 3336280;
        var sc_invisible = 1;
        var sc_security = "510252c5";
    </script>

    </div>
        </div>
    </div>

    <style type="text/css">
        #map-canvas {
            height: 900px;
            width: 800px;
        }
    </style>


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
                styles: [{ "featureType": "landscape", "stylers": [{ "hue": "#F1FF00" }, { "saturation": -27.4 }, { "lightness": 9.4 }, { "gamma": 1 }] }, { "featureType": "road.highway", "stylers": [{ "hue": "#0099FF" }, { "saturation": -20 }, { "lightness": 36.4 }, { "gamma": 1 }] }, { "featureType": "road.arterial", "stylers": [{ "hue": "#00FF4F" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }, { "featureType": "road.local", "stylers": [{ "hue": "#FFB300" }, { "saturation": -38 }, { "lightness": 11.2 }, { "gamma": 1 }] }, { "featureType": "water", "stylers": [{ "hue": "#00B6FF" }, { "saturation": 4.2 }, { "lightness": -63.4 }, { "gamma": 1 }] }, { "featureType": "poi", "stylers": [{ "hue": "#9FFF00" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }],
                //center: new google.maps.LatLng(-34.397, 150.644),
                zoom: 11,
                //styles: [{ "featureType": "landscape", "stylers": [{ "hue": "#F1FF00" }, { "saturation": -27.4 }, { "lightness": 9.4 }, { "gamma": 1 }] }, { "featureType": "road.highway", "stylers": [{ "hue": "#0099FF" }, { "saturation": -20 }, { "lightness": 36.4 }, { "gamma": 1 }] }, { "featureType": "road.arterial", "stylers": [{ "hue": "#00FF4F" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }, { "featureType": "road.local", "stylers": [{ "hue": "#FFB300" }, { "saturation": -38 }, { "lightness": 11.2 }, { "gamma": 1 }] }, { "featureType": "water", "stylers": [{ "hue": "#00B6FF" }, { "saturation": 4.2 }, { "lightness": -63.4 }, { "gamma": 1 }] }, { "featureType": "poi", "stylers": [{ "hue": "#9FFF00" }, { "saturation": 0 }, { "lightness": 0 }, { "gamma": 1 }] }],
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                marker: true
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
       
    <script type="text/javascript" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false&callback=InitMap">
    </script>

  

</asp:Content>
