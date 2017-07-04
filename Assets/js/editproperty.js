var current_page = 0;
var site_url = "https://www.vacations-abroad.com";
var propertyid = -1, init_region = false, init_country=false, init_state=false, init_type = false, init_city = false;
var furniture_tag = ""; var submitting = false;

String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

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
        else if (current_page < 4 && validatePage(current_page)) {
            SubmitPage(current_page);
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

    $('#propcategory').change(function () {
        $('#propcategory').parent().find('.error_msg').remove();
    });

    //For message box
    $('#msgclose').click(function () {
        $('#msgdlg').hide();
    });

    //For the existed property
    propertyid = $('#propid').val();
    if (propertyid.toString() != "-1") {
        //prop_info displays all info for the existed one.
        if (prop_info["RegionID"] != 0) {
            init_region = true; init_country = true; init_state = true; init_city = true;
            $('#regionlist').val(prop_info["RegionID"]);
        }
        if (prop_info["CategoryID"] > 0) {
            init_type = true;
            $('#propcategory').val(prop_info["CategoryID"]);
        }
    }

    refreshListBox("regionlist", "getCountryList");

    refreshListBox("propcategory", "getTypeListbyCategory");


    //Description and amenities step
    //For furniture select option
    var f_count = all_furniture.length;
    for (var ind_f = 0; ind_f < f_count; ind_f++) {
        furniture_tag += ("<option value='" + all_furniture[ind_f].ID + "'>" + all_furniture[ind_f].FurnitureItem + " </option>");
    }

    //add room button

    $('#addroom').click(function () {
        addNewRoom();
    });

    switchPage(current_page);
    buttongroup(current_page);
     //Jquery plugin chosen
    // $('#proptypename').greenify();
});
//Show msgbox
function showmessagebox(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

//If there is a existed property, initalize the content based on the current property
function init_basicstepPage() {
    if (propertyid != "-1" && propertyid != "0") {
        $('#_propname2').val(prop_info["Name2"]);
        $('#_propname').val(prop_info["Name"]);
        $('#_virttour').val(prop_info["VirtualTour"]);
        $('#_propaddr').val(prop_info["Address"]);
        if (prop_info["IfShowAddress"] != "" && prop_info["IfShowAddress"] != null) $('#_propdisplay').val(prop_info["IfShowAddress"]);
        $('#_propbedroom').val(prop_info["NumBedrooms"]);
        $('#_propbathrooms').val(prop_info["NumBaths"]);
        $('#_propsleep').val(prop_info["NumSleeps"]);
        if (prop_info["MinimumNightlyRentalID"] != "" && prop_info["MinimumNightlyRentalID"] != null) $('#_propminrental').val(prop_info["MinimumNightlyRentalID"]);
        $('#_proptv').val(prop_info["NumTVs"]);
        $('#_propcd').val(prop_info["NumCDPlayers"]);
        $('#additional_type').val(prop_info["PropertyName"]);
    }

    $('#wzardstep0 .chosen-select').chosen();

    changePropertyType();
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
    $('#additional_type').parent().find('.error_msg').remove();
}

function changeCityEvent() {
    var ind = $('#citylist').val();
    if (ind == null) return;
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
    if (submitting) {
        showmessagebox("Now proecessing!!!");
        return;
    }
    submitting = true;
    $.ajax({
        type: "POST",
        url: site_url + "/apihelper/savepropertyinfo.aspx?UserID="+$('#userid').val(),
        data: $(frmname).serialize(),
        success: processSubmitResult,
        error: function (response) {
            console.log(response);
            submitting = false;
            showmessagebox("Something wrong, please make sure that all fields are filled.");
        }
    });
}
function processSubmitResult(response) {
    console.log(response);
    submitting = false;
    if (response.status == -1) {
        showmessagebox("Something wrong, Please contact to system administrator.");
        return;
    }
    prop_info = response.propinfo;
    if (current_page == 0 && $('#citylist').val().toString() == "0") {
        init_city = true;
        var stid = $('#statelist').val();
        var ind = city_arr.indexOf(stid);
        city_arr.splice(ind, 1);
        city_result_arr.splice(ind, 1);
        refreshListBox("statelist", "getCityList");
    }
    if (current_page == 0) {
        $('#additional_type').val(prop_info["PropertyName"]);
    }
    $('input[name=propid]').val(prop_info["ID"]);
    if (current_page == 1) {
        prop_amenity = response.amenity_list;
        prop_furniture = $.parseJSON(response.room_furniture);
    }
    else if(current_page ==2){
        prop_attraction = response.attractions;
    }
    if (current_page < 3) {
        switchPage(current_page + 1);
        buttongroup(current_page);
    }
    else {
        window.location.replace(site_url + "/userowner/listings.aspx?UserID=" + prop_info.UserID);
    }
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
    if (target == 0) init_basicstepPage();
    else if (target == 1) Init_DescriptionStepPage();
    else if (target == 2) init_AttractionPage();
    else if (target == 3) init_RatePage();
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
    }
}
function validatePage(page) {
    var result = true;
    $('.error_msg').remove();
    var stepwizardfrm = "#frmstep" + page; //Form id
        //Check the required field max chars.
    $(stepwizardfrm +' input').each(function () {
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
    if (cat_id.toString() == prop_info["CategoryID"]) {
        $('#additional_type').val(prop_info["PropertyName"]);
    } else {
        $('#additional_type').val("");
    }
    $('#additional_type').parent().find('.error_msg').remove();
    $('#additional_type').removeClass('error_required');
 /*   var index = cat_arr.indexOf(parseInt(cat_id));
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
    }*/
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
    if (init_type) {
        $('#proptypename').val(prop_info["TypeID"]);
        init_type = false;
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
    if (init_country) {
        $('#countrylist').val(prop_info["CountryID"]);
        init_country = false;
    }
    else {
        $('#countrylist').val($("#countrylist option:first").val());
    }
    $('input[name=countryname]').val($("#countrylist option:selected").text());
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
    if (init_state) {
        $('#statelist').val(prop_info["StateProvinceID"]);
        init_state = false;
    }
    else {
        $('#statelist').val($("#statelist option:first").val());
    }
    $('input[name=statename]').val($("#statelist option:selected").text());
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
    if (init_city) {
        $('#citylist').val(prop_info["CityID"]);
        init_city = false;
    }
    else {
        $('#citylist').val($("#citylist option:first").val());
    }
    $('#citylist').trigger("chosen:updated");
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
// { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 }; Hotel
var hotel_type = [8, 2, 5, 16, 11, 24, 2, 19, 22, 12];
var room_id_arr = []; var newrooms=0;
function Init_DescriptionStepPage() {  //For descript & amenity page step1
    $('#roomwarper').hide();
    newrooms = 0;
    room_id_arr = [];
    var count = prop_amenity.length; //For amenities
    for (var ind = 0; ind < count; ind++) {
        $('#propamenity option[value=' + prop_amenity[ind].AmenityID + ']').attr('selected', true);
    }
//    console.log(prop_info["Description"].toString().replaceAll("<br\s*[\/]?>", "\n"));
    $('#_propdescription').text(prop_info["Description"]); //Description and Amenities
    $('#_propdescription').text($('#_propdescription').text().replaceAll("<br />", "\r\n"));
    $('#_propamenitytxt').text(prop_info["Amenities"]);
    $('#_propamenitytxt').text($('#_propamenitytxt').text().replaceAll("<br />", "\r\n"));
    if (hotel_type.indexOf(prop_info["CategoryID"]) == -1) { //If the vacation rental
    //    console.log(prop_furniture);
        $('#roomwarper').show();
        $('#roomcontainer').empty();
        var c_furnitures = prop_furniture.length;
        var roomid;
        for (var ind_fur = 0 ; ind_fur < c_furnitures; ind_fur++) {
            roomid = prop_furniture[ind_fur].RoomID;
            if (room_id_arr.indexOf(roomid) >= 0) { //Existed Room
                if (prop_furniture[ind_fur].FurnitureItemID != null && prop_furniture[ind_fur].FurnitureItemID != "") {
                    $('#roomcontainer input[value=' + roomid + ']').parent().find('.roomfurniture option[value=' + prop_furniture[ind_fur].FurnitureItemID + ']').attr('selected', true);
                }
            } else { //New room
                room_id_arr.push(roomid);
                var room_ind = room_id_arr.indexOf(roomid);
                var tagcontent = "<div class='srow'> \
                                    <input type='hidden' name='_roomids' value='" + roomid + "'/>\
                                <div class='srow group_form roomborder'> \
                                  <div class='center roomHeaer'>Room " + String.fromCharCode(room_ind + 65) + "</div>\
                                  <div class='col-x-4 col-3'> \
                                    <div class='srow group_form'> \
                                        <div class=''> \
                                              Title: \
                                        </div>\
                                        <div class=''>\
                                            <input type='text' name='_roomnames'  class='input_text medium_width required' placeholder='Room Title' />\
                                        </div>\
                                    </div>\
                                  </div> \
                                  <div class='col-x-4 col-9'> \
                                    <div class='srow group_form'>\
                                        <div class=''>\
                                            Sleeping arrangements and Furniture\
                                        </div>\
                                        <div class=''>\
                                            <select class='selectbox chosen-select large_width roomfurniture' multiple='multiple' name='room" + roomid + "'>\
                                            </select>\
                                        </div>\
                                     </div>\
                                  </div>\
                                    <div class='buttongroup'>\
                                        <input class='btnnormal removeroom' type='button'  value ='Remove Room'/>\
                                    </div>\
                                </div>\
                            </div>";
                $('#roomcontainer').append(tagcontent);
                $('#roomcontainer input[value=' + roomid + ']').parent().find('input[name=_roomnames]').val(prop_furniture[ind_fur].RoomTitle);
                $('#roomcontainer input[value=' + roomid + ']').parent().find('.roomfurniture').append(furniture_tag);
                if (prop_furniture[ind_fur].FurnitureItemID != null && prop_furniture[ind_fur].FurnitureItemID != '') {
                    $('#roomcontainer input[value=' + roomid + ']').parent().find('.roomfurniture option[value=' + prop_furniture[ind_fur].FurnitureItemID + ']').attr('selected', true);
                }
            }
        }
    }
    $('#wzardstep1 .chosen-select').chosen("destroy");
    $('#wzardstep1 .chosen-select').chosen();
    $('input').keypress(function () {
        $(this).parent().find('.error_msg').remove();
        $(this).removeClass('error_required');
    });
    $('.removeroom').click(function () {
        console.log("remove");
        $(this).parent().parent().parent().remove();
    });
}
//When clicking "add new room" button
function addNewRoom() {
    var roomid = "new" + newrooms++;
    var tagcontent = "<div class='srow'> \
                                    <input type='hidden' name='_roomids' value='" + roomid + "'/>\
                                <div class='srow group_form roomborder'> \
                                  <div class='center roomHeaer'>New Room</div>\
                                  <div class='col-x-4 col-3'> \
                                    <div class='srow group_form'> \
                                        <div class=''> \
                                              Title: \
                                        </div>\
                                        <div class=''>\
                                            <input type='text' name='_roomnames'  class='input_text medium_width required' placeholder='Room Title' />\
                                        </div>\
                                    </div>\
                                  </div> \
                                  <div class='col-x-4 col-9'> \
                                    <div class='srow group_form'>\
                                        <div class=''>\
                                            Sleeping arrangements and Furniture\
                                        </div>\
                                        <div class=''>\
                                            <select class='selectbox chosen-select large_width roomfurniture' multiple='multiple' name='room" + roomid + "'>\
                                            </select>\
                                        </div>\
                                     </div>\
                                  </div>\
                                    <div class='buttongroup'>\
                                        <input class='btnnormal removeroom' type='button'  value ='Remove Room'/>\
                                    </div>\
                                </div>\
                            </div>";
    $('#roomcontainer').append(tagcontent);
    $('#roomcontainer input[value=' + roomid + ']').parent().find('.roomfurniture').append(furniture_tag);
    $('#roomcontainer').find('.roomfurniture').chosen();
    $('#roomcontainer').find('.roomfurniture').trigger("chosen:updated");

    $('input').keypress(function () {
        $(this).parent().find('.error_msg').remove();
        $(this).removeClass('error_required');
    });
    $('.removeroom').click(function () {
        console.log("remove");
        $(this).parent().parent().parent().remove();
    });
}

function init_AttractionPage() {
    var count = prop_attraction.length;
    $('#_propattract').text(prop_info.LocalAttractions);
    for (var ind_attr=0 ; ind_attr < count; ind_attr++) {
        var attrid = prop_attraction[ind_attr].AttractionID;
        var nearid = prop_attraction[ind_attr].DistanceID;
        var obj_attr = $('#wzardstep2 input[name=attractids][value=' + attrid + ']');
        obj_attr.attr("checked", "checked");
        obj_attr.parent().parent().find('select option[value=' + nearid + ']').attr('selected', 'selected');
    }
}

function init_RatePage() {
    $('#minrate').val(prop_info.MinNightRate);
    $('#hirate').val(prop_info.HiNightRate);
    $('#currency').val(prop_info.MinRateCurrency);
    $('#rates').val(prop_info.Rates);
    $('#cancel').val(prop_info.CancellationPolicy);
    $('#deposit').val(prop_info.DepositRequired);
}