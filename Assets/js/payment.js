
$(document).ready(function () {
    console.log("doc ready");
    calcDiscount();
    $('#coupon').blur(function (e) {
        calcDiscount();
    });
});

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
        $('#discounted_price').text('-0.00');
        $('#cou_rental_price').text($('#hid_total').val());
        $('#rental_price').text($('#totalsum').val());
        return;
    }

    var discount =parseInt( couponitem.Discount);
    var sdate =new Date( couponitem.Start_date); var edate =new Date(couponitem.End_date);
    var cur_date = new Date();

    

    if (cur_date >= sdate && cur_date <= edate) {
        
        var rent_total = sum * (100 - discount) / 100;
        var discounted_price = sum * discount / 100;

        var total_price = rent_total + balance;


      //  console.log(discount + " "+rent_total);
        $('#cou_discount').text(discount+"%");
        var ss_rent = rent_total.toString();
        var ind = ss_rent.indexOf('.');
        if (ind != -1) $('#rental_price').text(ss_rent.substring(0, ind + 3));
        else $('#rental_price').text(ss_rent + ".00");

        var str_total = total_price.toString();
        var sind = str_total.indexOf('.');
        if (sind != -1) $('#cou_rental_price').text( str_total.substring(0, sind + 3));
        else $('#cou_rental_price').text( str_total + ".00");

        var tind = discounted_price.toString().indexOf('.');
        if (tind != -1) $('#discounted_price').text("-" + discounted_price.toString().substring(0, tind + 3));
        else $('#discounted_price').text("-" + discounted_price + ".00");
    }
    else {
        $('#cou_discount').text('0%');
        $('#discounted_price').text('-0.00');
        $('#cou_rental_price').text($('#hid_total').val());
        $('#rental_price').text($('#totalsum').val());
        
    }
}