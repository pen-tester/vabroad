<%@ Page Language="C#" MasterPageFile="~/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="default.aspx.cs" Inherits="Default" Title="<%# GetTitle () %>" EnableEventValidation="False" %>

<%@ OutputCache Duration="100" VaryByParam="*" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Vacations Abroad: Vacation Rentals and Boutique Hotels
</asp:Content>
<asp:Content ID="meta" ContentPlaceHolderID="meta" runat="server">
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Organization",
  "url": "https://www.vacations-abroad.com",
  "logo": "https://www.vacations-abroad.com/assets/img/largelogo.jpg",
  "contactPoint": [{
    "@type": "ContactPoint",
    "telephone": "+1-877-672-2556",
    "contactType": "Customer service"
  }]
}
</script>
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Person",
  "name": "Vacations Abroad",
  "url": "https://www.vacations-abroad.com",
  "sameAs": [
    "https://twitter.com/vacationsabroad",
    "https://www.facebook.com/VacationsAbroad"
  ]
}
</script>
<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "WebSite",
  "url": "https://www.vacations-abroad.com/",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://www.vacations-abroad.com/searchterms.aspx?SearchTerms={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
</script>
     <meta name="google-site-verification" content="_9ddkudtxtgt4g9yE9vAW0eNeXoWvWEE0KlOQmQZraE" />
      <meta name="msvalidate.01" content="5724C8F545D1B8C25E26D8232A5FE1CF" />
    <meta name="description" content="<%=str_meta %>" /><meta name="keywords" content="<%=str_keyword %>" />
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
<ul itemscope itemtype="http://www.schema.org/SiteNavigationElement" style="display:none">
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/africa/default.aspx">Africa Vacations and Rentals</a></li>
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/asia/default.aspx">Asia Vacations and Rentals</a></li>
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/europe/default.aspx">Europe Vacations and Rentals</a></li>
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/north_america/default.aspx">North America Vacations and Rentals</a></li>
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/oceania/default.aspx">Oceania and Rentals</a></li>
  <li itemprop="name"><a itemprop="url" href="https://www.vacations-abroad.com/south_america/default.aspx">South America Vacations and Rentals</a></li>
