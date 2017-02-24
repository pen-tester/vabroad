using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_PaySuccess : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpContext context = HttpContext.Current;
        Transaction_Item transitem = new Transaction_Item();

        PropertyInfo[] props = transitem.GetType().GetProperties();

        foreach (PropertyInfo prop in props)
        {
            try
            {
                prop.SetValue(transitem, Convert.ChangeType(context.Request[prop.Name], prop.PropertyType), null);
            }
            catch (Exception ex)
            {

            }
        }





        /*
                int item_number = Convert.ToInt32(Request["item_number"]);
                decimal mc_gross = Convert.ToDecimal(Request["mc_gross"]);
                decimal mc_fee = Convert.ToDecimal(Request["mc_fee"]);
                string txn_id = Request["txn_id"];
                string paydate = Request["payment_date"];
                string business = Request["business"];
                string payer_email = Request["payer_email"];
                string payer_id = Request["payer_id"];
                string mc_currency = Request["mc_currency"];
                string txn_type = Request["txn_type"];
                string payment_status = Request["payment_status"];
                string payment_type = Request["payment_type"];
                string pending_reason = Request["pending_reason"];
                string item_name = Request["item_name"];

            */

        PaymentHelper.addPaymentLog(transitem);

    }

}