
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
    calcDiscount();
    $('#coupon').blur(function (e) {
        calcDiscount();
    });
});

var _txtboxid = "";


function calcDiscount() {
    var coupon = $('#coupon').val();
    $.ajax({
        type: "POST",
        url: "/ajaxhelper.aspx/getcouponitem",
        data: '{coupon:"' + coupon + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: processPropertyData,
        failure: function (response) {
            console.log(response.d);
        }
    });
}

function processPropertyData(response) {
    //  console.log(response.d);
    var couponitem = response.d;

    var total = parseFloat($('#hid_total').val());
    var balance = parseFloat($('#hid_balance').val());
    var sum = parseFloat($('#hid_sum').val());

    if (couponitem.CID == 0) {
        $('#cou_discount').text('0%');
        $('#cou_rental_price').text($('#sumprice').val());
        $('#discounted_price').text("-0.00");
        return;
    }

    var discount = parseInt(couponitem.Discount);
    var sdate = new Date(couponitem.Start_date); var edate = new Date(couponitem.End_date);
    var cur_date = new Date();



    if (cur_date >= sdate && cur_date <= edate) {
        var discounted_reserve = sum * (100 - discount) / 100;
        var discounted_price = sum * discount / 100;
        var rent_total = discounted_reserve + balance;
        //  console.log(discount + " "+rent_total);
        $('#cou_discount').text(discount+"%");
        var ss_rent = discounted_reserve.toString();
        var ind = ss_rent.indexOf('.');
        if (ind != -1) $('#cou_rental_price').text(ss_rent.substring(0, ss_rent.indexOf('.') + 3));
        else $('#cou_rental_price').text(ss_rent + ".00");
        
        var tind = discounted_price.toString().indexOf('.');
        if (tind != -1) $('#discounted_price').text("-"+discounted_price.toString().substring(0, ss_rent.indexOf('.') + 3));
        else $('#discounted_price').text("-"+discounted_price + ".00");
    }
    else {
        $('#cou_discount').text('0%');
        $('#cou_rental_price').text($('#sumprice').val());
        $('#discounted_price').text("-0.00");
    }
}

