var current_page = 0;
var site_url = "";
var propertyid = -1 ,init_rendering=false;
$(document).ready(function () {
    $("#wzardstep" + current_page).show();
    //For clicking step wizard 
    $('div.step').click(function () {
        var target = $(this).attr('data-target');
        if (!$('div.step[data-target="' + target + '"]').parent().hasClass("done")) return;
        switchPage(target);
        buttongroup(current_page);
    });
    //For step button event
    $('.btnprev').click(function () {
        if (current_page > 0) {
            switchPage(current_page - 1);
            buttongroup(current_page);
        }
    });
    $('.btnnext').click(function () {
        if (current_page == 0 && validatePage(current_page)) { checkCityLocation(); }
        else if (current_page < 3 && validatePage(current_page)) {
            SubmitPage(current_page);
            switchPage(current_page + 1);
            buttongroup(current_page);
        }
    });
    $('input').keypress(function () {
        $(this).removeClass('error_required');
        $(this).parent().find('.error_msg').remove();
    });
    buttongroup(current_page);
    //For step basic information   Property Category and Property Type Name
    $('#propcategory').change(function () {
        refreshListBox("propcategory","getTypeListbyCategory");
    });
    $('#proptypename').change(changePropertyType);
    refreshListBox("propcategory", "getTypeListbyCategory");
    changePropertyType();

    //For location info
    $('#regionlist').change(function () {
        refreshListBox("regionlist", "getCountryList");
    });

    $('#countrylist').change(function () {
        refreshListBox("countrylist", "getStateList");
    });
    
    $('#statelist').change(function () {
        refreshListBox("statelist", "getCityList");
    });

    $('#citylist').change(function () {
        $('#citylist').parent().find('.error_msg').remove();
        changeCityEvent();
    });

    /*
    refreshListBox("citylist", "getCountryList");
    */


    //For the existed property
    propertyid = $('#propid').val();
    if (propertyid.toString() != "-1") {
        //prop_info displays all info for the existed one.
        init_rendering = true;
        init_webform();
        $('#regionlist').val(prop_info["RegionID"]);
    }

    refreshListBox("regionlist", "getCountryList");


    //Jquery plugin chosen
    $(".chosen-select").chosen();
    // $('#proptypename').greenify();
});
//If there is a existed property, initalize the content based on the current property
function init_webform(){
    $('#_propname2').val(prop_info["Name2"]);
    $('#_propname').val(prop_info["Name"]);
    $('#_virttour').val(prop_info["VirtualTour"]);
    $('#propcategory').val(prop_info["CategoryID"]);
    $('#_propaddr').val(prop_info["Address"]);
    $('#_propdisplay').val(prop_info["IfShowAddress"]);
    $('#_propbedroom').val(prop_info["NumBedrooms"]);
    $('#_propbathrooms').val(prop_info["NumBaths"]);
    $('#_propsleep').val(prop_info["NumSleeps"]);
    $('#_propminrental').val(prop_info["MinimumNightlyRentalID"]);
    $('#_proptv').val(prop_info["NumTVs"]);
    $('#_propcd').val(prop_info["NumCDPlayers"]);
}


//Related functions to List box change
function refreshListBox(target, funcname) {
    var cat_id = $('#' + target).val();
    if (cat_id == null) return;
    var fn = window[funcname];

    // is object a function?
    if (typeof fn === "function") fn(cat_id);
}
function changePropertyType() {
    $('#proptypename').parent().find('.error_msg').remove();
    var ind = $('#proptypename').val();
    if (ind == null) return;
    if (ind.toString() == "0") {
        $('#additional_type').show();
        $('#additional_type').addClass("required");
    } else {
        $('#additional_type').hide();
        $('#additional_type').removeClass("required");
    }
}
function changeCityEvent() {
    var ind = $('#citylist').val();
    if (ind.toString() == "0") {
        $('#additionalcity').show();
        $('#additionalcity').addClass("required");
    } else {
        $('#additionalcity').hide();
        $('#additionalcity').removeClass("required");
    }
}

//When clicking "next" button, submitting the current page to helper page(to store the current page)
function SubmitPage(current_page) {
    var frmname = "#frmstep" + current_page;
    $.ajax({
        type: "POST",
        url: site_url + "/apihelper/savepropertyinfo.aspx",
        data: $(frmname).serialize(),
        success: processSubmitResult,
        error: function (response) {
            console.log(response);
        }
    });
}
function processSubmitResult(response) {
    console.log(response);
}

function switchPage(target) {
    for (var i = target; i < 4; i++) {
        $('div.step[data-target="' + i + '"]').parent().removeClass("done").removeClass("active");
    }

    for (var i =0 ; i < target; i++) {
        $('div.step[data-target="' + i + '"]').parent().addClass("done").removeClass("active");
    }

    $("#wzardstep" + current_page).hide();
    $("#wzardstep" + target).css({ "left": 300, "opacity": 0 });
    $("#wzardstep" + target).show();
    $("#wzardstep" + target).animate({
        opacity: 1.0,
        left: 0,
    }, 300, function () {
        // Animation complete.
    });
    current_page = parseInt(target);
    $('div.step[data-target="' + current_page + '"]').parent().addClass("active");
}

