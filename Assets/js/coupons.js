$(document).ready(function () {
    $('#msgclose').click(function () {
        $('#msgdlg').hide();
    });
    $('#n_end').datepicker({ dateFormat: 'yy-mm-dd' });
    $('#n_start').datepicker({ dateFormat: 'yy-mm-dd' }).bind("change", function () {
        var minvalue = $(this).val();
        minvalue = $.datepicker.parseDate("yy-mm-dd", minvalue);
        minvalue.setDate(minvalue.getDate() + 1);
        $('#n_end').datepicker("option", "minDate", minvalue);
    });

    $('#n_add').click(function (e) {
        var resp = checkparam();
        if (resp != "") {
            showdlg(resp);
        }
        else {
            $('#newcoupon').click();
        }
    });

    max_cou_page = $('#cpages').val();
    $('.cou_page' + cur_cou_page).removeClass("hidden");

    $('#cprev').click(function (e) {
        if (cur_cou_page > 0) cur_cou_page--;
        $('.cou_page' + (cur_cou_page+1)).addClass("hidden");
        show_cou_page();
    });
    $('#cnext').click(function (e) {
        if (cur_cou_page < (max_cou_page-1)) cur_cou_page++;
        $('.cou_page' + (cur_cou_page - 1)).addClass("hidden");
        show_cou_page();
    });

    $('.cou_page').click(function (e) {
        $('.cou_page' + cur_cou_page).addClass("hidden");
        cur_cou_page = this.id.substring(6);
        $('.cou_page').removeClass("activepage");
        $(this).addClass("activepage");
        
        console.log(cur_cou_page);
        show_cou_page();
    })
    show_cou_page();

    max_use_page = $('#cp_pages').val();
    $('.cu_page' + cur_use_page).removeClass("hidden");

    $('#cuprev').click(function (e) {
        if (cur_use_page > 0) cur_use_page--;
        $('.cu_page' + (cur_use_page + 1)).addClass("hidden");
        show_use_page();
    });
    $('#cunext').click(function (e) {
        if (cur_use_page < (max_use_page - 1)) cur_use_page++;
        $('.cu_page' + (cur_use_page - 1)).addClass("hidden");
        show_use_page();
    });

    $('.cu_page').click(function (e) {
        $('.cu_page' + cur_use_page).addClass("hidden");
        cur_use_page = this.id.substring(7);
        $('.cu_page').removeClass("activepage");
        $(this).addClass("activepage");

        console.log(cur_use_page);
        show_use_page();
    })
    show_use_page();
});

$(window).click(function (event) {

});

function showdlg(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

function checkparam() {
    var resp = "";
    if ($('#n_discount').val() == "") { return "Discount is Required!"; }
    if ($('#n_coupon').val() == "") { return "Coupon String is Required!"; }
    if ($('#n_start').val() == "") { return "Start Date is Required!"; }
    if ($('#n_end').val() == "") { return "End Date is Required!"; }

    pattern = new RegExp("^[0-9]{0,2}$");

    if (!pattern.test($('#n_discount').val())) {
        resp = "Discount has to be number and less than 100.";
        return resp;
    }
    return resp;
}

function del_coupon(item_id) {
    $('#del_id').val(item_id);
    $('#DelCom').click();
}

var cur_cou_page=0,max_cou_page;
function show_cou_page() {
    // $('.cou_page' + cur_cou_page).addClass("hidden");
    $('.cou_page').removeClass("activepage");
    $('.cou_page' + cur_cou_page).removeClass("hidden");
    $('#_cpage' + cur_cou_page).addClass("activepage");
}





//For coupon use page
var cur_use_page = 0, max_use_page;
function show_use_page() {
    // $('.cou_page' + cur_cou_page).addClass("hidden");
    $('.cu_page').removeClass("activepage");
    $('.cu_page' + cur_use_page).removeClass("hidden");
    $('#_cupage' + cur_use_page).addClass("activepage");
}

