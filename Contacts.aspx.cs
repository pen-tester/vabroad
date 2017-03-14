using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contacts : System.Web.UI.Page
{
    public bool pass_recaptcha;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Page.Header.Controls.Add(new LiteralControl("<link href='http://vacations-abroad.com/css/StyleSheet.css' rel='stylesheet' type='text/css' />"));
        pass_recaptcha = false;
        if (IsPostBack)
        {
            string sec_key = "6LeiuBcUAAAAAPEGRRVqTcLsdO83GSnGetOwOfMM";
            string g_url = "https://www.google.com/recaptcha/api/siteverify";
            using (WebClient wc = new WebClient())
            {
                byte[] response =
                wc.UploadValues(g_url, new NameValueCollection()
                {
                   { "secret", sec_key },
                   { "response", Request["g-recaptcha-response"] }
                });

                string result = System.Text.Encoding.UTF8.GetString(response);
                JObject json = JObject.Parse(result);
                if (json["success"].ToString() != "True" || json["hostname"].ToString() != "www.vacations-abroad.com")
                {
                    // Response.Write(String.Format("{0} <<<<  {1}<<<< {2}", Request["g-recaptcha-response"], json["success"].ToString(), json["hostname"].ToString()));
                    return;
                }
                pass_recaptcha = true;
            }
        }
    }

    public string[]  questions={"Question about a reservation","Question about listing a property"};


    protected void btnsendback_ServerClick(object sender, System.EventArgs e)
    {
        if (pass_recaptcha == false) {  return; }
        string name = Request["username"];
        string email = Request["useremail"];
        string subject = Request["userselect"];
        string phone = Request["userphone"];
        string comment = Request["usercomment"];
        if (name == "" || email == "") return;
        int ind_subject=0;
        if (!Int32.TryParse(subject, out ind_subject)) ind_subject = 0;
        if (ind_subject == 0 || ind_subject>2) {  return; }

        string msg_format = @"Dear Linda <br/>
Someone has contacted with you. <br/>
His information is following. <br/>
Name: {0} <br/>
Email: {1} <br/>
Telephone: {2} <br/>
Message: {3}";
        string msg = String.Format(msg_format, name, email, phone, comment);
        BookDBProvider.SendEmail("linda@vacations-abroad.com", questions[ind_subject],msg);
       // BookDBProvider.SendEmail("devalbum.andrew1987@gmail.com", questions[ind_subject], msg);
        
    }
}
