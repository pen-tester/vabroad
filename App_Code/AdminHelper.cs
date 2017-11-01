using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

/// <summary>
/// Summary description for AdminHelper
/// </summary>
/// 
public class Unverifiedmap_Propery
{
    public int ID { get; set; }
    public int UserID { get; set; }
    public int CityID { get; set; }
    public string Address { get; set; }
    public string City { get; set; }
    public string StateProvince { get; set; }
    public string Country { get; set; }
    public int loc_verified { get; set; }
    public decimal loc_latlang { get; set; }
    public decimal loc_logitude { get; set; }
}
public class AdminHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public AdminHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static DataSet getDataSet(string proc_name, List<SqlParameter> proc_param)
    {

        //  SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
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

                    adapter.Fill(inquiry_set);

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return inquiry_set;
    }

    public static List<Unverifiedmap_Propery> get_unverfiedmap_properties()
    {
        List<Unverifiedmap_Propery> list = new List<Unverifiedmap_Propery>();
        List<SqlParameter> param = new List<SqlParameter>();
        DataSet ds_prp = getDataSet("uspGetProperties_map_unverified", param);
        if (ds_prp.Tables.Count > 0)
        {
            int row_count = ds_prp.Tables[0].Rows.Count;
            for(int i=0; i < row_count; i++)
            {
                DataRow row = ds_prp.Tables[0].Rows[i];
                Unverifiedmap_Propery tmp = new Unverifiedmap_Propery();
                PropertyInfo[] prps = tmp.GetType().GetProperties();
                foreach(PropertyInfo prp in prps)
                {
                    try
                    {
                        var val = row[prp.Name];
                        prp.SetValue(tmp, Convert.ChangeType(val,prp.PropertyType), null);
                    }catch(Exception e)
                    {

                    }
                }
                list.Add(tmp);
            }
        }

        return list;
    }
}