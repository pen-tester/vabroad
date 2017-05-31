using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PropertyMap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (WebClient client = new WebClient())
        {

            byte[] response =
            client.UploadValues("https://api.madmimi.com/audience_lists/" + Server.UrlEncode("All contacts") + "/add", new NameValueCollection()
            {
                       { "username", "noreply@vacations-abroad.com" },
                       { "api_key", "9881316569391d3dbfba35b71670b4b2" },
                       { "email", "test@test.com" }

            });

            string result = System.Text.Encoding.UTF8.GetString(response);
            Response.Write(result);
        }
        /*  HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create("https://api.madmimi.com/audience_lists/lists.xml");
          request.Method = "GET";
          String result = String.Empty;
          using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
          {
              Stream dataStream = response.GetResponseStream();
              StreamReader reader = new StreamReader(dataStream);
              result = reader.ReadToEnd();
              reader.Close();
              dataStream.Close();
          }
          */

    }
}