using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class accounts_IPNHelper : System.Web.UI.Page
{
    public InquiryInfo inquiryinfo;
   // public CountryInfo countryinfo;
    public EmailResponseInfo email_resp;
    public UserInfo owner_info;
    public PropertyDetailInfo prop_info;
    public Transaction_Item transitem;
    public decimal _total_sum, _balance, _lodgingval, _total;
    public string[] currency_type = { "USD", "EUR", "CAD", "GPB", "YEN" };
    protected void Page_Load(object sender, EventArgs e)
    {

        // Write the string to a file.
        if (HttpContext.Current.Request.HttpMethod != "POST")
        {
            Response.Write("Wrong request");
            return;
        }

        using (StreamReader sreader = new StreamReader(Request.InputStream))
        {
            string content = sreader.ReadToEnd();
            System.IO.StreamWriter file = new System.IO.StreamWriter(Server.MapPath("/log.txt"));
            file.Write(content);
            file.Close();
        }
        saveLog();
        string requestUriString = "https://www.sandbox.paypal.com/cgi-bin/webscr";

        HttpWebRequest request =
               (HttpWebRequest)WebRequest.Create(requestUriString);

        string strFormValues = Encoding.ASCII.GetString(
    this.Request.BinaryRead(this.Request.ContentLength));
        // Set values for the request back
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        string obj2 = strFormValues + "&cmd=_notify-validate";
        request.ContentLength = obj2.Length;

       

        // Write the request back IPN strings
        StreamWriter writer =
            new StreamWriter(request.GetRequestStream(), Encoding.ASCII);
        writer.Write(RuntimeHelpers.GetObjectValue(obj2));
        writer.Close();

        //send the request, read the response
        HttpWebResponse response = (HttpWebResponse)request.GetResponse();
        Stream responseStream = response.GetResponseStream();
        Encoding encoding = Encoding.GetEncoding("utf-8");
        StreamReader reader = new StreamReader(responseStream, encoding);
        string resp = reader.ReadToEnd();

        _total_sum = email_resp.NightRate * inquiryinfo.Nights;
        _lodgingval = _total_sum * email_resp.LoadingTax / 100;
        _balance = _lodgingval + email_resp.CleaningFee + email_resp.SecurityDeposit;
        _total = _total_sum + _balance;

        if (resp== "VERIFIED")
        {
            //if(transitem.business == ConfigurationManager.AppSettings["PaypalEmail"].ToString() && transitem.txn_type!= "reversal")
            if (transitem.business == "talent.anddev@yandex.com" && transitem.txn_type != "reversal")
            {
                if ((transitem.mc_gross == (_total)) && transitem.payment_status == "Completed" && transitem.mc_currency == currency_type[email_resp.CurrencyType])
                {
                    PaymentHelper.addPaymentHistory(transitem, inquiryinfo);


                    BookResponseEmail.updateEmailResponseState(transitem.item_number);


                    string msg_format = @"Dear {0} <br/>
                        The traveler {1} has paid for the property {2}. <br/>
                        The detailed info is following. <br/>
                        Property:{3} <br/>
                        Payer Email:{4} <br/>
                        Amount:{5} <br/>
                    ";
                    string msg = String.Format(msg_format, owner_info.firstname, inquiryinfo.ContactorName, inquiryinfo.PropertyID, transitem.item_name, transitem.payer_email, transitem.mc_gross);

                    //BookDBProvider.SendEmail(owner_info.email, "Notification: Transaction:" + transitem.txn_id, msg);
                    BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has paid for property {1} Transaction:{2}",inquiryinfo.ContactorName,transitem.item_number, transitem.txn_id), msg);
                    BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Notification: Transaction:" + transitem.txn_id, msg);

                }

            }
        }
        else
        {

        }

    }
    protected void saveLog()
    {
       // BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Notification", "Transaction tst");

        transitem = new Transaction_Item();

        PropertyInfo[] props = transitem.GetType().GetProperties();

        foreach(PropertyInfo prop in props)
        {
            try
            {
                prop.SetValue(transitem, Convert.ChangeType(Request[prop.Name], prop.PropertyType), null);
            }
            catch
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

        email_resp = BookResponseEmail.getResponseInfo(transitem.item_number); //respid
       // if (email_resp.ID == 0 || email_resp.IsValid < 1) Response.Redirect("/Error.aspx?error=Wrong Response number or not valid");

        inquiryinfo = BookDBProvider.getQuoteInfo(email_resp.QuoteID);
        owner_info = BookDBProvider.getUserInfo(inquiryinfo.PropertyOwnerID);
       // traveler_info = BookDBProvider.getUserInfo(inquiryinfo.UserID);
        prop_info = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);


    }
}
