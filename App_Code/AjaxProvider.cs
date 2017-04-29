using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

/// <summary>
/// Summary description for AjaxProvider
/// </summary>
public class AjaxProvider
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public AjaxProvider()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string Base64Encode(string plainText)
    {
        var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
        return System.Convert.ToBase64String(plainTextBytes);
    }
    
    public static string Base64Decode(string base64EncodedData)
    {
        var base64EncodedBytes = System.Convert.FromBase64String(base64EncodedData);
        return System.Text.Encoding.UTF8.GetString(base64EncodedBytes);
    }

    public static CouponItem getCouponItem(string coupon)
    {
        CouponItem item = new CouponItem();
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@coupon", coupon));

        DataSet ds_coupon = BookDBProvider.getDataSet("uspGetCouponItem", param);
        PropertyInfo[] props = item.GetType().GetProperties();

        try
        {
            if (ds_coupon.Tables.Count > 0)
            {
                DataRow row;
                row = ds_coupon.Tables[0].Rows[0];

                foreach (PropertyInfo prop_info in props)
                {
                    try
                    {
                        prop_info.SetValue(item, Convert.ChangeType(row[prop_info.Name], prop_info.PropertyType), null);
                    }
                    catch (Exception ex)
                    {

                    }

                }
            }
        }
        catch { }
        return item;
    }

    public static PropertyDetailInfo getPropertyDetailInfo(int propid)
    {

        PropertyDetailInfo detail = new PropertyDetailInfo();
        //  adapter.Fill(customers, "Customers");
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                  con.Open();
                SqlCommand cmd = new SqlCommand("uspGetPropertiesDetailInfoLocation", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add("@propid", SqlDbType.NVarChar, 200).Value = propid;

                //   @pagenum int =0,
                //@ratesort int= 0
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    PropertyInfo[] props = detail.GetType().GetProperties();
                    foreach (PropertyInfo prop_info in props)
                    {
                        try {
                            prop_info.SetValue(detail, Convert.ChangeType(reader[prop_info.Name], prop_info.PropertyType), null);
                        }
                        catch(Exception ex)
                        {

                        }

                    }
                    
                }

                reader.Close();
                con.Close();

            }
        }
        catch (Exception ex)
        {
            
        }
        return detail;
    }


    public static DataSet getProNumsbyRegion()
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
                    SqlCommand cmd = new SqlCommand("uspGetPropertyNumsbyRegion", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");

                    adapter.Dispose();
                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }

    public static DataSet getProCatNumsbyCity(int cityid)
    {
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
                    SqlCommand cmd = new SqlCommand("uspGetPropertyCatNumsbyCityID", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@cityid", SqlDbType.Int).Value = cityid;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");
                    adapter.Dispose();
                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }

    public static DataSet getCityListbyCityNum(int cityid)
    {
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
                    SqlCommand cmd = new SqlCommand("uspCityListsbyCityNum", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@cityid", SqlDbType.Int).Value = cityid;

                    adapter.SelectCommand = cmd;

                    adapter.Fill(inquiry_set, "InquiryList");
                    adapter.Dispose();
                    con.Close();

                }
            }
        }
        catch (Exception ex)
        {

        }

        return inquiry_set;
    }
    public static int getPropertyNumsbyState(int stateid)
    {
        //uspGetNumsPropertybyState
        int counts = 0;
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspGetNumsPropertybyState", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@stateid", SqlDbType.Int).Value = stateid;



                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            
                            counts = Convert.ToInt32(reader[0]);
                        }

                        reader.Close();
                    }


                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            // throw ex;
            // return 0;
        }
        return counts;
       
    }

    public static DataSet getCountryInfoSet(int regionid)
    {
                  DataSet inquiry_set = new DataSet();
                //  adapter.Fill(customers, "Customers");
                try
                {
                    using (SqlConnection con = new SqlConnection(connString))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter())
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("uspGetCountryList", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.Add("@RegionID", SqlDbType.Int).Value = regionid;

                            adapter.SelectCommand = cmd;

                            adapter.Fill(inquiry_set, "InquiryList");
                            adapter.Dispose();
                            con.Close();

                        }
                    }
                }
                catch (Exception ex)
                {

                }

                return inquiry_set;
            }

    public static AjaxCountryList getCountryInfo(int regionid)
    {
        AjaxCountryList ajaxlist = new AjaxCountryList();
        ajaxlist.regionid = regionid;
        //uspGetCountryInfo  @PropID
        List<Ajaxcountryinfo> list = new List<Ajaxcountryinfo>();
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspGetCountryList", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@RegionID", SqlDbType.Int).Value = regionid;



                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Ajaxcountryinfo tmp = new Ajaxcountryinfo();
                            tmp.id = Convert.ToInt32(reader[0]);
                            tmp.name = reader[1].ToString();
                            list.Add(tmp);
                        }

                    }


                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            // throw ex;
            // return 0;
        }
        ajaxlist.statelist = list;
        return ajaxlist;
    }
    public static AjaxStateList getSateInfo(int countryid)
    {
        AjaxStateList ajaxlist = new AjaxStateList();
        ajaxlist.countryid = countryid;
        //uspGetCountryInfo  @PropID
        List<AjaxStateInfo> list = new List<AjaxStateInfo>();
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspGetStateList", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@CountryID", SqlDbType.Int).Value = countryid;


                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            AjaxStateInfo tmp = new AjaxStateInfo();
                            tmp.id = Convert.ToInt32(reader[0]);
                            tmp.name = reader[1].ToString();
                            list.Add(tmp);
                        }

                    }


                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            // throw ex;
            // return 0;
        }
        ajaxlist.statelist = list;
        return ajaxlist;
    }

    public static List<NumbersPropertybyCountry> getNumbersProperty()
    {
        List<NumbersPropertybyCountry> num_list = new List<NumbersPropertybyCountry>();
       
        try
        {
            using (SqlConnection con = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("uspGetNumsPropertybyCountry", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            NumbersPropertybyCountry tmp = new NumbersPropertybyCountry();
                            PropertyInfo[] props = tmp.GetType().GetProperties(); 
                            foreach(PropertyInfo prop in props)
                            {
                                try
                                {
                                    prop.SetValue(tmp, Convert.ChangeType(reader[prop.Name], prop.PropertyType), null);
                                }catch(Exception ex)
                                {

                                }
                            } 
                            num_list.Add(tmp);
                        }

                    }


                    con.Close();

                }
            }

        }
        catch (Exception ex)
        {
            // throw ex;
            // return 0;
            throw ex;
        }
        
        return num_list;
    }
}


