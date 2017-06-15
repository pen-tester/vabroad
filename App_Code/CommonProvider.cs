using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CommonProvider
/// </summary>
public class CommonProvider
{
    public CommonProvider()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static string getMarkersJsonString(DataSet ds_citylocations)
    {
        List<Location> eList = new List<Location>();
        foreach (DataRow dr in ds_citylocations.Tables[0].Rows)
        {
            try
            {
                Location e1 = new Location();
                e1.title = dr["City"].ToString();
                e1.lat = Convert.ToDouble(dr["latitude"]);
                e1.lng = Convert.ToDouble(dr["longitude"]); ;
                e1.description = dr["City"].ToString();
                string temps = CommonFunctions.GetSiteAddress() + "/" + dr["Country"].ToString().ToLower().Replace(" ", "_") +
                 "/" + dr["StateProvince"].ToString().ToLower().Replace(" ", "_") + "/" + dr["City"].ToString().ToLower().Replace(" ", "_") + "/default.aspx";
                e1.URL = temps;
                eList.Add(e1);
            }
            catch { }
        }
        // Response.Write(CitiesAdapter.SelectCommand.CommandText);
        return JsonConvert.SerializeObject(eList, Formatting.Indented);
    }
}