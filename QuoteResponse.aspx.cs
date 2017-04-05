using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_TravelerResponse : Page
{
    public InquiryInfo inquiryinfo;
    public CountryInfo countryinfo;
    public EmailResponseInfo email_resp;
    public string[] currency_type = { "USD", "EUR","CAD", "GPB", "YEN" };

    public int respid = 0;
    public decimal _total_sum, _total, _lodgingval, _balance;
    public string url = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
        if (!AuthenticationManager.IfAuthenticated || !User.Identity.IsAuthenticated)
        {
            FormsAuthentication.SignOut();
        }
        */
        string param = AjaxProvider.Base64Decode(Request.QueryString["respid"]);

        if(!Int32.TryParse(param, out respid))respid=0;
       // if (respid == 0) respid = Convert.ToInt32(resp_number.Value);

        email_resp = BookResponseEmail.getResponseInfo(respid);
        if (email_resp.ID == 0  ) Response.Redirect("/Error.aspx?error=Wrong Response number or not valid");

       // resp_number.Value = respid.ToString();

        inquiryinfo = BookDBProvider.getQuoteInfo(email_resp.QuoteID);

        countryinfo = BookDBProvider.getCountryInfo(inquiryinfo.PropertyID);

        //  _total_sum = email_resp.NightRate * inquiryinfo.Nights;
        _total_sum = email_resp.NightRate;
        _lodgingval = _total_sum * email_resp.LoadingTax / 100;
        _balance = _lodgingval + email_resp.CleaningFee + email_resp.SecurityDeposit;
        _total = _total_sum + _balance;

        url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", countryinfo.country, countryinfo.state, countryinfo.city, inquiryinfo.PropertyID);
    }

 
    protected void SendQuote_Click(object sender, EventArgs e)
    {
        errormsg.Text = "";


        /* string URI = "/payment.aspx";
         string myParameters = "respid="+respid;

         using (WebClient wc = new WebClient())
         {
             wc.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";
             string HtmlResult = wc.UploadString(URI, myParameters);
         }
         */
        Response.Clear();

        StringBuilder sb = new StringBuilder();
        sb.Append("<html>");
        sb.AppendFormat(@"<body onload='document.forms[""form""].submit()'>");
        sb.AppendFormat("<form name='form' action='{0}' method='post'>", "/payment.aspx");
        sb.AppendFormat("<input type='hidden' name='respid' value='{0}'>", respid);
        sb.AppendFormat("<input type='hidden' name='rescoupon' value='{0}'>", Request["coupon"]);
        // Other params go here
        sb.Append("</form>");
        sb.Append("</body>");
        sb.Append("</html>");

        Response.Write(sb.ToString());

        Response.End();
        /* if (BookResponseEmail.updateEmailResponseState(respid))
         {
             //Send email
             Response.Redirect("/userowner/listings.aspx");
         }
         else
         {
             Response.Redirect("/Error.aspx?error=db update error.Please contace the admin.");
         }
        */


    }


}