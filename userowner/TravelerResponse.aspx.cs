using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_TravelerResponse : CommonPage
{
    public InquiryInfo inquiryinfo;
    public CountryInfo countryinfo;
    public int quoteid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!AuthenticationManager.IfAuthenticated || !User.Identity.IsAuthenticated)
        {
            FormsAuthentication.SignOut();
        }
        
        Int32.TryParse(Request.QueryString["quoteid"], out quoteid);

        inquiryinfo = BookDBProvider.getQuoteInfo(quoteid);

        if (inquiryinfo.PropertyID == 0) Response.Redirect("/Error.aspx?error=Wrong Inquiry number");

        countryinfo = BookDBProvider.getCountryInfo(inquiryinfo.PropertyID);

    }

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
    
    protected void SendQuote_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) return;
       if( BookDBProvider.addEmailResponse(userid, inquiryinfo.UserID, quoteid, Convert.ToDecimal(rates.Text),
            Convert.ToDecimal(totalsum.InnerText), Convert.ToDecimal(cleaningfee.Text), Convert.ToDecimal(secdeposit.Text),
            Convert.ToDecimal(loadingtaxval.InnerText), Convert.ToDecimal(balance.Text), Convert.ToDecimal(cancel30.Text),
            Convert.ToDecimal(cancel60.Text), Convert.ToDecimal(cancel90.Text),DateTime.Now, Convert.ToInt32(validnumber.Value), Convert.ToInt32(currency.SelectedValue),
            Convert.ToDecimal(loadingtax.Text)))
        {
            BookDBProvider.updateEmailQuoteState(quoteid);
        }



        UserInfo userinfo = BookDBProvider.getUserInfo(userid);
        //  BookResponseEmail  /for owner
        string toOwner = String.Format("Hi, {0}!<br> You have replied the inquiry for the property {1} in {2},{3},{4}.<br> Thanks.",
            userinfo.firstname+" "+userinfo.lastname, inquiryinfo.PropertyID, countryinfo.city, countryinfo.state, countryinfo.country);

        BookDBProvider.SendEmail(userinfo.email, "You have replied for the inquiry", toOwner);

        PropertyDetailInfo propinfo = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);
        string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", propinfo.Country, propinfo.StateProvince, propinfo.City, propinfo.ID).ToLower().Replace(" ", "_");

        //To traveler
        // UserInfo traveler = BookDBProvider.getUserInfo(inquiryinfo.UserID);
        string toTraveler = @"
<body>
<table width='600px'>
  <tr>
    <td width='300px'><h3>Vacations Abroad</h3></td>
    <td style='text-align: right;'>Date of Inquiry:{0}</td>
  </tr>
  <tr>
    <td colspan='2'>
      <div style='padding:10px 0px;text-align: center;width: 100%;background-color: #6699ff;border:1px solid #154890;'>
        <b>Dear {1}: Thanks for your enquiry!</b>
      </div>
    </td>
  </tr>
  <tr>
    <td colspan='2' style='text-align: center;width:600px;'>
        <div>
          <img src='https://www.vacations-abroad.com/images/{2}' title='' alt=''></div>
       </div>       
      <div>      
      <p style='text-align:center;width:600px;'>
       	  Name of property:{3} Type of property:{4}
       </p>
      </div>     
    </td>
  </tr>
  <tr>
     <td colspan='2' width='600px'>
       <div style='padding: 10px; width: 100% ;text-align: center;'>
      <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:10px 150px;border:1px solid #154890;cursor: pointer;background-color: rgb(49, 83, 143);text-decoration: none;font-size:16px;color: #000;'>
       <b> Book Now!</b>
      </a> 
      </div>    
     </td>
  </tr>  
  <tr>
  <td colspan='2'  width='600px'>
    <div style='width: 100%; border:1px dashed #000;padding: 15px;'>
		<a href='{5}'>Property {6}</a> <br>
		Date of Arrival: {7} <br>
		{8} of nights <br>
		# of Guests:  {9} Adults, {10} children <br>
		Owner’s Name: {11}<br><br><br>
        Amount:{12}<br>
        Total Due to Reserve:{13} (Nightly Rate:{14})<br>
        Cleaning Fee:{15}<br>
        Security Deposit:{16}<br>
        Loading Tax:{17}%<br>
		Comments:{18}
    </div>
  </td>
  </tr>
  <tr>
     <td colspan='2'  width='600px'>
       <div style='padding: 10px; width: 100% ;text-align: center;'>
      <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:10px 50px;border:1px solid #154890;cursor: pointer;color: #f86308;text-decoration: none;'>
        Book Now!
      </a> 
      </div>    
     </td>
  </tr>
  <tr>
     <td colspan='2'  width='600px'>
       <div style='width: 100%;text-align: center;'>
         <img alt='Vacation Abroad' title='Vacation Abroad' src='https://www.vacations-abroad.com/images/logo.png'>
       </div>
     </td>
  </tr>
</table>
</body>
";
        Decimal total = Decimal.Parse(totalsum.InnerText) + Decimal.Parse(balance.Text);
        string msg = String.Format(toTraveler, DateTime.Now.ToString("MM dd yyyy"), inquiryinfo.ContactorName, propinfo.FileName, propinfo.Name2, propinfo.CategoryTypes, url, propinfo.ID, inquiryinfo.ArrivalDate, inquiryinfo.Nights, inquiryinfo.Adults, inquiryinfo.Children, userinfo.name, total,totalsum.InnerText, rates.Text,cleaningfee.Text,secdeposit.Text,loadingtax.Text,"");
        //BookDBProvider.SendEmail(traveler.email, toTraveler, "You have received the response from the property owner");
        BookDBProvider.SendEmail(inquiryinfo.ContactorEmail, toTraveler, "You have received the response from the property owner "+ userinfo.name);
        BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has responded to {1}", userinfo.name, inquiryinfo.ContactorName), String.Format("Dear Linda, The respond is following.<br> {0}", msg));

        Response.Redirect("/userowner/listings.aspx");
    }
}