var hrefs = ["https://www.facebook.com/sharer/sharer.php?u=https%3A//www.vacations-abroad.com/contest.aspx", "https://twitter.com/home?status=https%3A//www.vacations-abroad.com/contest.aspx", "https://pinterest.com/pin/create/button/?url=&media=https%3A//www.vacations-abroad.com/contest.aspx&description=", "https://plus.google.com/share?url=https%3A//www.vacations-abroad.com/contest.aspx", "https://www.linkedin.com/shareArticle?mini=true&url=https%3A//www.vacations-abroad.com/contest.aspx&title=Contest%20for%20vacations%20abroad&summary=&source="];
$(document).ready(function () {
    $(".glenn").click(function () {
        console.log("share icon click");
        var index_href = $(this).data("target");
        var left = ($(window).width() / 2 - 300), top = ($(window).height() / 2 - 450);
        var popup = window.open(hrefs[index_href], "popup", "width=600,height=900,top=" + top + ", left=" + left);
    });
  
});