﻿
$(document).ready(function () {
    console.log("doc ready");
    $('#coupon').blur(function (e) {
        var coupon = $(this).val();
        $.ajax({
            type: "POST",
            url: "/ajaxhelper.aspx/getcouponitem",
            data: '{coupon:"' +coupon + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: processPropertyData,
            failure: function (response) {
                console.log(response.d);
            }
        });
    });
});

function processPropertyData(response) {
  //  console.log(response.d);
    var couponitem = response.d;
    if (couponitem.CID == 0) return;
    var total =parseFloat( $('#hid_total').val());
    var discount =parseInt( couponitem.Discount);
    var sdate =new Date( couponitem.Start_date); var edate =new Date(couponitem.End_date);
    var cur_date = new Date();

    

    if (cur_date >= sdate && cur_date <= edate) {
        
        var rent_total = total * (100 - discount) / 100;
      //  console.log(discount + " "+rent_total);
        $('#cou_discount').text(discount);
        var ss_rent= rent_total.toString();
        $('#cou_rental_price').text(ss_rent.substring(0, ss_rent.indexOf('.')+3));
    }
}