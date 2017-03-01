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
        
        if (!AuthenticationManager.IfAuthenticated || !User.Identity.IsAuthenticated)
        {
            FormsAuthentication.SignOut();
        }

        Int32.TryParse(Request.QueryString["quoteid"], out quoteid);

        inquiryinfo = BookDBProvider.getQuoteInfo(quoteid);

        if (inquiryinfo.IfReplied == 1)
        {
            Response.Redirect("/Error.aspx?error=You've already responded.");
        }

        if (inquiryinfo.PropertyID == 0) Response.Redirect("/Error.aspx?error=Wrong Inquiry number");
        if((inquiryinfo.PropertyOwnerID!=userid)&& !AuthenticationManager.IfAdmin) Response.Redirect("/Error.aspx?error=You try to see the other info");

        countryinfo = BookDBProvider.getCountryInfo(inquiryinfo.PropertyID);
        
    }

    protected void SendQuote_Click(object sender, EventArgs e)
    {
    
        if (!Page.IsValid) return;

        if (rates.Value == "" || cleaningfee.Value == "" || secdeposit.Value == "" || loadingtax.Value == "") return;
        decimal _rates, _cleanfee, _secfee, _lodgingtax, _cancel90, _cancel60, _cancel30,_total_sum,_lodgingvalue,_balance;
        int _validnumber;
        if(!Decimal.TryParse(rates.Value,out  _rates))_rates=0;
        if(!Decimal.TryParse(cleaningfee.Value, out _cleanfee))_cleanfee=0;
        if(!Decimal.TryParse(secdeposit.Value, out _secfee))_secfee=0;
        if(!Decimal.TryParse(loadingtax.Value, out _lodgingtax))_lodgingtax=0;
        if(!Decimal.TryParse(cancel90.Value, out _cancel90))_cancel90=0;
        if(!Decimal.TryParse(cancel60.Value, out _cancel60))_cancel60=0;
        if(!Decimal.TryParse(cancel30.Value, out _cancel30))_cancel30=0;
        if(!Int32.TryParse(validnumber.Value, out _validnumber))_validnumber=0;

        _total_sum = _rates * inquiryinfo.Nights;
        _lodgingvalue = _total_sum * _lodgingtax / 100;
        _balance = _lodgingvalue + _secfee + _cleanfee;

        int newrespid = 0;
        int _currency = Convert.ToInt32(currency.SelectedValue);

        if ((newrespid =BookDBProvider.addEmailResponse(inquiryinfo.PropertyOwnerID, inquiryinfo.UserID, quoteid, _rates, _cleanfee, _secfee, _lodgingtax, _cancel30, _cancel60, _cancel90, DateTime.Now, _validnumber,_currency, comment.InnerText)) >0)
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
  {22}
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
            <a href='https://www.vacations-abroad.com/quoteresponse.aspx?respid={21}' style='cursor: pointer;color: #fff;text-decoration: none;font-size:12pt;font-family: Verdana;'>
                <b>Book Now!<b>
            </a>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <img src='{2}' style='width:350px;height: 220px;'  width='350' height='220' />
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
              # of Guests:  {9} Adults, {10} children <br/><br/>
             
                  Total Amount Due:{12} {19}<br/>
                  Amount Due to Reserve:{13} {19} (Nightly Rate:{14} {19})<br/>

              
        		</td>
        	</tr>
            <tr>
            <td style='background: none; border: dotted 1px #999999; border-width:1px 0 0 0; height:1px;font-size:1px;'></td>
            </tr>
            <tr>
                <td style='padding:3px;font-family: Verdana;'>
                  Cleaning Fee:{15} {19}<br/>
                  Security Deposit:{16} {19}<br/>
                  Lodging Tax:{17}% {20}{19}<br/>
                  Amount Due Upon Arrival:{18}  <br/>
                  Comment:{22}<br/>
        		</td>            
            </tr>
          </table>
      </td>
    </tr>
    <tr>
     <td style='padding: 15px; text-align: center;'>
   	    <a href='https://www.vacations-abroad.com/quoteresponse.aspx?respid={21}' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;font-family: Verdana;'>
	      <b>Book Now</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240' height='100' />     
      </td>
    </tr>
  </table>
</body>";
        decimal _total = _total_sum + _balance;
        string msg = String.Format(toTraveler, DateTime.Now.ToString("MMM d, yyyy"), inquiryinfo.ContactorName, "https://www.vacations-abroad.com/images/" + propinfo.FileName, propinfo.Name2, propinfo.CategoryTypes, url, propinfo.ID, inquiryinfo.ArrivalDate, inquiryinfo.Nights, inquiryinfo.Adults, inquiryinfo.Children, userinfo.name,BookDBProvider.DoFormat(_total), BookDBProvider.DoFormat(_total_sum), BookDBProvider.DoFormat(_rates), BookDBProvider.DoFormat(_cleanfee), BookDBProvider.DoFormat(_secfee),_lodgingtax, BookDBProvider.DoFormat(_balance), currency.SelectedItem.Text, BookDBProvider.DoFormat(_lodgingvalue),AjaxProvider.Base64Encode(newrespid.ToString()), "<style>a:hover{color:#8bbdeb;} </style>",comment.InnerText);
        //BookDBProvider.SendEmail(traveler.email, toTraveler, "You have received the response from the property owner");
        BookDBProvider.SendEmail(inquiryinfo.ContactorEmail, String.Format("{0}, here is your quote for {1}",inquiryinfo.ContactorName, inquiryinfo.ArrivalDate) ,msg);
        BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has responded to {1}", userinfo.name, inquiryinfo.ContactorName), msg);

        if (AuthenticationManager.IfAdmin) 
            Response.Redirect("/userowner/listings.aspx?userid=" + inquiryinfo.PropertyOwnerID);
        else Response.Redirect("/userowner/listings.aspx");
    }
}