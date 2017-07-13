using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PingSeo : System.Web.UI.Page
{
    string[] pingurl = { "http://www.google.com/webmasters/sitemaps/ping?sitemap=https://www.vacations-abroad.com/sitemap.xml", "http://www.bing.com/webmaster/ping.aspx?siteMap=https://www.vacations-abroad.com/sitemap.xml" };

    protected void Page_Load(object sender, EventArgs e)
    {
        for(int i =0; i<pingurl.Length; i++)
        {
            HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(pingurl[i]);
            request.Method = "GET";
            String result = String.Empty;
            using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
            {
                Stream dataStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(dataStream);
                result = reader.ReadToEnd();
                reader.Close();
                dataStream.Close();
                Response.Write(result);
            }
        }
        Response.End();
    }
}