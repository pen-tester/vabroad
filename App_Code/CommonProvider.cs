using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

/// <summary>
/// Summary description for CommonProvider
/// </summary>
public class CommonProvider
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public CommonProvider()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static string getMarkersJsonString(DataSet ds_citylocations, string type="location")
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
                e1.type = type;
                eList.Add(e1);
            }
            catch { }
        }
        // Response.Write(CitiesAdapter.SelectCommand.CommandText);
        return JsonConvert.SerializeObject(eList, Formatting.Indented);
    }
    //Convert dataset to json
    public static string getJsonStringFromDs(DataSet ds_tabables)
    {
        string result = "";
        foreach (DataRow dr in ds_tabables.Tables[0].Rows)
        {
            string tmp = "";
            foreach(DataColumn dc in ds_tabables.Tables[0].Columns)
            {
                try
                {
                    tmp = String.Format("{0}, \"{1}\":\"{2}\"", tmp, dc.ColumnName, dr[dc.ColumnName]);
                }
                catch { }

            }
            if (tmp.Length > 1) tmp = tmp.Substring(1);
            result = String.Format("{0}, {{{1}}}", result, tmp);
        }
        if (result.Length > 1) result = String.Format("[{0}]", result.Substring(1));
        else result = "[]";
        return result;
        // Response.Write(CitiesAdapter.SelectCommand.CommandText);
    }

    //For new version
    public static T ConvertToClassFromDataSet<T>(DataSet ds) where T :class, new()
    {
        T result = new T();
        //Converting From DS to Class
        try
        {
            DataRow reader = ds.Tables[0].Rows[0];

            PropertyInfo[] props = result.GetType().GetProperties();
            foreach (PropertyInfo prop_info in props)
            {
                try
                {
                    prop_info.SetValue(result, Convert.ChangeType(reader[prop_info.Name], prop_info.PropertyType), null);
                }
                catch{}

            }
        }
        catch (Exception ex)
        {

        }
        return result;
    }

    public static int getScalarValueFromDB(string proc_name, List<SqlParameter> proc_param)
    {
        int ret = -1;
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                con.Open();
                string sql = proc_name;

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.CommandType = CommandType.StoredProcedure;

                foreach (SqlParameter proc_par in proc_param)
                {
                    cmd.Parameters.Add(proc_par);
                }

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    if(!Int32.TryParse(reader[0].ToString(), out ret))ret= -1;
                    break;
                }
                con.Close();

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return ret;
    
    }
}