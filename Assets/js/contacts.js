/*setInterval(showcurrenttime, 1000);
function showcurrenttime() {
    var dt = new Date();
    $('#curtime').text(dt.getHours()+ ":" + dt.getMinutes() + ":" + dt.getSeconds());
    
}*/

$(document).ready(function () {

    $('.mclose').click(function () {
        $('#msgform').hide();
    });
    $('#btnsendemail').click(function (e) {
        showmsg("Now developing for this function.");
    });
});

function showmsg(msg) {
    $('#modalmsg').html(msg);
    $('#msgform').show();
}