using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Runtime.CompilerServices;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class IPNTest : System.Web.UI.Page
{

    Transaction_Item transitem;
    protected void Page_Load(object sender, EventArgs e)
    {
        //string requestUriString = "https://www.sandbox.paypal.com/cgi-bin/webscr";
        string requestUriString = "https://www.vacations-abroad.com/accounts/ipnhelper.aspx";

        HttpWebRequest request =
               (HttpWebRequest)WebRequest.Create(requestUriString);
        HttpContext context = HttpContext.Current;
    //    ServicePointManager.Expect100Continue = true;
    //    ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
        //  string strFormValues = Encoding.ASCII.GetString(     context.Request.BinaryRead(context.Request.ContentLength));
        string strFormValues = "mc_gross=391.63&protection_eligibility=Ineligible&payer_id=3Q76SE75WEPC8&tax=0.00&payment_date=15%3A55%3A01+Feb+24%2C+2017+PST&payment_status=Completed&charset=windows-1252&first_name=Andrew&mc_fee=11.66&notify_version=3.8&custom=&payer_status=unverified&business=talent.anddev%40yandex.com&quantity=1&verify_sign=AB63pz3qIrLOaZiQqVB04NGoucJcAKcbWJuaR6lA2XSaZvD9-gJHGSPZ&payer_email=devalbum.andrew1987%40gmail.com&txn_id=6PG1755987291204A&payment_type=instant&last_name=Dev&receiver_email=talent.anddev%40yandex.com&payment_fee=11.66&receiver_id=9QH4YNW7QZ3GE&txn_type=web_accept&item_name=Property8332+in+Paris%2CIle+de+France%2CFrance&mc_currency=USD&item_number=66&residence_country=US&test_ipn=1&handling_amount=0.00&transaction_subject=&payment_gross=391.63&shipping=0.00&ipn_track_id=3e9d96cfa8975&cmd=_notify-validate";
        // Set values for the request back
        request.Method = "POST";
        request.ContentType = "application/x-www-form-urlencoded";
        string obj2 = strFormValues + "&cmd=_notify-validate";
        request.ContentLength = obj2.Length;

        Response.Write(strFormValues);

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



        Response.Write(resp);


        if (resp == "VERIFIED")
        {
            //if(transitem.business == ConfigurationManager.AppSettings["PaypalEmail"].ToString() && transitem.txn_type!= "reversal")
          
                Response.Write("verified");
 
        }
        else
        {

        }

    }
    protected void saveLog()
    {
     
    }
}