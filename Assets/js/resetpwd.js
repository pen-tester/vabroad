
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
        showdlg("You will get the reset link soon. <br/> You will be redirected login page after 3 seconds.");
        setTimeout(function () { window.location.href = "https://www.vacations-abroad.com/accounts/login.aspx" }, 3000);
    }

});


function paramcheck() {
    var str = "";
    pattern = new RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!pattern.test($('#uemail').val())) {
        resp = "Email Format is not correct";
        return resp;
    }
    return str;
}

function showdlg(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

  