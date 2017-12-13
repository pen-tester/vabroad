var search_box_trigger = 0;
$(document).ready(function () {
    console.log("ready");
   // initialize();

    //Jquery Slide down the step box
    $('#btn_filter').click(function () {
        if (search_box_trigger == 0) $('.borerstep').slideDown(); else $('.borerstep').slideUp();
        search_box_trigger = 1 - search_box_trigger;

        var step_width = $('.borerstep').width();
        console.log("step box width:" + step_width);

        $('.colfield_2').width(step_width - 70);
        if (step_width <= 768) $('.colfield_s2').width(step_width - 70);
    });

    //Show map button event 
    $('#btn_showmap').click(function () {
        $('#wrap_map').show();
        // setTimeout(function () { google.maps.event.trigger(mainmap, "resize"); }, 100);
        initialize();
    });

    $(window).click(function (event) {
        console.log("windows click");
        // $('#inqureform').hide();
        if (event.target.id == "wrap_map") {
            $('#wrap_map').hide();
        }
    });

    //Refresh the radio buttons
    RefreshStepbox();
    //Adding pagination
    allprops = $('input:hidden[name = pages]').val();
    addPagination(allprops);

    $('#cpage0').show();

    if (gmarkers.length == 0) {
        $('#container_search').css("width", "100%");
        $('#container_map').hide();
    }

    //For footer image logo alt text
    
    var cityname = $('#cityname').val();
    var title = "Vacations Abroad is a directory of " + cityname + " Vacation Rentals and " + cityname + " Boutique Hotels";
    $('#footerlogo').attr({ "title": title, "alt": title });
    //For map
   // initialize();
});

function RefreshStepbox() {
    //For proptype  proptyperadio
    var proptype = $('input:hidden[name = proptyperadio]').val();
    $("input[name=proptype][value=" + proptype + "]").attr('checked', 'checked');
    //For Room Number  roomnums
    var roomnums = $('input:hidden[name = bedroomtyperadio]').val();
    $("input[name=roomnums][value=" + roomnums + "]").attr('checked', 'checked');
    //For   Amenity Type
    var amenity = $('input:hidden[name = amenityradio]').val();
    $("input[name=amenitytype][value=" + amenity + "]").attr('checked', 'checked');
    //For Sort  proptyperadio
    var sort = $('input:hidden[name = sortradio]').val();
    $("input[name=pricesort][value=" + sort + "]").attr('checked', 'checked');
}


var cur_page = 0,allprops=0 ;
var min_groupnum = 0, max_group = 0, cpagenums = 0, max_page = 1;

function addPagination(allnums) {
    max_page = $('input:hidden[name = pages]').val();
   // max_page = Math.ceil(allnums / 20);
    console.log("pages info:pages, properties==>"+max_page + '  ' + allnums);
    min_groupnum = cur_page;
    showPagination(cur_page);
    //curpage
    changedPage();
}


function showPagination(cur_group) {
    max_group = Math.min(max_page, cur_group + 10);
    min_groupnum = cur_group;

    /* $('#paging').empty();
     $('#paging').append('<li><a onclick="backpage()">«</a></li>');
     for (i = cur_group; i < max_group; i++) {
         $('#paging').append('<li><a onclick="getpage(' + i + ')" id="page' + i + '">' + (i + 1) + '</a></li>');
     }
     $('#paging').append('<li><a onclick="nextpage()">»</a></li>');
     $('#page' + cur_page).addClass("curpage");
     */
    $('#paging').empty();
    $('#paging').append('<span class="pg-normal" onclick="backpage()">«Prev</span>');
    for (i = 0; i < max_page; i++) {
        $('#paging').append('|<span class="pg-normal" onclick="getpage(' + i + ')" id="page' + i + '">' + (i + 1) + '</span>');
    }
    $('#paging').append('|<span class="pg-normal"  onclick="nextpage()"> Next»</span>');
    $('#page' + cur_page).addClass("pg-selected");
}




function getpage(pagenum) {
    if (cur_page == pagenum) return;
    cur_page = pagenum;
    console.log(min_groupnum + ' ' + max_group + ' ' + cur_page);
    /* if (cur_page == min_groupnum && min_groupnum != 0) {
 
         showPagination(Math.max(cur_page - 4,0));
     }
     else if (cur_page == (max_group - 1) && cur_page != (max_page - 1)) showPagination(cur_page - 4);
     */

    //callPropAjax();
    changedPage();
}
function changedPage() {
    /*  if (cur_page == min_groupnum && min_groupnum != 0) {
  
          
      }
      else if (cur_page == (max_group - 1) && cur_page != (max_page - 1)) showPagination(cur_page - 4);
      */
    // showPagination(cur_page);
    $('.pagination').find(".pg-selected").removeClass("pg-selected");
    $('#page' + cur_page).addClass("pg-selected");
    $('.page_hid').hide();
    $('#cpage' + cur_page).show();
}


function backpage() {
    if (cur_page > 0) cur_page--;
    else return;
    changedPage();
}

function nextpage() {
    if ((cur_page + 1) < max_page) cur_page++;
    else return;
    changedPage();
}




















