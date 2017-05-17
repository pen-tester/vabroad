﻿var redirect_links = [["/applications.aspx", "/accounts/login.aspx?type=0"], ["/rentalguarantee.aspx"], ["/aboutus.aspx", "/press/AboutLindaKJenkins.pdf"]
    , ["/presscoverage.aspx", "/pressreleases.aspx"], ["/Contacts.aspx", "http://blog2.vacations-abroad.com", "http://madmimi.com/signups/121428/join", "https://plus.google.com/+Vacations-abroad/posts", "https://twitter.com/vacationsabroad", "https://www.facebook.com/VacationsAbroad"]];

var contact_links = ["/contacts.aspx", "/applications.aspx", "/rentalguarantee.aspx", "/aboutus.aspx"];

function onclickevent_footerment(menuindex, itemindex) {
    //alert(menuindex + "   " + itemindex);
    window.location.href = redirect_links[menuindex][itemindex];
}


$(document).ready(function () {
    //$('links').attr("media","none");
    $('head').append('<link id="fontcss" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet"  media="none"/>');
    setTimeout(function () { $('#fontcss').attr("media", "all"); }, 0);
    $('input[type="text"]').keydown(function (event) {
        if (event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });
    $('.contactitem').click(function () {
        var target = $(this).attr("data-target");
        console.log(target);
        window.location.href = contact_links[target];
    });
})

function redirect() {
    window.location.href = "/SearchTerms.aspx?SearchTerms=" + $('#tbKeyWords').val();
}

function getcountrylist(item) {

    //console.log(item.id);
    var rid = item.id.split("_")[1];




    if (menuitem[rid] != 0) {
        dropdownbtn(item);
        var selector = "#ajcountry" + rid;
        var mainmenu = $(selector).parent().parent().parent();
        var r_height = mainmenu.height();
        // mainmenu.find('.right-border').height(r_height);
        var s_height= mainmenu.find('.left-border').height();
       
        mainmenu.find('.left-border').height((r_height>s_height)?r_height:s_height);
        // $("#menu" + call_rid + " .left-border").height(r_height);
        console.log(selector + "XXXX " + r_height);
        return;
    }
   // console.log("countrylist" + rid);
    call_rid = rid;
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getcountrylist",
        data: '{id:' + rid + '}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processTopCountryData,
        failure: function (response) {
            alert(response.d);
        }
    });
}


function processTopCountryData(response) {
    var statelist = response.d;
    //console.log(statelist);
    if (call_rid != statelist.regionid) return;
    var states = statelist.statelist;
    //$(".ajcountry").empty();
    for (var i = 0; i < states.length; i++) {
        var id = "item" + call_rid + '_' + states[i].id;
        var href = "/" + states[i].name.toLowerCase().replaceAll(" ", "_") + "/default.aspx";
        // var item = ' <li ><a href="'+href+'" class="mmitem" onmouseover="callstateslist(\''+id+'\')" id="' + id + '">' + states[i].name + '</a></li>';
        var item = ' <li ><a href="' + href + '" class="mmitem" id="' + id + '">' + states[i].name + '</a></li>';
        $("#ajcountry"+call_rid).append(item);
        // $(".statelists").append('<li><a>' + states[i].name + '</a></li>');
    }
    menuitem[call_rid] = 1;
    var selector = "#ajcountry" + call_rid;
    var mainmenu = $(selector).parent().parent().parent();
    var r_height = mainmenu.height();
    // mainmenu.find('.right-border').height(r_height);
    var s_height = mainmenu.find('.left-border').height();
    mainmenu.find('.left-border').height((r_height > s_height) ? r_height : s_height);
    console.log(selector + " " + r_height );
  //  dropdownbtn("#reg_" + call_rid);
}



function getmainmenu(cid) {
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getstatelist",
        data: '{id:'+cid+'}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processTopMenuData,
        failure: function (response) {
            alert(response.d);
        }
    });



}

var call_cid = 0;
var call_rid = 0;
var callcountry = "";
var data_arr = [];
var menuitem = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

function callstateslist(cid) {

    $(".itemselected").removeClass("itemselected");
    $("#" + cid).parent().parent().find(".itemselected").removeClass("itemselected");
    $("#" + cid).addClass("itemselected");
    var sp_str = cid.split("_");
    call_cid = sp_str[1];
    callcountry = $("#" + cid).text();
    getmainmenu(call_cid);
}

function dropdownbtn(item){
     $(".statelists").empty();
    $(".allprop").attr("href", "#");
    $(".itemselected").removeClass("itemselected");
    var cid = $(item).parent().find("div div ul .mmitem").first().attr("id");
    $("#" + cid).addClass("itemselected");
    var sp_str = cid.split("_");
    call_cid = sp_str[1];
    callcountry = $("#" + cid).text();
   // getmainmenu(call_cid);
}


$(document).ready(function() {
    //mmitem
  /*  $(".mmitem").mouseover(function () {

        callstateslist();
    });
    */
    /*
    $(".dropbtn").mouseover(function () {
      $(".statelists").empty();
        $(".allprop").attr("href", "#");
        $(".itemselected").removeClass("itemselected");
        var cid = $(this).parent().find("div div ul .mmitem").first().attr("id");
        $("#" + cid).addClass("itemselected");
        var sp_str = cid.split("_");
        call_cid = sp_str[1];
        callcountry = $("#" + cid).text();
        getmainmenu(call_cid);
       
    }); */



});

String.prototype.replaceAll = function (search, replacement) {
    var target = this;
    return target.split(search).join(replacement);
};

function processTopMenuData(response){
    var statelist = response.d;
    if (call_cid != statelist.countryid) return;
    var states = statelist.statelist;
    $(".statelists").empty();
    for (var i = 0; i < states.length; i++) {
        var link = "/" + callcountry.toLowerCase().replaceAll(" ", "_") + "/" + states[i].name.toLowerCase().replaceAll(" ", "_") + "/default.aspx";
         $(".statelists").append('<li><a href="' + link + '">' + states[i].name + '</a></li>');
       // $(".statelists").append('<li><a>' + states[i].name + '</a></li>');
         $(".allprop").attr("href", "/" + callcountry.toLowerCase().replaceAll(" ", "_") + "/countryproperties.aspx");
         $(".allprop").text("View all " +callcountry+ " properties");
    }
}

