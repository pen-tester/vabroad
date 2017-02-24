
$(document).ready(function () {
    console.log("ready");
    $('#SendQuote').click(function (e) {
        $('#errormsg').hide();
        if ($('#chk_agree').is(':checked')) {
            e.preventDefault();
            $('#mainform').attr('action', "/payment.aspx").submit();
        }
        else {
            $('#errormsg').text("You have to agree all");
            $('#errormsg').show();
        }
    });
});

var _txtboxid = "";

