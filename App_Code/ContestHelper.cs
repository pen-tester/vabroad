using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

/// <summary>
/// Summary description for ContestHelper
/// </summary>
/// 

public class ContestInfo
{
    public int ID { get; set; }
    public string Name { get; set; }
    public string Text { get; set; }
    public int Price { get; set; }
    public int ValidMonth { get; set; }
    public string Created { get; set; }
    public string StartDate { get; set; }
    public string RuleText { get; set; }
}

public class ContestHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public ContestHelper()
    {
        //
        // TODO: Add constructor logic here
        //
   }

    public static int addContest(string name, string text, int price , int validmonth,string ruletext, string startdate)
    {
        int ret = 0;
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspAddContest", con))
                {
                    /*@comments nvarchar(1000),
                    @firstname nvarchar(50)='',
                    @lastname nvarchar (50)='',
                    @propID int,
                    @arrivalDate datetime=null,
                    @Reservation bit = 0,
                    @Rating int,
                    @DateEntered datetime=null,
                    @Phone nvarchar(50) ='',
                    @Email nvarchar(100)=''*/
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@name", SqlDbType.NVarChar, 500).Value = name;
                    cmd.Parameters.Add("@text", SqlDbType.NVarChar, 500).Value = text;
                    cmd.Parameters.Add("@price", SqlDbType.Int).Value = price;
                    cmd.Parameters.Add("@validmonth", SqlDbType.Int).Value = validmonth;
                    cmd.Parameters.Add("@startdate", SqlDbType.Date).Value = startdate;
                    cmd.Parameters.Add("@ruletext", SqlDbType.NVarChar,2000).Value = ruletext;



                    ret = cmd.ExecuteNonQuery();
      
                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
            return -1;

            // return 0;
        }
        return ret;

    }

    public static int addContestEmail(string first, string last, string email, string phone)
    {
        int ret = 0;
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspAddContestEmail", con))
                {
                    /*@comments nvarchar(1000),
                    @firstname nvarchar(50)='',
                    @lastname nvarchar (50)='',
                    @propID int,
                    @arrivalDate datetime=null,
                    @Reservation bit = 0,
                    @Rating int,
                    @DateEntered datetime=null,
                    @Phone nvarchar(50) ='',
                    @Email nvarchar(100)=''*/
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@first", SqlDbType.NVarChar, 50).Value = first;
                    cmd.Parameters.Add("@last", SqlDbType.NVarChar, 50).Value = last;
                    cmd.Parameters.Add("@email", SqlDbType.NVarChar, 400).Value = email;
                    cmd.Parameters.Add("@phone", SqlDbType.NVarChar, 50).Value = phone;



                    ret = cmd.ExecuteNonQuery();

                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
            return -1;

            // return 0;
        }
        return ret;

    }

    public static ContestInfo getCotestInfo()
    {
        //uspGetCountryInfo  @PropID
        ContestInfo contest_info = new ContestInfo();
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspGetContest", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                  //  cmd.Parameters.Add("@PropID", SqlDbType.Int).Value = prop_id;



                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.HasRows)
                        {
                            if (reader.Read())
                            {
                                //more code
                                PropertyInfo[] props = contest_info.GetType().GetProperties();
                                foreach(PropertyInfo prop in props)
                                {
                                    prop.SetValue(contest_info, Convert.ChangeType(reader[prop.Name], prop.PropertyType), null);
                                }
                            }
                        }

                    }


                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
             throw ex;
            // return 0;
        }
        return contest_info;
    }

}