﻿var redirect_links=[["/applications.aspx","/accounts/login.aspx?type=0"],["/rentalguarantee.aspx"],["/aboutus.aspx","/press/AboutLindaKJenkins.pdf"],["/presscoverage.aspx","/pressreleases.aspx"],["/Contacts.aspx","http://blog2.vacations-abroad.com","http://madmimi.com/signups/121428/join","https://plus.google.com/+Vacations-abroad/posts","https://twitter.com/vacationsabroad","https://www.facebook.com/VacationsAbroad"]],contact_links=["/contacts.aspx","/applications.aspx","/rentalguarantee.aspx","/aboutus.aspx","/presscoverage.aspx","http://blog2.vacations-abroad.com"],site_url="https://www.vacations-abroad.com";function onclickevent_footerment(t,e){window.location.href=4==t&&0<e?redirect_links[t][e]:site_url+redirect_links[t][e]}function window_resize(){var t=116<$(".topNavigation").height()?$(".topNavigation").height():116;$(".mainContent").css("margin-top",t),0!=$("#google-cache-hdr").length?(console.log("there is google cache content"),$("#google-cache-hdr").css({position:"fixed","z-index":"110",top:"0",width:"100%"}),$(".topNavigation").css("top",$("#google-cache-hdr").outerHeight()),$(".mainContent").css("margin-top",$("#google-cache-hdr").outerHeight()+$(".topNavigation").height())):console.log("there is not google cache"),$(".footertopline").width($(window).width()),$(window).width()<400?$(".topNavigation").width($(window).width()):$(".topNavigation").css({width:""})}function redirect(){window.location.href=site_url+"/SearchTerms.aspx?SearchTerms="+$("#tbKeyWords").val()}function getcountrylist(t){make_rightmenu(t.id.split("_")[1])}function make_rightmenu(t){var e="#ajcountry"+t,a=$(e).parent().parent().parent(),o=a.height(),i=600<$(window).width()?111:300;a.find(".left-border").height(i<o?o:i),console.log(e+"XXXX "+o)}function processTopCountryData(t){var e=t.d;if(call_rid==e.regionid){for(var a=e.statelist,o=0;o<a.length;o++){var i="item"+call_rid+"_"+a[o].id,n=' <li ><a href="/'+a[o].name.toLowerCase().replaceAll(" ","_")+'/default.aspx" class="mmitem" id="'+i+'">'+a[o].name+"</a></li>";$("#ajcountry"+call_rid).append(n)}menuitem[call_rid]=1,make_rightmenu(call_rid)}}function getmainmenu(t){$.ajax({type:"POST",url:site_url+"/ajaxhelper.aspx/getstatelist",data:"{id:"+t+"}",contentType:"application/json; charset=utf-8",dataType:"json",success:processTopMenuData,failure:function(t){alert(t.d)}})}document.getElementsByTagName("head")[0].appendChild(stylesheet),$(document).ready(function(){$("#styles").html('<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css" media="only x" onload="this.onload=null;this.media="all"; ">'),console.log("the web page is ready in layout page"),$('input[type="text"]').keydown(function(t){if(13==t.keyCode)return t.preventDefault(),!1}),$(".contactitem").click(function(){var t=$(this).attr("data-target");console.log(t),window.location.href=5!=t?site_url+contact_links[t]:contact_links[t]}),$(".dropbtn").hover(function(){getcountrylist(this)}),window_resize(),$(window).resize(window_resize)});var call_cid=0,call_rid=0,callcountry="",data_arr=[],menuitem=[0,0,0,0,0,0,0,0,0,0,0];function callstateslist(t){$(".itemselected").removeClass("itemselected"),$("#"+t).parent().parent().find(".itemselected").removeClass("itemselected"),$("#"+t).addClass("itemselected");var e=t.split("_");call_cid=e[1],callcountry=$("#"+t).text(),getmainmenu(call_cid)}function dropdownbtn(t){$(".statelists").empty(),$(".allprop").attr("href","#"),$(".itemselected").removeClass("itemselected");var e=$(t).parent().find("div div ul .mmitem").first().attr("id");$("#"+e).addClass("itemselected");var a=e.split("_");call_cid=a[1],callcountry=$("#"+e).text()}function processTopMenuData(t){var e=t.d;if(call_cid==e.countryid){var a=e.statelist;$(".statelists").empty();for(var o=0;o<a.length;o++){var i="/"+callcountry.toLowerCase().replaceAll(" ","_")+"/"+a[o].name.toLowerCase().replaceAll(" ","_")+"/default.aspx";$(".statelists").append('<li><a href="'+i+'">'+a[o].name+"</a></li>"),$(".allprop").attr("href","/"+callcountry.toLowerCase().replaceAll(" ","_")+"/countryproperties.aspx"),$(".allprop").text("View all "+callcountry+" properties")}}}$(document).ready(function(){}),String.prototype.replaceAll=function(t,e){return this.split(t).join(e)};