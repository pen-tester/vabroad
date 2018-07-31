var redirect_links = [
        ["/applications.aspx", "/accounts/login.aspx?type=0"],
        ["/rentalguarantee.aspx"],
        ["/aboutus.aspx", "/press/AboutLindaKJenkins.pdf"],
        ["/presscoverage.aspx", "/pressreleases.aspx"],
        ["/Contacts.aspx", "http://blog2.vacations-abroad.com", "http://madmimi.com/signups/121428/join", "https://plus.google.com/+Vacations-abroad/posts", "https://twitter.com/vacationsabroad", "https://www.facebook.com/VacationsAbroad"]
],
    contact_links = ["/contacts.aspx", "/applications.aspx", "/rentalguarantee.aspx", "/aboutus.aspx", "/presscoverage.aspx", "http://blog2.vacations-abroad.com"],
    site_url = "https://www.vacations-abroad.com";

function onclickevent_footerment(e, t) {
    window.location.href = 4 == e && 0 < t ? redirect_links[e][t] : site_url + redirect_links[e][t]
}

function window_resize() {
    var e = 116 < $(".topNavigation").height() ? $(".topNavigation").height() : 116;
    $(".mainContent").css("margin-top", e), 0 != $("#google-cache-hdr").length ? (console.log("there is google cache content"), $("#google-cache-hdr").css({
        position: "fixed",
        "z-index": "110",
        top: "0",
        width: "100%"
    }), $(".topNavigation").css("top", $("#google-cache-hdr").outerHeight()), $(".mainContent").css("margin-top", $("#google-cache-hdr").outerHeight() + $(".topNavigation").height())) : console.log("there is not google cache"), $(".footertopline").width($(window).width()), $(window).width() < 400 ? $(".topNavigation").width($(window).width()) : $(".topNavigation").css({
        width: ""
    })
}

function redirect() {
    window.location.href = site_url + "/SearchTerms.aspx?SearchTerms=" + $("#tbKeyWords").val()
}

function getcountrylist(e) {
    make_rightmenu(e.id.split("_")[1])
}

function make_rightmenu(e) {
    var t = "#ajcountry" + e,
        a = $(t).parent().parent().parent(),
        o = a.height(),
        i = 600 < $(window).width() ? 111 : 300;
    a.find(".left-border").height(i < o ? o : i), console.log(t + "XXXX " + o)
}

function processTopCountryData(e) {
    var t = e.d;
    if (call_rid == t.regionid) {
        for (var a = t.statelist, o = 0; o < a.length; o++) {
            var i = "item" + call_rid + "_" + a[o].id,
                s = ' <li ><a href="/' + a[o].name.toLowerCase().replaceAll(" ", "_") + '/default.aspx" class="mmitem" id="' + i + '">' + a[o].name + "</a></li>";
            $("#ajcountry" + call_rid).append(s)
        }
        menuitem[call_rid] = 1, make_rightmenu(call_rid)
    }
}

function getmainmenu(e) {
    $.ajax({
        type: "POST",
        url: site_url + "/ajaxhelper.aspx/getstatelist",
        data: "{id:" + e + "}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processTopMenuData,
        failure: function (e) {
            alert(e.d)
        }
    })
}
$(document).ready(function () {
    $("#styles").html('<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="only x" onload="this.onload=null;this.media="all"; ">');
    console.log("the web page is ready in layout page"), $('input[type="text"]').keydown(function (e) {
        if (13 == e.keyCode) return e.preventDefault(), !1
    }), $(".contactitem").click(function () {
        var e = $(this).attr("data-target");
        console.log(e), window.location.href = 5 != e ? site_url + contact_links[e] : contact_links[e]
    }), $(".dropbtn").hover(function () {
        getcountrylist(this)
    }), window_resize(), $(window).resize(window_resize)
});
var call_cid = 0,
    call_rid = 0,
    callcountry = "",
    data_arr = [],
    menuitem = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

function callstateslist(e) {
    $(".itemselected").removeClass("itemselected"), $("#" + e).parent().parent().find(".itemselected").removeClass("itemselected"), $("#" + e).addClass("itemselected");
    var t = e.split("_");
    call_cid = t[1], callcountry = $("#" + e).text(), getmainmenu(call_cid)
}

function dropdownbtn(e) {
    $(".statelists").empty(), $(".allprop").attr("href", "#"), $(".itemselected").removeClass("itemselected");
    var t = $(e).parent().find("div div ul .mmitem").first().attr("id");
    $("#" + t).addClass("itemselected");
    var a = t.split("_");
    call_cid = a[1], callcountry = $("#" + t).text()
}

function processTopMenuData(e) {
    var t = e.d;
    if (call_cid == t.countryid) {
        var a = t.statelist;
        $(".statelists").empty();
        for (var o = 0; o < a.length; o++) {
            var i = "/" + callcountry.toLowerCase().replaceAll(" ", "_") + "/" + a[o].name.toLowerCase().replaceAll(" ", "_") + "/default.aspx";
            $(".statelists").append('<li><a href="' + i + '">' + a[o].name + "</a></li>"), $(".allprop").attr("href", "/" + callcountry.toLowerCase().replaceAll(" ", "_") + "/countryproperties.aspx"), $(".allprop").text("View all " + callcountry + " properties")
        }
    }
}
$(document).ready(function () { }), String.prototype.replaceAll = function (e, t) {
    return this.split(e).join(t)
};