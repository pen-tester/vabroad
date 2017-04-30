
var addr_verified = false;
var property_id = 0, hlat, hlng;

function showMsg(message) {
    $('#modalmsg').html(message);
    $('#msgdlg').show();
}


function awayMsg(message) {
    $('#msgdlg').hide();
}

$(document).ready(function () {
    $('.mclose').click(function () {
        var t_id = $(this).attr("data-target");
        $('#' + t_id).hide();
    });
    $('#cancel').click(function () {
        $(".editmapform").fadeOut('normal', function () {
            $("#editform").hide();
        });
       
    });
    $('#m_othercity').hide();

    $('#m_country').on('change', function (e) {
        var optionSelected = $("option:selected", this);
        var cid = this.value;
        $('#m_othercity').hide();
        addr_verified = false;
        getStates(cid);
    });

    $('#m_state').on('change', function (e) {
        var optionSelected = $("option:selected", this);
        var cid = this.value;
        addr_verified = false;
        $('#m_othercity').hide();
        getCities(cid);
    });

    $('#m_city').on('change', function (e) {
        var optionSelected = $("option:selected", this);
        cityid = this.value;
        addr_verified = false;
        if (cityid == 0) $('#m_othercity').show();
        else $('#m_othercity').hide();
    });

    $('#verify').click(function () {
        if (cityid == null) {
            showMsg("The city or state province name is not existed.");
            return;
        }

         country = $("#m_country option:selected").text();
         state = $("#m_state option:selected").text();
         city = $("#m_city option:selected").text();
        if (cityid == 0) city = $('#m_othercity').val();
        addr = $('#m_addr').val();
        if (addr == '') { showMsg("The address is not specified."); return; }
        // var fulladdr = addr + ", " + city + ", " + state + ", " + country;
        var fulladdr = addr +  ", " + country;
        GetLocation(fulladdr);
    });

    $('#update').click(function () {
        if (!addr_verified) {
            showMsg("You have to verified the address of the property.");
            return;
        }
        $('#hpropid').val(property_id);
        $('#hcityid').val(cityid);
        $('#hstateid').val(stateid);
        $('#hcity').val(city);
        $('#haddr').val(addr);
        $('#hlat').val(hlat);
        $('#hlng').val(hlng);
        $('form').submit();
    });

});

var country, state, city, addr;

initialize(gmarkers);

var selected_id;

function showeditmap(propid) {
    property_id = propid;
    $('#editform').show();
    $(".editmapform").hide();
    $(".editmapform").fadeOut('normal', function () {
        $(".editmapform").fadeIn();
    });
    onemap = initializeMap("propmap");
    selected_id = propid;
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getpropertydetailinfo",
        data: '{ propid:' + propid + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processProperty,
        failure: function (response) {
            console.log(response.d);
        }
    });
}

var countryname, countryid, statename,stateid, cityname,cityid;

function processProperty(response) {
   // console.log(response.d);
    var property = response.d;
    countryname = property.Country;
    statename = property.StateProvince;
    cityname = property.City;
    getcountries(countryname);

    var lat = property.loc_latlang;
    var lng= property.loc_logitude;
    setMarkers(onemap,lat, lng);
    $('#m_addr').val(property.Address)
}

function getcountries(cname) {
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getcountryidlist",
        data: '{ cname:"' + cname + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processCountry,
        failure: function (response) {
            console.log(response.d);
        }
    });
}
function processCountry(response) {
   // console.log(response.d);
    var c_list = response.d;
    var count = c_list.length;
    $('#m_country').html('');
    for (var i = 0; i < count; i++) {

        ($('#m_country')).append($("<option></option>")
                    .attr("value", c_list[i].ID)
                    .text(c_list[i].Name));
    }
   // console.log(countryname);
    //$('#m_country').val('"'+countryname+'"');
    //$("#m_country").val($("#m_country option:first").val());
    $("#m_country option:contains(" + countryname + ")").attr('selected', 'selected');
    // $('#m_country').filter(function () {return ($(this).text() == countryname); }).attr('selected', 'selected'); 


    countryid = $("#m_country").val();

    $('#m_othercity').hide();
    getStates(countryid);
   
}

function getStates(cid) {
   // console.log("states"+cid);
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getstatesidlist",
        data: '{ id:' + cid + '}',
        contentType: "application/json; charset=utf-8",

        success: processStates,
        failure: function (response) {
            console.log(response.d);
        }
    });
}

function processStates(response) {
   //  console.log(response);
    var c_states = response.d;
    var count = c_states.length;
    $('#m_state').html('');
    $('#m_city').html('');
    for (var i = 0; i < count; i++) {

        ($('#m_state')).append($("<option></option>")
                    .attr("value", c_states[i].ID)
                    .text(c_states[i].Name));
    }
  //  console.log(statename);
    //$('#m_country').val('"'+countryname+'"');
    $("#m_state option:contains(" + statename + ")").attr('selected', 'selected');
    stateid = $("#m_state").val();
    $('#m_othercity').hide();
    getCities(stateid);

}

function getCities(cid) {
  //  console.log(cid);
    if(cid != null){ 
        $.ajax({
            type: "POST",
            url: "/ajaxhelper.aspx/getcityidlist",
            data: '{ id:"' + cid + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processCities,
            failure: function (response) {
                console.log(response.d);
            }
        });
    }
}

function processCities(response) {
//    console.log(response.d);
    var c_cities = response.d;
    var count = c_cities.length;
    $('#m_city').html('');
    for (var i = 0; i < count; i++) {

        ($('#m_city')).append($("<option></option>")
                    .attr("value", c_cities[i].ID)
                    .text(c_cities[i].Name));
    }
   // console.log(cityname);
    ($('#m_city')).append($("<option></option>")
            .attr("value", 0)
            .text("I have the property in other city"));
    //$('#m_country').val('"'+countryname+'"');
   // $("#m_city option:contains(" + cityname + ")").attr('selected', 'selected');
    $("#m_city option").filter(function () {
      //  console.log($(this).text() + "  " + cityname);
        return ($(this).text() == cityname);
    }).attr('selected', 'selected');
    //console.log(cityname);
    cityid = $("#m_city").val();
    if (count == 0) $('#m_othercity').show();
}

var mainmap, onemap;

function initialize(gmarkers) {
    mainmap = initializeMap("map_canvas");
    addAllmarkers(mainmap)
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
                    if (parseInt(locationDetails.indexOf(city.toLowerCase())) >= 0 && parseInt(locationDetails.indexOf(country.toLowerCase())) >= 0) {
                        isvalid = "true";
                        break;
                    }
                }
                if (isvalid == "false") {
                    showMsg("Incorrect ");
                } else {
                    setMarkers(onemap, latitude, longitude);
                    hlat = latitude;
                    hlng = longitude;

                    addr_verified = true;
                    showMsg("Correct");
                }

            }
            else {
                console.log("No location available for provided details.");
            }

        },
        failure: function (response) {
            console.log("get location error"+response.d);
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
}

function clearMarkers() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
}


function GetLocation(addr) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': addr }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                var latitude = results[0].geometry.location.lat();
                var longitude = results[0].geometry.location.lng();
                //showMsg(latitude + "::: longi" + longitude);
                getLocationDetails(latitude, longitude);
            } else {
                console.log("Request failed.");
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