$(document).ready(function () {
    $('.btntab').click(function (e) {
        console.log($(this).attr('data-target'));
        var id = $(this).attr('data-target');
        $("ul.nav").find(".active").removeClass("active");
        $(this).parent().addClass("active");
        $("#" + id).parent().find(".active").removeClass("active");
        $("#" + id).addClass("active");
    });

    $(".bt_delete_Command").click(function () {
        if (confirm('Are you certain you want to delete this property?')) {
            var data_target = $(this).attr("data-target");
            var userid = $("#current_userid").val();
            window.location.href = "deleteproperty.aspx?UserID=" + userid + "&PropertyID=" + data_target;
        }
    });

    $(".bt_edittxt_Command").click(function () {
        var data_target = $(this).attr("data-target");
        var userid = $("#current_userid").val();
        window.location.href = "editproperty.aspx?UserID=" + userid + "&PropertyID=" + data_target;
    });
    $(".bt_editphoto_Command").click(function () {
        var data_target = $(this).attr("data-target");
        var userid = $("#current_userid").val();
        window.location.href = "propertyphotos.aspx?UserID=" + userid + "&PropertyID=" + data_target;
    });
    $(".bt_calendar_Command").click(function () {
        var data_target = $(this).attr("data-target");
        var userid = $("#current_userid").val();
        window.location.href = "propertycalendar.aspx?UserID=" + userid + "&PropertyID=" + data_target;
    });
    $(".bt_payment_Command").click(function () {
        var data_target = $(this).attr("data-target");
        var userid = $("#current_userid").val();
        window.location.href = "makepayment.aspx?UserID="+userid+"&PropertyID="+data_target+"&InvoiceID=-1";
    });
});

