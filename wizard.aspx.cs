using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class wizard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod == "POST")
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Write("Is signed");
            }
            Response.Write(Request["param"]);
            Response.End();
        }

    }
}