using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SiteMapHelper
/// </summary>
public class SiteMapHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public SiteMapHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    //[uspGetNumsPropertybyCountry]
    public static DataSet getCountryList()
    {
        //uspGetPropertyNumsbyRegion
        //uspGetPropertyCatNumsbyCityID
        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("uspGetNumsPropertybyCountry", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
    public static DataSet getCityList()
    {
        //uspGetPropertyNumsbyRegion
        //uspGetPropertyCatNumsbyCityID
        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("uspCityLists", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
    public static DataSet getPropertyList()
    {
        //uspGetPropertyNumsbyRegion
        //uspGetPropertyCatNumsbyCityID
        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("uspPropertyLists", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
    public static DataSet getStateList()
    {
        //uspGetPropertyNumsbyRegion
        //uspGetPropertyCatNumsbyCityID
        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("uspStateLists", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
    public static DataSet getRegionList()
    {
        //uspGetPropertyNumsbyRegion
        //uspGetPropertyCatNumsbyCityID
        DataSet inquiry_set = new DataSet();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlDataAdapter adapter = new SqlDataAdapter())
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("select * from Regions", con);
                    cmd.CommandType = CommandType.Text;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
}