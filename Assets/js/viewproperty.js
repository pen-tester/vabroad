var RecaptchaOptions = {
    theme: 'white'
};


var $element;
$(document).ready(function () {
    $("div.ViewPropertyPageFonts").html($("div.ViewPropertyPageFonts").text());

    $element = $('#modal_contents').bind('webkitAnimationEnd', function () {
        this.style.webkitAnimationName = '';
    });

    $('ul.tabs li').click(function () {
        var tab_id = $(this).attr('data-tab');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $(this).addClass('current');
        $("#" + tab_id).addClass('current');
        if (tab_id == "tabs-3") {
            console.log("tst");

            //robot = 0;

            $element.css('webkitAnimationName', 'animatetop');
            // you'll probably want to preventDefault here.

            $('#inqureform').show();
        } else if (tab_id == "tabs-1") {
            var target = $(this).attr('data-target');
            window.location.href = 'writereview.aspx' + target;
        } else {
            $("html, body").animate({
                scrollTop: $("#" + tab_id).offset().top
            })
        }
    });

    $('#closeform').click(function () {
        $('#inqureform').hide();
    });
    $('#msgclose').click(function () {
        $('#msgdlg').hide();
    });
    $('#btnsend').click(function (e) {
        var resp = paramcheck();
        if (resp == "") {
            robot = 0;
            $('#bodycontent_SubmitButton').click();
            console.log("pass the content.");
        }
        else {
            console.log(resp);
            showdlg(resp);
        }
    });

});

$(window).click(function (event) {
    console.log("windows click");
    // $('#inqureform').hide();
    if (event.target.id == "inqureform") {
        $('#inqureform').hide();
    }
});

function showdlg(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

function paramcheck() {
    var resp = "";
    if (robot == 0) {
        resp = "You have to validate that you are not robot.";
        return resp;
    }
    if ($('#bodycontent_ContactName').val() == "") { resp = "Your name is Required! <br/>"; return resp; }
    if ($('#bodycontent_ContactEmail').val() == "") { resp = "Your email is Required! <br/>"; return resp; }
    var pattern = new RegExp("^[a-zA-Z0-9 \.\-]+$");
    if (!pattern.test($('#bodycontent_ContactName').val())) {
        resp = "Name Format is not correct";
        return resp;
    }
    pattern = new RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!pattern.test($('#bodycontent_ContactEmail').val())) {
        resp = "Email Format is not correct";
        return resp;
    }

    pattern = new RegExp("^[0-9]*$");

    if (!pattern.test($('#bodycontent_HowManyNights').val())) {
        resp += "#Nights has to be number";
        return resp;
    }
    if (!pattern.test($('#bodycontent_HowManyAdults').val())) {
        resp += "#Adults has to be number";
        return resp;
    }
    if (!pattern.test($('#bodycontent_HowManyChildren').val())) {
        resp += "#Children has to be number";
        return resp;
    }
    return resp;
}

var robot = 0;
function recaptchaCallback() {
    robot = 1;
}