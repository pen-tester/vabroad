
$(document).ready(function () {
    $('.shareitem').mouseleave(function () {
        $(this).children('.shareicon').fadeIn();
        console.log("out");
    });
    $('.shareitem').mouseover(function () {
        $(this).children('.shareicon').fadeOut();
        console.log("in");
    });

});

