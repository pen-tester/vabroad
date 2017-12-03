using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_VerifyAirportLocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<SqlParameter> param = new List<SqlParameter>();
        
        DataSet airports = BookDBProvider.getDataSet("usp_list_allairports",param);
        if (airports.Tables.Count > 0)
        {
            int rows = airports.Tables[0].Rows.Count;
            for(int i =0;i < rows; i++)
            {
                DataRow row = airports.Tables[0].Rows[i];
                string lat = row["latitude"].ToString();
                string lan = row["longitude"].ToString();
                //string requestUri = string.Format("http ://maps.googleapis.com/maps/api/geocode/json?address={0}&sensor=false", key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&);
                string requestUri = string.Format("https://maps.googleapis.com/maps/api/geocode/json?latlng={0},{1}&key=AIzaSyD5PJ9egY0xvdrEKU_MFSDqKKxTCT4vwJM&sensor=false", lat, lan);
                WebRequest request = WebRequest.Create(requestUri);
                WebResponse response = request.GetResponse();

                string result="";
                using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                {
                    result = reader.ReadToEnd();
                    //Response.Write(result);
                    JObject json_result = JObject.Parse(result);
                    JArray addr_results = (JArray)json_result["results"];
                    string country, state, city, addr;
                    foreach (JObject address_obj in addr_results)
                    {
                        country = ""; state = ""; city = ""; addr = "";
                        JArray address_comp = (JArray)address_obj["address_components"];
                        foreach(JObject obj in address_comp)
                        {
                            JArray types = (JArray)obj["types"];
                            if (types.Count > 0)
                            {
                                if (types[0].ToString() == "country")
                                {
                                    country = obj["long_name"].ToString();
                                }else if(types[0].ToString() == "administrative_area_level_1")
                                {
                                    state = obj["long_name"].ToString();
                                }else if(types[0].ToString() == "locality")
                                {
                                    city= obj["long_name"].ToString();
                                }
                            }
                        }
                        addr = address_obj["formatted_address"].ToString();
                        Response.Write(String.Format("id:{3}==>{0}, {1}, {2} <br>", country, state, city, row["id"]));
                        //usp_update_airport_withcityid
                        param.Clear();
                        param.Add(new SqlParameter("@id", row["id"]));
                        param.Add(new SqlParameter("@country", country));
                        param.Add(new SqlParameter("@state", state));
                        param.Add(new SqlParameter("@city", city));
                        BookDBProvider.getDataSet("usp_update_airport_withcityid", param);
                        break;
                    }


                }

            }
        }
    }
}