using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_TravelerResponse : ClosedPage
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



        UserInfo userinfo = BookDBProvider.getUserInfo(inquiryinfo.PropertyOwnerID);
        //  BookResponseEmail  /for owner
        string toOwner = String.Format("Hi, {0}!<br> You have replied the inquiry for the property {1} in {2},{3},{4}.<br> Thanks.",
            userinfo.firstname+" "+userinfo.lastname, inquiryinfo.PropertyID, countryinfo.city, countryinfo.state, countryinfo.country);

        BookDBProvider.SendEmail(userinfo.email, "You have replied for the inquiry", toOwner);

        PropertyDetailInfo propinfo = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);
        string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", propinfo.Country, propinfo.StateProvince, propinfo.City, propinfo.ID).ToLower().Replace(" ", "_");

        //To traveler
        // UserInfo traveler = BookDBProvider.getUserInfo(inquiryinfo.UserID);
        string toTraveler = @"<body>
  <table border='0px' width='600px' >
    <tr>
      <td>
         <table  style='width:600px;'>
         	<tr>
         	  <td style='color:#000;font-size:16pt;width:300px;font-family: Verdana;'>
         	  	<b>Vacations Abroad</b>
         	  </td>
         	  <td style='color:#000;font-size:10pt;width:300px;text-align: right;font-family: Verdana;'>
         	    {0}
         	  </td>
         	</tr>
         </table>
      </td>
    </tr>
    <tr>
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;font-family: Verdana;'>
         <b>Book Now!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{2}' download='vacations.jpg'><img src='{2}' style='width:350px;height: 220px;'  width='350' height='220' /></a>
      </td>
    </tr>
    <tr>
    	<td style='text-align: center;font-size:10pt;font-family: Verdana;'>
    	   Name of property:{3} &nbsp;&nbsp; Type of property:{4}
    	</td>
    </tr>
    <tr>
      <td style='padding: 10px;'>
        <table style='border:1px dashed #000;width:600px;font-size:12pt;'>
        	<tr>
        		<td style='padding:10px;font-family: Verdana;'>
              <a href='{5}'>Property {6}</a> <br/>
              Date of Arrival: {7} <br/>
              {8} of nights <br/>
              # of Guests:  {9} Adults, {10} children <br/>
              Owner's Name: {11}<br/><br/>
                  Amount:{12} {19}<br/>
                  Total Due to Reserve:{13} {19} (Nightly Rate:{14} {19})<br/>
                  Cleaning Fee:{15} {19}<br/>
                  Security Deposit:{16} {19}<br/>
                  Lodging Tax:{17}%<br/>
              Comments:{18}      		
        		</td>
        	</tr>
        </table>
      </td>
    </tr>
    <tr>
     <td style='padding: 15px; text-align: center;'>
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;font-family: Verdana;'>
	      <b>Book Now</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240' height='100' /></a>      
      </td>
    </tr>
  </table>
</body>";
        Decimal total = Decimal.Parse(totalsum.InnerText) + Decimal.Parse(balance.Text);
        string msg = String.Format(toTraveler, DateTime.Now.ToString("MMM d, yyyy"), inquiryinfo.ContactorName, "https://www.vacations-abroad.com/images/" + propinfo.FileName, propinfo.Name2, propinfo.CategoryTypes, url, propinfo.ID, inquiryinfo.ArrivalDate, inquiryinfo.Nights, inquiryinfo.Adults, inquiryinfo.Children, userinfo.name, total,totalsum.InnerText, rates.Text,cleaningfee.Text,secdeposit.Text,loadingtax.Text,"", currency.SelectedItem.Text);
        //BookDBProvider.SendEmail(traveler.email, toTraveler, "You have received the response from the property owner");
        BookDBProvider.SendEmail(inquiryinfo.ContactorEmail, String.Format("{0}, here is your quote for {1}",inquiryinfo.ContactorName, inquiryinfo.ArrivalDate) ,msg);
        BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has responded to {1}", userinfo.name, inquiryinfo.ContactorName), String.Format("Dear Linda, The respond is following.<br> {0}", msg));

        Response.Redirect("/userowner/listings.aspx?userid="+inquiryinfo.PropertyOwnerID);
    }
}