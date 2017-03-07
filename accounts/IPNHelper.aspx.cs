using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
    public DetailedUserInfo owner_info;
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
        owner_info = BookDBProvider.getDetailedUserInfo(inquiryinfo.PropertyOwnerID);
        // traveler_info = BookDBProvider.getUserInfo(inquiryinfo.UserID);
        prop_info = AjaxProvider.getPropertyDetailInfo(inquiryinfo.PropertyID);



        ServicePointManager.Expect100Continue = true;
        ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;

      //  string requestUriString = "https://www.sandbox.paypal.com/cgi-bin/webscr";
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

        //_total_sum = email_resp.NightRate * inquiryinfo.Nights;
        _total_sum = email_resp.NightRate;
        _lodgingval = _total_sum * email_resp.LoadingTax / 100;
        _balance = _lodgingval + email_resp.CleaningFee + email_resp.SecurityDeposit;
        _total = _total_sum + _balance;

        /*
        System.IO.StreamWriter sfile = new System.IO.StreamWriter(Server.MapPath("/log.txt"));
        sfile.Write(resp);
        sfile.Close();
        */
        int discount;
        if (transitem.custom.Length == 13)
        {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@coupon", transitem.custom));

            DataSet ds_coupon = BookDBProvider.getDataSet("uspGetCouponItem", param);
            if (ds_coupon.Tables[0].Rows.Count > 0)
            {
                if (!int.TryParse(ds_coupon.Tables[0].Rows[0]["Discount"].ToString(), out discount)) discount = 0;

                _total = _total * (100 - discount) / 100;

            }
        }

        _total = Decimal.Parse(BookDBProvider.DoFormat(_total));

        if (resp == "VERIFIED")
        {
            //if(transitem.business == ConfigurationManager.AppSettings["PaypalEmail"].ToString() && transitem.txn_type!= "reversal")
/*            System.IO.StreamWriter ssfile = new System.IO.StreamWriter(Server.MapPath("/logt.txt"));
            ssfile.Write(resp);
            ssfile.Close();
            */
            //if (transitem.business == "talent.anddev@yandex.com" && transitem.txn_type != "reversal")
            if (transitem.business == ConfigurationManager.AppSettings["PaypalEmail"].ToString() && transitem.txn_type != "reversal")
            {
                if ((transitem.mc_gross == (_total)) && transitem.payment_status == "Completed" && transitem.mc_currency == currency_type[email_resp.CurrencyType])
                {
                    PaymentHelper.addPaymentHistory(transitem, inquiryinfo);


                    BookResponseEmail.updateEmailResponseState(transitem.item_number);

                    string format_traveler = @"This is your receipt for your reservation with Vacations-Abroad.com <br/>
This email confirms that {0} has booked a reservation with {1}. <br/>
Your Arrival Date is: {2} <br/>
You paid: {3} {4} on {5} <br/>
The owner’s cancellation policy is <br/>
90 days prior to arrival:{6}% <br/>
60 days prior to arrival:{7}% <br/>
30 days prior to arrival:{8}% <br/>

Owner Contact Details <br/>
Owner Name:{9} <br/>
Owner Email:{10} <br/>
Owner Telephone:{11} <br/>
Name of Property:{1} <br/>
Owner Website: {12} <br/>
Please contact the owner to obtain the actual property address. <br/>
If you do not cancel, the funds will be transferred to the owner on (7 days prior to your {13}) <br/>
When you return, please write a review of the property and add photos. <br/>";

                    string msg_traveler = String.Format(format_traveler,inquiryinfo.ContactorName, prop_info.PropertyName,DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d, yyyy"),
                        transitem.mc_gross,transitem.mc_currency, DateTime.Now.ToString("MMM d, yyyy"),email_resp.Cancel90,email_resp.Cancel60,email_resp.Cancel30
                        ,String.Format("{0} {1}", owner_info.FirstName,owner_info.LastName), owner_info.Email,
                        owner_info.MobileTelephone, owner_info.Website, DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d, yyyy"));

                    string trv_subject = String.Format("Reservation Confirmation for {0}",DateTime.Now.ToString("MMM d, yyyy"));
                    BookDBProvider.SendEmail(inquiryinfo.ContactorEmail, trv_subject, msg_traveler);

                    string format_owner = @"This is a confirmation for the reservation completed through Vacations-Abroad.com <br/>
This email confirms that {0} has booked a reservation with {1}. <br/>
Arrival Date is: {2} <br/>
They have paid: {3} {4} on {5} <br/>
The owner’s cancellation policy is <br/>
90 days prior to arrival:{6}% <br/>
60 days prior to arrival:{7}% <br/>
30 days prior to arrival:{8}% <br/><br/>
Traveler Contact Details <br/><br/>
Traveler Name:{9} <br/>
Traveler Email:{10} <br/>
Traveler Telephone:{11} <br/><br/> 
Please contact the traveler to provide them with directions to your property and inform them of any check-in procedures. <br/>
If the Traveler does not cancel, the funds will be transferred to your Paypal or bank account  (7 days prior to your {2}) less a 10% commission fee. If any fees such as cleaning fees, security deposit or lodging taxes are to be collected by you at arrival. <br/>
You have specified these additional fees are due at arrival. <br/>
Cleaning:{12} {4} <br/>
Security Deposit:{13} {4}<br/>
Lodging Tax:{14} {4}<br/><br/>

Let us know if we can be of further assistance. <br/>
Linda Jenkins <br/>
770-687-6889 <br/>";
                   string owner_subject = String.Format("Reservation Confirmation for {0}", DateTime.Now.ToString("MMM d, yyyy"));
                    string msg_owner = String.Format(format_owner, inquiryinfo.ContactorName, prop_info.PropertyName
                        ,DateTime.Parse(inquiryinfo.ArrivalDate).ToString("MMM d, yyyy"),transitem.mc_gross, transitem.mc_currency,
                        DateTime.Now.ToString("MMM d, yyyy"), email_resp.Cancel90, email_resp.Cancel60, email_resp.Cancel30,
                        inquiryinfo.ContactorName, inquiryinfo.ContactorEmail, inquiryinfo.Telephone,
                        BookDBProvider.DoFormat(email_resp.CleaningFee), BookDBProvider.DoFormat(email_resp.SecurityDeposit),BookDBProvider.DoFormat(_lodgingval));
                    BookDBProvider.SendEmail(owner_info.Email,owner_subject, msg_owner);
                    BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has paid for property {1} Transaction:{2}", inquiryinfo.ContactorName, transitem.item_number, transitem.txn_id), msg_owner);
                    BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", "Notification: Transaction:" + transitem.txn_id, msg_owner);

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

     //   string content = "";

        PropertyInfo[] props = transitem.GetType().GetProperties();

        foreach (PropertyInfo prop in props)
        {
            try
            {

                prop.SetValue(transitem, Convert.ChangeType(context.Request[prop.Name], prop.PropertyType), null);
               // content += String.Format("Name:{0} =>Value:{1} ******", prop.Name, prop.GetValue(transitem, null));
            }
            catch (Exception e)
            {

            }

        }
/*
        System.IO.StreamWriter file = new System.IO.StreamWriter(Server.MapPath("/logwritex.txt"));
        file.Write(content);
        file.Close();
        */
    }

}
