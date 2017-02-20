using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendHtmlEmail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string msg = @"<body>
<table width='600px'>
  <tr>
    <td width='300px'><h3>Vacations Abroad</h3></td>
    <td style='text-align: right;'>Date of Inquiry:Month Day Year</td>
  </tr>
  <tr>
    <td colspan='2'>
	    <div style='padding:10px 0px;text-align: center;width: 100%;background-color: #6699ff;border:1px solid #154890;'>
	      <b>Dear Owner 1st name: You have an inquiry!</b>
	    </div>
    </td>
  </tr>
  <tr>
    <td colspan='2' style='text-align: center;'>
        <div>
       	  <img src='https://www.vacations-abroad.com/images/AfricaBeachVacations.jpg' title='' alt=''></img></div>
       </div>       
      <div>
       	  Name of property:(From DB) Type of property:From DB
       </div>       
    </td>
  </tr>
  <tr>
  <td colspan='2'>
    <div style='width: 100%; border:1px dashed #000;padding: 15px;'>
		Property # (with link to property) <br>
		Date of Arrival: Month Date Year (input from inquiry form) <br>
		# of nights (input from inquiry)<br>
		# of Guests:  # Adults, # children (input from inquiry form)<br>
		Renter’s Name: Linda Jenkins<br><br><br>


		Comments:


    </div>
  </td>
  </tr>
  <tr>
     <td colspan='2'>
       <div style='padding: 10px; width: 100% ;text-align: center;'>
	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:10px 50px;border:1px solid #154890;cursor: pointer;color: #f86308;text-decoration: none;'>
	      Login to Your Account to provide a response / quote.
	    </a> 
	    </div>    
     </td>
  </tr>
  <tr>
     <td colspan='2'>
       <div style='width: 100%;text-align: center;'>
         <img alt='Vacation Abroad' title='Vacation Abroad' src='https://www.vacations-abroad.com/images/logo.png'>
       </div>
     </td>
  </tr>
</table>
</body>
 ";
        string totraveler = @"
<body>
<table width='600px'>
  <tr>
    <td width='300px'><h3>Vacations Abroad</h3></td>
    <td style='text-align: right;'>Date of Inquiry:Month Day Year</td>
  </tr>
  <tr>
    <td colspan='2'>
      <div style='padding:10px 0px;text-align: center;width: 100%;background-color: #6699ff;border:1px solid #154890;'>
        <b>Dear Traveler: Thanks for your enquiry!</b>
      </div>
    </td>
  </tr>
  <tr>
    <td colspan='2' style='text-align: center;'>
        <div>
          <img src='https://www.vacations-abroad.com/images/AfricaBeachVacations.jpg' title='' alt=''></div>
       </div>       
      <div>
          Name of property:(From DB) Type of property:From DB
       </div>       
    </td>
  </tr>
  <tr>
     <td colspan='2'>
       <div style='padding: 10px; width: 100% ;text-align: center;'>
      <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:10px 150px;border:1px solid #154890;cursor: pointer;background-color: rgb(49, 83, 143);text-decoration: none;font-size:16px;color: #000;'>
       <b> Book Now!</b>
      </a> 
      </div>    
     </td>
  </tr>  
  <tr>
  <td colspan='2'>
    <div style='width: 100%; border:1px dashed #000;padding: 15px;'>
    Property # (with link to property) <br>
    Date of Arrival: Month Date Year (input from inquiry form) <br>
    # of nights (input from inquiry)<br>
    # of Guests:  # Adults, # children (input from inquiry form)<br>
    Renter’s Name: Linda Jenkins<br><br><br>


    Comments:


    </div>
  </td>
  </tr>
  <tr>
     <td colspan='2'>
       <div style='padding: 10px; width: 100% ;text-align: center;'>
      <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:10px 50px;border:1px solid #154890;cursor: pointer;color: #f86308;text-decoration: none;'>
        Book Now!
      </a> 
      </div>    
     </td>
  </tr>
  <tr>
     <td colspan='2'>
       <div style='width: 100%;text-align: center;'>
         <img alt='Vacation Abroad' title='Vacation Abroad' src='https://www.vacations-abroad.com/images/logo.png'>
       </div>
     </td>
  </tr>
</table>
</body>
";
        BookDBProvider.SendEmail("andrew.li1987@yandex.com", "HtmlEmail", totraveler);
        BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Traveler", msg);
    }
}