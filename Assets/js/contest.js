
$(document).ready(function () {
    $('.contest_footer_share li').mouseleave(function () {
        $(this).children('.shareitem').fadeIn();
        console.log("out");
    });
    $('.contest_footer_share li').mouseover(function () {
        $(this).children('.shareitem').fadeOut();
        console.log("in");
    });

});

