using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SendEmails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string name = Request["name"];
        string email = Request["email"];
        if (name == "" || email == "") return;

        string msg_format = @"Dear {0} <br/>
General Inquiry originating on In the service. <br/>
Name: {0} <br/>
Email: {1} <br/>";
        string msg = String.Format(msg_format, name, email);
        BookDBProvider.SendEmail(email, "About the Listing the services", msg, "kingdev1987@gmail.com");
    }
}