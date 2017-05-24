$(document).ready(function () {
    $('.btntab').click(function (e) {
        //console.log($(this).attr('data-target'));
        var id = $(this).attr('data-target');
        $("ul.nav").find(".active").removeClass("active");
        $(this).parent().addClass("active");
        $("#" + id).parent().find(".active").removeClass("active");
        $("#" + id).addClass("active");
    });
    $('#fblogin').click(function () {
        console.log("fb login");
        facebooklogin();
    });
});

function facebooklogin() {
    FB.getLoginStatus(function (response) {
        if (response.status === 'connected') {
            console.log('Logged in.');
        }
        else {
            FB.login();
        }
    });
}

