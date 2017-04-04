
$(document).ready(function () {
    console.log("ready");

   // showdlg("Arrive<br>Error:this is test. ");
    $('.mclose').click(function () {
        $('#msgdlg').hide();
        if (_txtboxid != "") {
            $('#' + _txtboxid).focus();
        }
    });
  /*  $(window).click(function (e) {
        if (e.target.id != 'modal_dialog')
        $('#msgdlg').hide();
    });
    */
    $('#btnsend').click(function (e) {
        var resp = paramcheck();
        if (resp == "") {
            $('#sendquote').click();
        }
        else {
            console.log(resp);
            showdlg(resp);
        }
    });

    $('input[type=text]').blur(function (e) {
        //console.log(e.target.id);
        //  console.log
        if (e.target.id == 'balance') return;
        var value = $('#' + e.target.id).val();
        var pattern= new RegExp( "^[0-9]+$");
        if (!pattern.test($('#' + e.target.id).val())) {
            $('#' + e.target.id).val("");
            _txtboxid = e.target.id;
            showdlg("The only number is allowed.");
        }
        calculateValue();
    });
    
    $('#optform1').hide();

    $('#opt_prop').change(function () {
       // console.log("select changed");
        var sel_val = $(this).val();
        console.log(sel_val);
        $('#optform1').hide(); $('#optform0').hide();
        $('#optform' + sel_val).show();
    });
    $('#sendcomment').click(function (e) {
        console.log("send comment");
        if ($('#comments').text() != "") { console.log("click send comment"); $('#sendcomments').click(); }
        else showdlg("Please add comment for unavaility of the property.");
    });
    $('#comments').text("");
});

var _txtboxid = "";

function paramcheck() {
    var str = "";
    if ($('#bodycontent_rates').val() == "") str += "Price Quote Nightly Rates is required!<br/>";
   // if ($('#bodycontent_cleaningfee').val() == "") str += "Cleaning Fee is required!<br/>";
  //  if ($('#bodycontent_secdeposit').val() == "") str += "Security Deposit is required!<br/>";
  //  if ($('#bodycontent_loadingtax').val() == "") str += "Lodging Tax is required!<br/>";
   // if ($('#bodycontent_validnumber').val() == "") str += "The number of valid days is required!<br/>";
    return str;
}

function showdlg(msg) {
    //$('#modalmsg').text(msg);
    $('#modalmsg').html(msg);
    $('#msgdlg').show();
}

function calculateValue() {
    var tmp = $('#bodycontent_rates').val();
    var rates = (tmp == "") ? 0 : parseFloat(tmp);
    tmp = $('#bodycontent_cleaningfee').val();
    var cleaningfee = (tmp == "") ? 0 : parseFloat(tmp);
    tmp = $('#bodycontent_secdeposit').val();
    var secdeposit = (tmp == "") ? 0 : parseFloat(tmp);
    tmp = $('#bodycontent_loadingtax').val();
    var loadingtax = (tmp == "") ? 0 : parseFloat(tmp);
    //var total_sum = rates * ($('#nights').text());
    var total_sum = rates;
    var lodging = total_sum * loadingtax / 100;
    $('#totalsum').text(total_sum);
    $('#loadingtaxval').text(lodging);
    $('#balance').val(lodging+secdeposit+cleaningfee);
}

/*
protected void rates_TextChanged(object sender, EventArgs e)
{
//Response.Write("rate changed");
              
        decimal rate_val = 0; Decimal.TryParse(rates.Text, out rate_val);
decimal tax_val = 0; Decimal.TryParse(loadingtax.Text, out tax_val);
decimal clean_val = 0; Decimal.TryParse(cleaningfee.Text, out clean_val);
decimal sec_val = 0; Decimal.TryParse(secdeposit.Text, out sec_val);
decimal total_sum = rate_val * inquiryinfo.Nights;
decimal loading_val = total_sum * tax_val/100;

totalsum.InnerText = total_sum.ToString();
loadingtaxval.InnerText = loading_val.ToString();

balance.Text = (clean_val + sec_val + loading_val).ToString();
}
  */  