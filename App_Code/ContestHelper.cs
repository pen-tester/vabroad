using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ContestHelper
/// </summary>
public class ContestHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public ContestHelper()
    {
        //
        // TODO: Add constructor logic here
        //
   }

    public static int addContest(string name, string text, int price , int validmonth)
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

                    cmd.Parameters.Add("@fist", SqlDbType.NVarChar, 50).Value = first;
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
}