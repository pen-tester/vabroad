using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_PaySuccess : System.Web.UI.Page
{
    public InquiryInfo inquiryinfo;
    // public CountryInfo countryinfo;
    public EmailResponseInfo email_resp;
    public UserInfo owner_info;
    public PropertyDetailInfo prop_info;
    public Transaction_Item transitem;
    public decimal _total_sum, _balance, _lodgingval, _total;
    public string[] currency_type = { "USD", "EUR", "CAD", "GPB", "YEN" };
    public HttpContext context;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod != "POST")
        {
            Response.Write("Wrong request");
            return;
        }

        context = HttpContext.Current;

         parseTransaction();
        PaymentHelper.addPaymentLog(transitem);
        
        email_resp = BookResponseEmail.getResponseInfo(transitem.item_number); //respid
                                                                               // if (email_resp.ID == 0 || email_resp.IsValid < 1) Response.Redirect("/Error.aspx?error=Wrong Response number or not valid");

        inquiryinfo = BookDBProvider.getQuoteInfo(email_resp.QuoteID);
        owner_info = BookDBProvider.getUserInfo(inquiryinfo.PropertyOwnerID);
        // traveler_info = BookDBProvider.getUserInfo(inquiryinfo.UserID);
        prop_info = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);
        

        
                ServicePointManager.Expect100Continue = true;
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

        //string requestUriString = "https://www.sandbox.paypal.com/cgi-bin/webscr";
        string requestUriString = "https://www.paypal.com/cgi-bin/webscr";

        HttpWebRequest request =
                       (HttpWebRequest)WebRequest.Create(requestUriString);

                string strFormValues = Encoding.ASCII.GetString(
            context.Request.BinaryRead(context.Request.ContentLength));
                // Set values for the request back
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                string obj2 = strFormValues + "&cmd=_notify-validate";
                request.ContentLength = obj2.Length;

                System.IO.StreamWriter file = new System.IO.StreamWriter(Server.MapPath("/logwrite.txt"));
                  file.Write(obj2);
                file.Close();

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

          
          System.IO.StreamWriter sfile = new System.IO.StreamWriter(Server.MapPath("/log.txt"));
          sfile.Write(resp);
          sfile.Close();

          if (resp== "VERIFIED")
          {
              //if(transitem.business == ConfigurationManager.AppSettings["PaypalEmail"].ToString() && transitem.txn_type!= "reversal")
              System.IO.StreamWriter ssfile = new System.IO.StreamWriter(Server.MapPath("/logt.txt"));
              ssfile.Write(resp);
              ssfile.Close();
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

                       BookDBProvider.SendEmail(owner_info.email, "Notification: Transaction:" + transitem.txn_id, msg);
                       BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has paid for property {1} Transaction:{2}",inquiryinfo.ContactorName,transitem.item_number, transitem.txn_id), msg);
                       BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Notification: Transaction:" + transitem.txn_id, msg);

                   }

               }
          }
          else
          {

          }

    }

    protected void parseTransaction()
    {
        transitem = new Transaction_Item();

        string content = "";

        PropertyInfo[] props = transitem.GetType().GetProperties();

        foreach (PropertyInfo prop in props)
        {
            try
            {

                prop.SetValue(transitem, Convert.ChangeType(context.Request[prop.Name], prop.PropertyType), null);
                content += String.Format("Name:{0} =>Value:{1} ******", prop.Name, prop.GetValue(transitem, null));
            }
            catch (Exception e)
            {

            }

        }

        System.IO.StreamWriter file = new System.IO.StreamWriter(Server.MapPath("/logwritex.txt"));
        file.Write(content);
        file.Close();
    }


}