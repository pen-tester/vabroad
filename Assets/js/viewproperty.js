﻿var $element,RecaptchaOptions={theme:"white"};function showdlg(t){$("#modalmsg").html(t),$("#msgdlg").show()}function paramcheck(){var t="";if(0==robot)return t="You have to validate that you are not robot.";if(""==$("#bodycontent_ContactName").val())return t="Your name is Required! <br/>";if(""==$("#bodycontent_ContactEmail").val())return t="Your email is Required! <br/>";var o=new RegExp("^[a-zA-Z0-9 .-]+$");return o.test($("#bodycontent_ContactName").val())?(o=new RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,4}$")).test($("#bodycontent_ContactEmail").val())?(o=new RegExp("^[0-9]*$")).test($("#bodycontent_HowManyNights").val())?o.test($("#bodycontent_HowManyAdults").val())?o.test($("#bodycontent_HowManyChildren").val())?t:t+="#Children has to be number":t+="#Adults has to be number":t+="#Nights has to be number":t="Email Format is not correct":t="Name Format is not correct"}!function(t){t.fn.gotoLocation=function(){var offset=parseFloat(t(this).offset().top)+350;console.log(offset);t("html, body").animate({scrollTop:offset},500)}}(jQuery),$(document).ready(function(){$element=$("#modal_contents").bind("webkitAnimationEnd",function(){this.style.webkitAnimationName=""}),$("ul.tabs li").click(function(){var t=$(this).attr("data-tab");$("ul.tabs li").removeClass("current"),$(".tab-content").removeClass("current"),$(this).addClass("current"),$("#"+t).addClass("current"),"tabs-3"==t?(console.log("tst"),$element.css("webkitAnimationName","animatetop"),$("#inqureform").show()):$("#"+t).gotoLocation()}),$("#closeform").click(function(){$("#inqureform").hide()}),$("#msgclose").click(function(){$("#msgdlg").hide()}),$("#btnsend").click(function(t){var o=paramcheck();""==o?(robot=0,$("#bodycontent_SubmitButton").click(),console.log("pass the content.")):(console.log(o),showdlg(o))})}),$(window).click(function(t){console.log("windows click"),"inqureform"==t.target.id&&$("#inqureform").hide()});var robot=0;function recaptchaCallback(){robot=1}