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
     //   return;
        string msg = @"<body>
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
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;'>
         <b>Dear {1}: You have an inquiry!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{2}' download='vacations.jpg'><img src='{2}' style='width:350px;height: 220px;' /></a>
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
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;'>
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
 ";
        string totraveler = @"<body>
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
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;'>
         <b>Book Now!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{2}' download='vacations.jpg'><img src='{2}' style='width:350px;height: 220px;' width='350px' height='220px' /></a>
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
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;'>
	      <b>Book Now</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240px' height='100px' /></a>      
      </td>
    </tr>
  </table>
</body>";
        BookDBProvider.SendEmail("andrew.li1987@yandex.com", "Notifications", totraveler);
        BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Notifications", msg);
        BookDBProvider.SendEmail("andrew.lidev@hotmail.com", "Notifications", msg);
        BookDBProvider.SendEmail("talent.anddev@yandex.com", "Notifications", totraveler);
        
    }
}