//Function to validate the each step
function checkCityLocation() {
    //For additional city
    if ($('#additionalcity').hasClass("required")) {
        var city = $('#additionalcity').val();
        var state = $('#statelist option:selected').text();
        var country = $('#countrylist option:selected').text();
        geocodeAddress(city, state, country);
    } else {
        SubmitPage(current_page);
        switchPage(current_page + 1);
        buttongroup(current_page);
    }
}
function validatePage(page) {
    var result = true;
    $('.error_msg').remove();
    if (page == 0) {
        //Check the required field.
        $('#frmstep0 input').each(function () {
            if ($(this).hasClass('required')) {
                if ($(this).val().length == 0) {
                    $(this).addClass('error_required');
                    addErrorField(this, "This field is requried");
                    result = false;
                }
            }
            if ($(this).hasClass('maxchars')) {
                if ($(this).val().length> $(this).attr('data-max')) {
                    $(this).addClass('error_required');
                    addErrorField(this, "This field length has to be less than " + $(this).attr('data-max'));
                    result = false;
                }
            }
        });
    }
    return result;
}
//Add error field
function addErrorField(obj,message) {
    $(obj).after("<div class='error_msg'>"+message+"</div>");
}

function buttongroup(page) {
    if (page == 0) {
        $('.btnprev').addClass('firststep');
    } else $('.btnprev').removeClass('firststep');
    if (page == 3) {
        $('.btnnext').val("Finish");
    } else $('.btnnext').val("Next");
}

//Function to get the list of the type list by the category type
var cat_arr = [], calling_id=0 ,result_arr=[];
function getTypeListbyCategory(cat_id) {
    var index = cat_arr.indexOf(parseInt(cat_id));
    if (index == -1) {  //not called yet for category type.
        calling_id = cat_id;  //store the calling category id
        $.ajax({
            type: "POST",
            url: site_url + "/ajaxhelper.aspx/gettypelistbycategory",
            data: '{id:' + cat_id + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processTypeList,
            failure: function (response) {
                console.log(response.d);
            }
        });
    } else {
        refreshTypeList(index);
    }
}
function processTypeList(response) {
    //console.log(response.d);
    var obj = $.parseJSON(response.d);
    var cat_id = obj.id;
    var result = obj.data;
    cat_arr.push(cat_id);
    result_arr.push(result);
    if (cat_id.toString() != calling_id.toString()) return;
    
    var index = cat_arr.indexOf(cat_id);
    refreshTypeList(index);
}
function refreshTypeList(index) {
    structureListBox(index, "proptypename", result_arr, ["ID", "Name"], true, "Be creative and create a unique property type in the following field");
    if (init_rendering) {
        $('#proptypename').val(prop_info["TypeID"]);
    }
    else {
        $('#proptypename').val($("#proptypename option:first").val());
    }
    $('#proptypename').trigger("chosen:updated");
    changePropertyType();
}


//Generate list box from the object 
function structureListBox(index, listid, arr_name, param, addtional, addition_text) {  //Index of the array, target id , array name
    var result = arr_name[index];
    //Get the each item in the property type list and add them to the list
    var target = '#' + listid;
    $(target).html('');  //Removed the all
    for (var ind = 0; ind < result.length; ind++) {
        var item = result[ind];
        $(target).append($('<option></option>').val(item[param[0]]).html(item[param[1]]));
    }
    if (addtional) $(target).append($('<option></option>').val("0").html(addition_text));
}





