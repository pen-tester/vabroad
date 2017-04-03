
$(document).ready(function () {
    console.log("ready");

   // showdlg("Arrive<br>Error:this is test. ");
    $('.mclose').click(function () {
        $('#msgdlg').hide();
    });

    $('#btnsend').click(function (e) {
        var resp = paramcheck();
        if (resp == "") {
            $('form').submit();
        }
        else {
            console.log(resp);
            showdlg(resp);
        }
    });

    if ($('#t_error').val() != "") {
        showdlg($('#t_error').val());
    }
    if ($('#t_redirect').val() != "0") {
        showdlg("The password has been reset. <br/> You will be redirected login page after 3 seconds.");
        setTimeout(function () { window.location.href = "https://www.vacations-abroad.com/accounts/login.aspx" }, 3000);
    }

});


function paramcheck() {
    var str = "";
    var pwd = $('#upwd').val();
    var cpwd = $('#ucpwd').val();
    if (pwd == "" || pwd != cpwd) return "The password is empty or the confirm password doesn't match";
    return str;
}

function showdlg(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

  