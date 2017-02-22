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
        return;
        string msg = @"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
 <head>
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
  <title>Vacations Abroad</title>
  <meta name='viewport' content='width=device-width, initial-scale=1.0'/>
</head>
<body>
  <style>
  </style>
  <table border='0px' width='600px' style='font-family: Verdana;'>
    <tr>
      <td>
         <table  style='width:600px;'>
         	<tr>
         	  <td style='color:#000;font-size:16pt;width:300px;'>
         	  	<b>Vacations Abroad</b>
         	  </td>
         	  <td style='color:#000;font-size:10pt;width:300px;text-align: right;'>
         	    {0}
         	  </td>
         	</tr>
         </table>
      </td>
    </tr>
    <tr>
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;'>
         <b>Dear {1}: You have an inquiry!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:350px;height: 220px;' /></a>
      </td>
    </tr>
    <tr>
    	<td style='text-align: center;font-size:10pt;'>
    	   Name of property:{3} &nbsp;&nbsp; Type of property:{4}
    	</td>
    </tr>
    <tr>
      <td style='padding: 10px;'>
        <table style='border:1px dashed #000;width:600px;font-size:12pt;'>
        	<tr>
        		<td style='padding:10px;'>
					<a href='{5}' style='text-decoration: none;'>Property {6}</a> <br/>
					Date of Arrival: {7} <br/>
					{8} of nights <br/>
					# of Guests:  {9} Adults, {10} children <br/>
					Renter's Name: {11}<br/>
					Comments:{12}        		
        		</td>
        	</tr>
        </table>
      </td>
    </tr>
    <tr>
     <td style='padding: 15px; text-align: center;'>
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:5px 50px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;'>
	      <b>Login to Your Account to provide a response / quote.</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' /></a>      
      </td>
    </tr>
  </table>
</body>
</html>";
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
    <td colspan='2' style='text-align: center;width:600px;'>
        <div>
          <img src='https://www.vacations-abroad.com/images/AfricaBeachVacations.jpg' title='' alt=''></div>
       </div>       
      <div>      
      <p style='text-align:center;width:600px;'>
       	  Name of property:(From DB) Type of property:From DB
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
        BookDBProvider.SendEmail("andrew.li1987@yandex.com", "Notifications", msg);
        BookDBProvider.SendEmail("devalbum.andrew1987@gmail", "Notifications", msg);
        BookDBProvider.SendEmail("andrew.lidev@hotmail.com", "Notifications", msg);
        BookDBProvider.SendEmail("talent.anddev@yandex.com", "Notifications", msg);
        //   BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Traveler", msg);
    }
}