/*
    $(".scrollable .img_row").hover(function () {
        $(".scrollable").findClass(".selected_prop").removeClass("selected_prop");
        $(this).addClass("selected_prop");
        changemapmarker($(this));
    });
    */

    /*
    $(".scrollable").on("scrollstop", function () {
        console.log("Stopped scrolling!");
    });

   
    //After loading first
    $(".scrollable .img_row").each(function (i, e) {
        //For all element displayed.
        if (checkInView($(e), false)) {
            //$(this).css("background", "#333");
            changemapmarker($(e));
            return false;
        }
    });


    $(".scrollable").scroll(function (event) {
        var st = $(this).scrollTop();
        clearTimeout($.data(this, 'scrollTimer'));
        $.data(this, 'scrollTimer', setTimeout(function () {
            // do something
            console.log("Haven't scrolled in 250ms!");
            $(".scrollable .img_row").each(function (i, e) {
                
                //For partial element displayed.
                if (checkInView($(e), true)) {
                    return false;
                }
                // console.log("tttt");
            });
        }, 250));
        tmp_index = 0;
        $(".scrollable .img_row").each(function (i, e) {
            tmp_index ++;
            //For all element displayed.
            if (checkInView($(e), false)) {
                //$(this).css("background", "#333");
                _matched_index = tmp_index;
                changemapmarker($(e));
                return false;
            }
        });
        if (st > lastScrollTop) {
            // downscroll code
            direction = 1;

        } else {
            // upscroll code
            direction = -1;
        }

        lastScrollTop = st;
    });
    */

var min_rentaltypes = ["None", "2 Nights", "3 Nights", "1 Week", "2 Weeks", "Monthly", "1 Night"], prop_typeval = [8, 2, 5, 16, 11, 24, 2, 19, 22, 12], min_groupnum = 0, max_group = 0, cpagenums = 0;







function addOnemaker(map, data, highlighten) {
    var prop_category_types = [[4, 6, 14], [5, 11, 19, 22, 12, 13, 24], [2, 16, 8]];
    var img_urls = ["http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|154890",
        "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|6699ff",
        "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|ff6600",
        "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|cdbfac"
    ];
    var img_index = 3;
    for (var i = 0; i < 3; i++) {
        if (prop_category_types[i].indexOf(parseInt(data.categoryid)) > -1) {
            img_index = i;
            break;
        }
    }
    var myLatlng = new google.maps.LatLng(data.lat, data.lng);
    //var img_url = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
    var zindex=100;
    
    var img_url = img_urls[img_index];


    var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: data.description,
        icon: img_url,
        zIndex: zindex
    });

    (function (marker, data) {

        // Attaching a click event to the current marker
        google.maps.event.addListener(marker, "click", function (e) {
            window.open(data.URL);
            // infoWindow.setContent(data.description);
            //infoWindow.open(map, marker);
        });
    })(marker, data);
    return marker;
}

function addAllmarkers(map) {
    var bounds = new google.maps.LatLngBounds();
    for (i = 0; i < gmarkers.length; i++) {
        var data = gmarkers[i]
        var marker = addOnemaker(map, data,false);
        bounds.extend(marker.position);
        viewd_markers.push(marker);
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
    reloadMarkers();
    //addAllmarkers(mainmap)
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

function checkInView(elem, partial) {
    var container = $(".scrollable");
    var contHeight = container.height();
    var contTop = container.scrollTop();
    var contBottom = contTop + contHeight;

    var elemTop = $(elem).offset().top - container.offset().top;
    var elemBottom = elemTop + $(elem).height();

    var isTotal = (elemTop >= 0 && elemBottom <= contHeight);
    var isPart = ((elemTop < 0 && elemBottom > 0) || (elemTop > 0 && elemTop <= container.height())) && partial;

    return isTotal || isPart;
}
//For highlightening the map marker
function changemapmarker(element) {
    //  console.log(_lat_val + "   " + _longi_val);
    var tmp_lat_val = $(element).find('.lat_val').val();
    var tmp_longi_val = $(element).find('.long_val').val();
    for (var i = 0; i < gmarkers.length; i++) {
        var data = gmarkers[i];
        if (data.lat == _lat_val && data.lng == _longi_val) {
            viewd_markers[i].setMap(null);
            viewd_markers[i] = addOnemaker(mainmap, data, false);
        }
        if (data.lat == tmp_lat_val && data.lng == tmp_longi_val) {
            viewd_markers[i].setMap(null);
            viewd_markers[i] = addOnemaker(mainmap, data, true);
        }
    }
    _lat_val = tmp_lat_val; _longi_val = tmp_longi_val;
}



function reloadMarkers() {
    // Loop through markers and set map to null for each
    for (var i = 0; i < viewd_markers.length; i++) {
        viewd_markers[i].setMap(null);
    }

    // Reset the markers array
    viewd_markers = [];
    // Call set markers to re-add markers
    addAllmarkers(mainmap);
}

//For scroll view action and animation
var lastScrollTop = 0;
var direction = 1;
var viewd_markers = [];
var _lat_val, _longi_val;
var _matched_index=0,tmp_index=0;
