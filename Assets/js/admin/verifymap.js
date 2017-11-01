$(document).ready(function(){
    $("#proptable").on("click", ".action", function () {
        var city = $(this).parent().parent().find(".city").text();
        var state = $(this).parent().parent().find(".state").text();
        var country = $(this).parent().parent().find(".country").text();
        var addr = $(this).parent().parent().find(".address input").val();
        var propid = $(this).parent().parent().find("input[type=hidden]").val();
        $("#verifymap .city").text(city);
        $("#verifymap .state").text(state);
        $("#verifymap .country").text(country);
        $("#verifymap .address input").val(addr);
        $("#selected_id").val(propid);
        $("#verifymap").fadeIn();
        initialize(null);
    });

    $(".btnclose").click(function () {
        var target = $(this).attr("data-target");
        $("#" + target).fadeOut();
    });
    $(".verifyaddr").click(function () {
        var city = $("#verifymap .city").text();
        var state = $("#verifymap .state").text();
        var country = $("#verifymap .country").text();
        s_country = country;
        s_state = state;
        s_city = city;
        var addr = $("#verifymap .address input").val();
        var address = addr + ", " + city + ", " + state + ", " + country;
        GetLocation(address);
    })
});

var mainmap;
var s_country, s_state, s_city;

function initialize(gmarkers) {
    mainmap = initializeMap("map_canvas");
    //addAllmarkers(mainmap)
}


function initializeMap(mapid) {
    var mapOptions = {
        center: new google.maps.LatLng(51.5, -0.12),
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.ROADMAP
        //  marker:true
    };
    var map = new google.maps.Map(document.getElementById(mapid), mapOptions);
    return map;
}


function getLocationDetails(latitude, longitude) {

    var url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" +
            latitude + "," + longitude + "&sensor=false";
    //url: 'https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&sensor=true',
    $.ajax({
        url: url,
        success: function (data) {
            /*or you could iterate the components for only the city and state*/

            if (data.results.length > 0) {
                var isvalid = "false";
                for (var i = 0; i < data.results.length; i++) {
                    locationDetails = data.results[i].formatted_address.toLowerCase();
                    console.log(data.results[i].formatted_address);
                    //  if (parseInt(locationDetails.indexOf(city.toLowerCase())) >= 0 && parseInt(locationDetails.indexOf(country.toLowerCase())) >= 0) {
                    if (parseInt(locationDetails.indexOf(s_country.toLowerCase())) >= 0) {
                        isvalid = "true";
                        break;
                    }
                }
                if (isvalid == "false") {
                    showMsg("Incorrect Address");
                } else {
                    //Update the property info;;
                    $.ajax({
                        url: "/apiadmin.aspx/update_property_location",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType:"json",
                        data: "{ \"propid\": " + $("#selected_id").val() + ", \"lat\":" + latitude + ", \"lg\":" + longitude + "}"
                    }).done(function (result, status) {
                        angular.element($("#ngmainapp")).scope().list_properties();
                        angular.element($("#ngmainapp")).scope().apply();
                        $("#verifymap").fadeOut();
                        console.log("success", result.d);
                    }).fail(function (result, status) {
                        console.log("fail", result);
                        showMsg("Verification of Address Failed");
                    });
                }

            }
            else {
                console.log("No location available for provided details.");
                showMsg("No location available for provided details.");
            }

        },
        failure: function (response) {
            console.log("get location error" + response.d);
        }
    });

}

var markers = [];

function setMarkers(map, latitude, longitude) {
    clearMarkers();
    var latlng = new google.maps.LatLng(latitude, longitude);
    var marker = new google.maps.Marker({
        position: latlng,
        map: map,
    });
    // marker.setCenter(marker.getPosition());
    markers.push(marker);
    return marker;
}

function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
}


function GetLocation(addr) {
    console.log(addr);
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': addr }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            var latitude = results[0].geometry.location.lat();
            var longitude = results[0].geometry.location.lng();
            //showMsg(latitude + "::: longi" + longitude);
            //getLocationDetails(latitude, longitude);
            
            var marker = setMarkers(mainmap, latitude, longitude);
            hlat = latitude;
            hlng = longitude;
            addr_verified = true;
            var latLng = marker.getPosition(); // returns LatLng object
            mainmap.setCenter(latLng);
            //showMsg("Verification of Address Success");
            getLocationDetails(latitude, longitude);
        } else {
            console.log(results);
            showMsg("Verification of Address Failed");
        }
    });
}

function addAllmarkers(map) {
    var bounds = new google.maps.LatLngBounds();
    for (i = 0; i < gmarkers.length; i++) {
        var data = gmarkers[i]
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

function showMsg(msg){
    $("#msgbox .modal_content").text(msg);
    $("#msgbox").fadeIn();
}