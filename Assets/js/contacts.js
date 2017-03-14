/*setInterval(showcurrenttime, 1000);
function showcurrenttime() {
    var dt = new Date();
    $('#curtime').text(dt.getHours()+ ":" + dt.getMinutes() + ":" + dt.getSeconds());
    
}*/

$(document).ready(function () {

    $('#msgclose').click(function () {
        $('#msgform').hide();
    });
    $('#inquriyclose').click(function () {
        $('#inquiryform').hide();
    });
    $('#btnsendemail').click(function (e) {
        $('#inquiryform').show();
    });
    $('#btnsend').click(function (e) {
        var resp = checkparam();
        if (resp != "") { showmsg(resp); return; }
        else { console.log("submit");  $('#bodycontent_btnsendback').click(); }
    })
});

function showmsg(msg) {
    $('#modalmsg').html(msg);
    $('#msgform').show();
}

function checkparam() {
    var resp = "";
    if (robot == 0) {
        resp = "You have to validate that you are not robot.";
        return resp;
    }
    if ($('#username').val() == "") return "Your name is required";
    if ($('#useremail').val() == "") return "Your email is required";
    if ($('#userselect').val() == "0") return "Please select the subject";
    var pattern = new RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!pattern.test($('#useremail').val())) {
        resp = "Email Format is not correct";
        return resp;
    }
    return resp;
}


var robot = 0;
function recaptchaCallback() {
    robot = 1;
}