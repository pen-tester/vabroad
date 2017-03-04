using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_Payment : CommonPage
{
    public InquiryInfo inquiryinfo;
    //public CountryInfo countryinfo;
    public EmailResponseInfo email_resp;
    public UserInfo owner_info;
    public PropertyDetailInfo prop_info;
    public string[] currency_type = { "USD", "EUR", "CAD", "GPB", "YEN" };

    public int respid = 0;
    public decimal _total_sum, _lodgingval, _balance,_total=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        NameValueCollection nvc = Request.Form;
        // string userName, password;
        if (!string.IsNullOrEmpty(Request["resp_number"]))
        {
            respid = Convert.ToInt32(Request["resp_number"]);
            resp_id.Value = respid.ToString();
        }
        else if (resp_id.Value != null && resp_id.Value!="")
        {
            respid = Convert.ToInt32(resp_id.Value);
        }
        else Response.Redirect("/Error.aspx?error=Wrong Request for booking"); ;  //Not post or Wrong respid
        //Get the inquiry info.
        email_resp = BookResponseEmail.getResponseInfo(respid);
        if (email_resp.ID == 0 ) Response.Redirect("/Error.aspx?error=Wrong Response number or not valid");

        inquiryinfo = BookDBProvider.getQuoteInfo(email_resp.QuoteID);
        owner_info = BookDBProvider.getUserInfo(inquiryinfo.PropertyOwnerID);
        prop_info = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);
        // _total_sum = email_resp.NightRate * inquiryinfo.Nights;
        _total_sum = email_resp.NightRate;
        _lodgingval = _total_sum * email_resp.LoadingTax / 100;
        _balance = _lodgingval + email_resp.CleaningFee + email_resp.SecurityDeposit;
        _total = _total_sum + _balance;
    }

  
}