using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class inquiryresponses :AdminPage
{
    public DataSet ds_quotes; 
    protected void Page_Load(object sender, EventArgs e)
    {
        ds_quotes = PaymentHelper.getAllQuote();
    }
}