using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
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
}