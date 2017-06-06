using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for MainHelper
/// </summary>
/// 
public class ObjectName //City , state, country, region
{
    public int ID { get; set; }
    public string Name { get; set; }
}

public class LatLongInfo
{
    public double latitude { get; set; }
    public double longitude { get; set; }
    public int status { get; set; }

}

public class MainHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public MainHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

     

    public static List<T> getListFromDB<T>(string proc_name, List<SqlParameter> proc_param) where T:class, new()
    {
        List<T> list = new List<T>();



        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        using (SqlConnection con = new SqlConnection(connString))
        {
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            {
                con.Open();
                string sql = proc_name;

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter proc_par in proc_param)
                {
                    cmd.Parameters.Add(proc_par);
                }


                adapter.SelectCommand = cmd;

                adapter.Fill(inquiry_set, "Result");

                con.Close();

            }
        }
        if (inquiry_set.Tables.Count > 0)
        {
            foreach(DataRow row in inquiry_set.Tables[0].Rows)
            {
                T obj = new T();
                PropertyInfo[] props = obj.GetType().GetProperties();
                foreach (PropertyInfo pinfo in props)
                {
                    try
                    {
                        pinfo.SetValue(obj, Convert.ChangeType(row[pinfo.Name], pinfo.PropertyType), null);
                        object tmp = row[pinfo.Name];
                    }
                    catch
                    {

                    }
                }
                list.Add(obj);
            }
            
        }

        return list;
    }

    public static List<SqlParameter> getSqlParamList(List<string> param, List<string> pname)
    {
        List<SqlParameter> param_list = new List<SqlParameter>();
        for(int i=0; i<param.Count; i++)
        {
            param_list.Add(new SqlParameter(pname[i], param[i]));
        }
        return param_list;
    }

    public static LatLongInfo getCityLocation(string city, string state, string country)
    {
        LatLongInfo info = new LatLongInfo();
        string url = "http://maps.google.com/maps/api/geocode/json?address=" + String.Format("{0}, {1}, {2}", city, state, country) + "&sensor=false";

        try
        {

            WebRequest request = WebRequest.Create(url);
            using (WebResponse response = request.GetResponse())
            {
                using (var reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    string resp = reader.ReadToEnd();
                    JObject jobj = JObject.Parse(resp);

                    //If the result is successful
                    if (jobj["status"].ToString() == "OK")
                    {
                        info.latitude =Double.Parse( jobj["geometry"]["location"]["lat"].ToString());
                        info.longitude = Double.Parse(jobj["geometry"]["location"]["lng"].ToString());
                        info.status = 1;
                    }
                    else { return info; }
                    reader.Close();
                    response.Close();

                    //Get location info details
                    string detail_url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + info.latitude + "," + info.longitude + "&sensor=false";
                    WebRequest req_detail = WebRequest.Create(detail_url);

                    using (WebResponse det_response = req_detail.GetResponse())
                    {
                        using (var detail_reader = new StreamReader(det_response.GetResponseStream(), Encoding.UTF8))
                        {
                            string details_loc = detail_reader.ReadToEnd();
                            
                            JObject details = JObject.Parse(details_loc);
                            if (details["status"].ToString() != "OK") return info;


                            JArray results = (JArray)details["results"];
                            for (int detail_index = 0; detail_index < results.Count; detail_index++)
                            {
                                JObject one_result = (JObject)results[detail_index];
                                string loc_detailed_address = one_result["formatted_address"].ToString().ToLower();
                                if (loc_detailed_address.IndexOf(country.ToLower()) >= 0)
                                {
                                    info.status = 2;  //Verified Address
                                    break;
                                }
                            }
                            detail_reader.Close();
                            det_response.Close();
                        }
                    }


                }
            }
        }catch(Exception e)
        {
           throw e;
        }
        return info;
    }



}