using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ThankYouPayment : System.Web.UI.Page
{
    public int userid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            userid = Int32.Parse(Request.QueryString["userid"]);
        }
       catch(Exception ex)
        {

        }
    }
}
