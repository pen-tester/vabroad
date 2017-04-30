function refresh_radios() { var e = $('input:hidden[name="proptyperadio"]').val(), a = $('input:hidden[name="bedroomtyperadio"]').val(), n = $('input:hidden[name="amenityradio"]').val(), i = $('input:hidden[name="sortradio"]').val(); $("input[name=proptype][value=" + e + "]").prop("checked", !0), $('input[name="roomnums"][value="' + a + '"]').prop("checked", !0), $('input[name="amenitytype"][value="' + n + '"]').prop("checked", !0), $('input[name="pricesort"][value="' + i + '"]').prop("checked", !0) } function refreshpage() { } function refreshprop() { var e = ' <div class="loading-bro">  <h1>Searching...</h1>  <svg id="load" x="0px" y="0px" viewBox="0 0 150 150"> <circle id="loading-inner" cx="75" cy="75" r="60"/></svg>  </div>'; $(".pcontent").empty().append(e), refresh_flag = 1, cur_page = 0, callProplistfunction(cur_page) } function callProplistfunction(e) { var a = $("#cityid").val(), n = $("input[name=roomnums]:checked").val(), i = $("input[name=amenitytype]:checked").val(), t = $("input[name=pricesort]:checked").val(), p = $("input[name=proptype]:checked").val(); getpropertylist(a, p, i, n, t, e) } function getpropertylist(e, a, n, i, t, p) { console.log("call ajax"), $.ajax({ type: "POST", url: "/ajaxHelper.aspx/getpropertylistcityid", data: '{cityid:"' + e + '",proptype:' + a + ",amenitytype:" + n + ",roomnum:" + i + ",sorttype:" + t + ",pagenum:" + p + "}", contentType: "application/json; charset=utf-8", dataType: "json", success: processPropertyData, failure: function (e) { console.log(e.d) } }) } function processPropertyData(e) { var a = e.d.propertyList, n = e.d.allnums; 1 == refresh_flag && addPagination(n), refresh_flag = 0, 0 != n ? displayContent(a) : $(".pcontent").empty().append('<div class="newrow centered">No results</div>') } function displayContent(e) { $(".pcontent").empty(); var a = e.length; for (i = 0; i < a; i++) { var n = e[i], t = n.detail.PropertyName + " " + n.detail.NumBedrooms + " Bedroom " + n.detail.NumBaths + " BA Sleeps " + n.detail.NumSleeps, p = "Rates: " + n.detail.MinNightRate + "-" + n.detail.HiNightRate + "  " + n.detail.MinRateCurrency + " Per Night " + min_rentaltypes[n.detail.MinimumNightlyRentalID], o = "Amenity:  ", r = n.amenity.length, l = "/" + n.detail.Country + "/" + n.detail.StateProvince + "/" + n.detail.City + "/" + n.detail.ID + "/default.aspx", c = ("/" + n.detail.Country + "/" + n.detail.StateProvince + "/" + n.detail.City + "/default.aspx", "/" + n.detail.Country + "/" + n.detail.StateProvince + "/default.aspx", -1 == prop_typeval.indexOf(n.detail.Category) ? n.detail.City + " " + n.detail.NumBedrooms + " bedroom Vacation Rental" : n.detail.City + " " + n.detail.NumBedrooms + " bedroom Hotel"); for (j = 0; j < r; j++) o += n.amenity[j].Amenity + ", "; o = o.substring(0, o.length - 2); var d = '<div class="newrow">                 <div class="col-2">                     <div class="drop-shadow effect4">                       <a href="' + l.toLowerCase().replaceAll(" ", "_") + '"> <img title="' + c + '" alt="' + c + '" src="/images/' + n.detail.FileName + '"/></a>                     </div>                     <div class="newrow">                         <label class="imgtitle">' + n.detail.Name2 + ' </label>                     </div>                 </div>                          <div class="col-6">                    <div class="explaination">                        <div class="ex_con1">                            <a href="' + l.toLowerCase().replaceAll(" ", "_") + '"> ' + t + '</a>                        </div>                        <div class="ex_con2">' + p + ' </div>                        <div class="ex_con2">' + o + ' </div>                        <div class="ex_con3">' + n.detail.Name + " </div>                    </div>                </div>                </div>"; $(".pcontent").append(d) } } function showPagination(e) { for (max_group = Math.min(max_page, e + 10), min_groupnum = e, $("#paging").empty(), $("#paging").append('<span class="pg-normal" onclick="backpage()">«Prev</span>'), i = e; i < max_page; i++) $("#paging").append('|<span class="pg-normal" onclick="getpage(' + i + ')" id="page' + i + '">' + (i + 1) + "</span>"); $("#paging").append('|<span class="pg-normal"  onclick="nextpage()"> Next»</span>'), $("#page" + cur_page).addClass("pg-selected") } function addPagination(e) { max_page = Math.ceil(e / 20), console.log(max_page + "  " + e), min_groupnum = cur_page, showPagination(cur_page), changedPage() } function callPropAjax() { var e = ' <div class="loading-bro">  <h1>Searching...</h1>  <svg id="load" x="0px" y="0px" viewBox="0 0 150 150"> <circle id="loading-inner" cx="75" cy="75" r="60"/></svg>  </div>'; $(".pcontent").empty().append(e), $(".pagination").find(".pg-selected").removeClass("pg-selected"), $("#page" + cur_page).addClass("pg-selected"), callProplistfunction(cur_page) } function getpage(e) { cur_page != e && (cur_page = e, console.log(min_groupnum + " " + max_group + " " + cur_page), changedPage()) } function changedPage() { $(".pagination").find(".pg-selected").removeClass("pg-selected"), $("#page" + cur_page).addClass("pg-selected"), $(".pcontent").find(".pagecurrent").removeClass("pagecurrent"), $("#cpage" + cur_page).addClass("pagecurrent") } function backpage() { cur_page > 0 && (cur_page--, changedPage()) } function nextpage() { max_page > cur_page + 1 && (cur_page++, changedPage()) } var cur_page = 0, max_page = 1, refresh_flag = 0; $(document).ready(function () {
    console.log("map");
    initialize();
    console.log("ready"), refresh_radios(); var e = $('input:hidden[name="allpages"]').val(); addPagination(e);
    if (gmarkers.length == 0) {
        $('#wrap_map').hide();
        $('#lbl_City').removeClass("col-6");
    }

}); var min_rentaltypes = ["None", "2 Nights", "3 Nights", "1 Week", "2 Weeks", "Monthly", "1 Night"], prop_typeval = [8, 2, 5, 16, 11, 24, 2, 19, 22, 12], min_groupnum = 0, max_group = 0, cpagenums = 0;

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

var mainmap, onemap;

function initialize() {
    mainmap = initializeMap("map_canvas");
    addAllmarkers(mainmap)
}


function initializeMap(mapid) {
    console.log("mainmap" + mapid);
    var mapOptions = {
        center: new google.maps.LatLng(51.5, -0.12),
        zoom: 5,
        mapTypeId: google.maps.MapTypeId.ROADMAP
        //  marker:true
    };
    var map = new google.maps.Map(document.getElementById(mapid), mapOptions);
    return map;
}
