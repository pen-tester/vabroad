using System;
using System.Collections.Generic;
using System.Linq;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        Request.SaveAs(Server.MapPath("~/assets/ss.txt"),true);
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

    }
}