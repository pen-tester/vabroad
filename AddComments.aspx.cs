using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddComments : System.Web.UI.Page
{
    public int propNum = 0;
    public string propName = "";
    public int stateprovinceid = 0;
    public int cityID = 0;
    public int countyID = 0;
    public string county = "";
    public string city = "";
    public string state = "";
    public string country = "";

    public string fname, lname, email, phonenumber, comment, vmon, vyear;
    public int rate = 0, image_count = 0;
    protected bool pass_recaptcha;
    protected void Page_Load(object sender, EventArgs e)
    {
        //   Request.SaveAs(Server.MapPath("~/assets/ss.txt"),true);

        pass_recaptcha = false;
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


        if (!pass_recaptcha) return;

        propNum = Int32.Parse(Request.Form["propid"]);
        image_count = Int32.Parse(Request.Form["image_count"]);
        fname = Server.HtmlEncode(Request.Form["txtFName"]);
        lname = Server.HtmlEncode(Request.Form["txtLName"]);
        vmon = Server.HtmlEncode(Request.Form["ddlMonth"]);
        vyear = Server.HtmlEncode(Request.Form["ddlYear"]);
        email = Server.HtmlEncode(Request.Form["email"]);
        phonenumber = Server.HtmlEncode(Request.Form["txtPhone"]);
        comment = Server.HtmlEncode(Request.Form["txtComments"]);
        rate = Int32.Parse(Request.Form["ratings"]);
        int newid = BookDBProvider.addComment(propNum, rate, fname, lname, vmon, vyear, email, phonenumber, comment);

        List<string> imgname = new List<string>();
        List<string> comments = new List<string>();
        for (int i = 0; i < image_count; i++)
        {
            imgname.Add(Request.Form["img" + i]);
            comments.Add(Request.Form["com" + i]);
        }
        BookDBProvider.addImagecomment(propNum, newid, comments, imgname);

        string msg_format = @"Dear Linda <br/>
 {0} has commented to property {1} <br/>
 Travel Date: {2} <br/>
 Email: {3} <br/>
 Phone: {4} <br/>
 Comment: {5} <br/>
 Rate: {6} <br/>";
        string msg = String.Format(msg_format, String.Format("{0} {1}", fname, lname), propNum, String.Format("{0} {1}", vyear, vmon)
            , email, phonenumber, comment, rate);

        BookDBProvider.SendEmail("prop@vacations-abroad.com", "Comment Notification", msg);
    }
}