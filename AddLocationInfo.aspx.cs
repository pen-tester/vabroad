using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddLocationInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataSet ds_country = BookDBProvider.getDataSet("uspGetCityWithNoLoctionList", new List<SqlParameter>());

        int count = ds_country.Tables[0].Rows.Count;

        for(int i=0;i<count; i++)
        {
            DataRow row = ds_country.Tables[0].Rows[i];
            string url = "http://maps.google.com/maps/api/geocode/json?address=" + String.Format("{0}, {1}",row["City"], row["Country"]) + "&sensor=false&key=AIzaSyAJtbVRP65pcH3R0Kv7GCz187HYDMHdeFo";
          //  Response.Write(url);
          //  if (i > 10) break;
            WebRequest request = WebRequest.Create(url);
            using (WebResponse response = request.GetResponse())
            {
                using (var reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {

                    string resp = reader.ReadToEnd();
                    JObject jobj = JObject.Parse(resp);
                    Response.Write(resp);
                    if (jobj["status"].ToString() == "OK")
                    {
                        string latitude = jobj["results"][0]["geometry"]["location"]["lat"].ToString();
                        string longtitude = jobj["results"][0]["geometry"]["location"]["lng"].ToString();
                        List<SqlParameter> param = new List<SqlParameter>();
                        param.Add(new SqlParameter("@country", row["Country"]));
                        param.Add(new SqlParameter("@state", row["StateProvince"]));
                        param.Add(new SqlParameter("@city", row["City"]));
                        param.Add(new SqlParameter("@lat", latitude));
                        param.Add(new SqlParameter("@lng", longtitude));
                        BookDBProvider.getDataSet("uspAddLatLong", param);
                    }
                    
                }
            }
        }
    }
}