//Function to get country list
var country_arr = [], country_calling_id = 0, country_result_arr = [];
function getCountryList(id) {
    var index = country_arr.indexOf(parseInt(id));
    if (index == -1) {  //not called yet for category type.
        country_calling_id = id;  //store the calling category id
        $.ajax({
            type: "POST",
            url: site_url + "/ajaxhelper.aspx/getcountrylist",
            data: '{id:' + id + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processCountryList,
            failure: function (response) {
                console.log(response.d);
            }
        });
    } else {
        refreshCountryList(index);
    }
}
//For country list
function processCountryList(response) {
  //  console.log(response.d);
    var obj = $.parseJSON(response.d);
    var cat_id = obj.id;
    var result = obj.data;
    country_arr.push(cat_id);
    country_result_arr.push(result);
    if (cat_id.toString() != country_calling_id.toString()) return;

    var index = country_arr.indexOf(cat_id);
    refreshCountryList(index);
}
function refreshCountryList(index) {
    structureListBox(index, "countrylist", country_result_arr, ["ID", "Country"], false, "");
    if (init_rendering) {
        $('#countrylist').val(prop_info["CountryID"]);
    }
    else {
        $('#countrylist').val($("#countrylist option:first").val());
    }
    $('#countrylist').trigger("chosen:updated");
    $('#statelist').html(''); $('#citylist').html(''); $('#citylist').trigger("chosen:updated");
    refreshListBox("countrylist", "getStateList");
}
//For state 
var state_arr = [], state_calling_id = 0, state_result_arr = [];
function getStateList(id) {
    var index = state_arr.indexOf(parseInt(id));
    if (index == -1) {  //not called yet for category type.
        state_calling_id = id;  //store the calling category id
        $.ajax({
            type: "POST",
            url: site_url + "/ajaxhelper.aspx/getstatelist",
            data: '{id:' + id + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processStateList,
            error: function (response) {
                console.log(response.d);
            }
        });
    } else {
        refreshStateList(index);
    }
}
//For state list
function processStateList(response) {
  //  console.log(response.d);
    var obj = $.parseJSON(response.d);
    var cat_id = obj.id;
    var result = obj.data;
    state_arr.push(cat_id);
    state_result_arr.push(result);
    if (cat_id.toString() != state_calling_id.toString()) return;

    var index = state_arr.indexOf(cat_id);
    refreshStateList(index);


}
function refreshStateList(index) {
    structureListBox(index, "statelist", state_result_arr, ["ID", "Name"], false, "");
    if (init_rendering) {
        $('#statelist').val(prop_info["StateProvinceID"]);
    }
    else {
        $('#statelist').val($("#statelist option:first").val());
    }
    $('#statelist').trigger("chosen:updated");
    refreshListBox("statelist", "getCityList");
}
//For City 
var city_arr = [], city_calling_id = 0, city_result_arr = [];
function getCityList(id) {
    var index = city_arr.indexOf(parseInt(id));
    if (index == -1) {  //not called yet for category type.
        city_calling_id = id;  //store the calling category id
        $.ajax({
            type: "POST",
            url: site_url + "/ajaxhelper.aspx/getcitylist",
            data: '{id:' + id + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processCityList,
            error: function (response) {
                console.log(response);
            }
        });
    } else {
        refreshCityList(index);
    }
}
//For state list
function processCityList(response) {
    var obj = $.parseJSON(response.d);
    var cat_id = obj.id;
    var result = obj.data;
    city_arr.push(cat_id);
    city_result_arr.push(result);
    if (cat_id.toString() != city_calling_id.toString()) return;

    var index = city_arr.indexOf(cat_id);
    refreshCityList(index);

}
function refreshCityList(index) {
    structureListBox(index, "citylist", city_result_arr, ["ID", "Name"], true, "Specify the other city");
    if (init_rendering) {
        $('#citylist').val(prop_info["CityID"]);
    }
    else {
        $('#citylist').val($("#citylist option:first").val());
    }
    $('#citylist').trigger("chosen:updated");
    init_rendering = false;
    changeCityEvent();
}

//For google geo coder
var geocoder;
function initMap() {
    geocoder = new google.maps.Geocoder();
}

function geocodeAddress(city, state, country) {
    var address = city + ", " + state + ", " + country;
    var result = { lat: 0, lng: 0, status:-1 };
    geocoder.geocode({ 'address': address }, function (results, status) {
        if (status === 'OK') {
            console.log("addr:" + address);
            var latitude = results[0].geometry.location.lat();
            var longitude = results[0].geometry.location.lng();
            geocodeLatLng(latitude, longitude, country,city);
        } else {
            console.log("get geo code error:" + status);
        }
    });
  /*  if (result.status == -1) {
        address = city + ", " + country;
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status === 'OK') {
                // resultsMap.setCenter(results[0].geometry.location);
                var latitude = results[0].geometry.location.lat();
                var longitude = results[0].geometry.location.lng();
                if (geocodeLatLng(latitude, longitude, country)) result = { lat: latitude, lng: longitude, status: 0 };
            } else {
                console.log("get geo code error:" + status);
            }
        });
    }*/
  //  return result;
}
function geocodeLatLng(latitude, longitude, country,city) {
    var isvalid = false;
    var latlng = { lat: parseFloat(latitude), lng: parseFloat(longitude) };
    geocoder.geocode({ 'location': latlng }, function (results, status) {
        if (status === 'OK') {
            for (var i = 0; i < results.length; i++) {
                locationDetails = results[i].formatted_address.toLowerCase();
                console.log(locationDetails);
                if (locationDetails.indexOf(country.toLowerCase()) >= 0 && locationDetails.indexOf(city.toLowerCase()) >= 0) {
                    isvalid = true;
                        SubmitPage(current_page);
                        switchPage(current_page + 1);
                        buttongroup(current_page);
                    return;
                }
            }
            addErrorField("#additionalcity", "Fail to get the geo code");
            console.log("geocodelatlng No results found");

        } else {
            console.log("geocodelatlng error:"+status);
        }
    });
    return isvalid;
}
