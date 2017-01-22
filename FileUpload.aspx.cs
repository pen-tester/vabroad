using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FileUpload : System.Web.UI.Page
{
    public string up_name = "";
    protected void Page_Load(object sender, EventArgs e)
    {

            //Request.SaveAs(Server.MapPath("~/img/comments/ss.txt"), false);
            HttpFileCollection files = Request.Files;
            HttpPostedFile file = files[0];
        // HttpPostedFile file = Request.Form.
        // string name = file.FileName;
            up_name = String.Format("com{0}{1}", getfilename(), Path.GetExtension(file.FileName));
            file.SaveAs(Server.MapPath("~/img/comments/" + up_name));

    }

    public string getfilename()
    {
        DateTime dtime = DateTime.Now;
        string st = dtime.ToString("yyyy_MM_dd_HH_mm_ss");
        return st;
    }
}