</ul>
    <style>
        .backimg{width:100%;min-height:150px;} .backtitle{width:100%;font-family: Verdana; font-size: 28px; color: #fff;position:absolute;}
        .topbox{padding:5px 5px;border:2px solid #ff6600;width:600px;margin:auto;}
        .formgroup{width:100%;position:relative;} .bgimg{background-color:#f5ede3;}
        .placeItem{position:absolute;width:100%;}
        .topbox h1{display:inline;font-size:28px;margin:0;padding:0; -webkit-margin-before: 0;  -webkit-margin-after: 0; -webkit-margin-start: 0px;    -webkit-margin-end: 0px;}
        .footeritem h2{padding:0px;margin:0px;}
      @media(max-width:470px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
        .footeritem{width:190px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
         .sformgroup{padding-top:10px;}
       .itemtile{font-variant: small-caps;font-size:6pt;display:block;padding:0px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:2px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:0 20px 0 0;  width:@00px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:3px;}.margingroup{margin-top:210px;}
        .link{font-size:8pt;}
            .shidden{display:none;}

        }

        @media(max-width:560px) and (min-width:470px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .footeritem{width:300px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:6pt;display:block;padding:0px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:7pt;display:block;padding:2px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:10px 20px 0 0;  width:300px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:10px;}.margingroup{margin-top:250px;}
        .link{font-size:8pt;}
        .sformgroup{padding-top:10px;} 
        }
       @media(max-width:720px) and (min-width:560px){
        .alist{ color:#000;padding:3px 20px; font-family:Verdana; font-size:14pt; background-color:#fff;margin:auto;}
       .footeritem{width:320px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:10pt;display:block;padding:0px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:8pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 5px;border:2px solid #ff6600;width:300px;margin:auto;}
        .contentboxmargin{margin-top:4px;}    .footerarea{float:right; margin:5px 30px 0 0;  width:320px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:10px;}.margingroup{margin-top:320px;}
        .sformgroup{padding-top:25px;}
       }
        @media(min-width:720px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:16pt; background-color:#fff;margin:auto;}
       .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:11pt;display:block;padding:3px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:9pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:600px;margin:auto;}
        .contentboxmargin{margin-top:30px;}    .footerarea{float:right; margin:20px 30px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:20px;}.margingroup{margin-top:420px;}
         .sformgroup{padding-top:35px;}
        }
        @media(min-width:990px)
        {
        .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
        .footeritem{width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
       .itemtile{font-variant: small-caps;font-size:12pt;display:block;padding:3px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:10pt;display:block;padding:4px;}
       .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:5px 15px;border:2px solid #ff6600;width:600px;margin:auto;}
        .contentboxmargin{margin-top:30px;}    .footerarea{float:right; margin:20px 100px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
        .contentbox{margin-top:20px;}.margingroup{margin-top:540px;}
        .sformgroup{padding-top:50px;}
         }
        @media(min-width:1200px)
        {
         .alist{ color:#000;padding:3px 30px; font-family:Verdana; font-size:22pt; background-color:#fff;margin:auto;}
         .footeritem{ width:400px; background-color:#f5ede3;border:2px solid #cdbfac;padding:5px; color:#5a5a5a;margin:auto;text-align:left;}
        .itemtile{font-variant: small-caps;font-size:14pt;display:block;padding:4px;color:#5a5a5a;font-weight:300;}.itemtext{font-variant:small-caps; font-size:12pt;display:block;padding:4px;}
        .interalitem{padding:0 0 10px 30px;} a{cursor:pointer;}.topbox{padding:15px 30px;border:2px solid #ff6600;width:800px;margin:auto;}
         .contentboxmargin{margin-top:30px;}
         .contentbox{margin-top:30px;} .margingroup{margin-top:650px;}
        .footerarea{float:right; margin:20px 170px 0 0;  width:400px; padding:5px; color:#5a5a5a;text-align:left;}
         .sformgroup{padding-top:120px;} 
        }
    </style>
</asp:Content>
<asp:Content ID="Content" ContentPlaceHolderID="bodycontent" runat="Server">
<form id="mainform" runat="server">
    <div class="bgimg">
    <div class="scontainer"  style="background-color:#f5ede3;">
     <div class="srow">
           <div class="srow center formgroup">
                <div class="sformgroup backtitle center"><div class="topbox"><h1> <label class="alist" >A Business Director of Vacation Rentals & Boutique Hotels</label></h1></div></div>
                <div class="srow margingroup placeItem" >
                    <div class="center">
                        <div class="footeritem center">
                            <h2 class="itemtile">Explore the World Undaunted</h2>
                        </div>
                    </div>
               </div>
           </div>
        <img src="/assets/img/landing.jpg" class="backimg " alt="Vacations Abroad"/>

    </div>
        <div class="internalpage" style="background-color:#f5ede3;">
          <div class ="srow center">
  <div>
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

  </div>
<!-- Start of StatCounter Code for Default Guide -->
<script type="text/javascript">
var sc_project=3336280; 
var sc_invisible=1; 
var sc_security="510252c5"; 
var scJsHost = (("https:" == document.location.protocol) ?
"https://secure." : "http://www.");
document.write("<sc"+"ript type='text/javascript' src='" +
scJsHost+
"statcounter.com/counter/counter.js'></"+"script>");
</script>
<noscript><div class="statcounter"><a title="web analytics"
href="http://statcounter.com/" target="_blank"><img
class="statcounter"
src="//c.statcounter.com/3336280/0/510252c5/1/" alt="web
analytics"></a></div></noscript>
<!-- End of StatCounter Code for Default Guide -->
</form>
</asp:Content>
