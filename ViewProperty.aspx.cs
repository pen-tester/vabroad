using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Collections.Generic;
using System.Configuration;
using System.Web.Security;
using System.Reflection;
using System.Net;
using System.Collections.Specialized;
using Newtonsoft.Json.Linq;

public partial class ViewProperty : CommonPage
{
    protected string username;
    protected string photosalt;
    public string city = "";
    public string county = "";
    public int countyid = 0;
    public string country,stateprovince;
    public DataSet city_ds;

    public string[] min_rentaltypes = { "None", "2 Nights", "3 Nights", "1 Week", "2 Weeks", "Monthly", "1 Night" };
    public DetailedUserInfo userinfo;
    public UserInfo duserinfo;

    protected System.Data.SqlClient.SqlDataAdapter PhotosAdapter;
    protected System.Data.SqlClient.SqlDataAdapter AmenitiesAdapter;
    protected System.Data.SqlClient.SqlDataAdapter AttractionsAdapter;
    protected System.Data.SqlClient.SqlDataAdapter PropertyViewsAdapter;
    protected System.Data.SqlClient.SqlDataAdapter PropertiesAdapter;
    protected System.Data.SqlClient.SqlDataAdapter PaymentMethodsAdapter;
    protected System.Data.SqlClient.SqlDataAdapter RatesAdapter;
    protected System.Data.SqlClient.SqlDataAdapter RoomsAdapter;
    protected System.Data.SqlClient.SqlDataAdapter FurnitureAdapter;
    protected System.Data.SqlClient.SqlDataAdapter GetLocationInfo;
    protected System.Data.SqlClient.SqlDataAdapter EmailsAdapter;

    protected Vacations.PropertiesFullDataset PropertiesFullSet;
    protected Vacations.PhotosDataset PhotosSet;
    protected System.Data.SqlClient.SqlCommand sqlCommand1;
    protected Vacations.PhotosDataset ExtraPhotosSet;
    protected Vacations.AmenitiesDataset AmenitiesSet;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand2;
    protected System.Data.SqlClient.SqlCommand sqlInsertCommand1;
    protected Vacations.PropertyViewsDataset PropertyViewsSet;
    protected Vacations.PaymentMethodsDataset PaymentMethodsSet;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand6;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand5;
    protected System.Data.SqlClient.SqlCommand sqlInsertCommand4;
    protected Vacations.RatesDataset RatesSet;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand7;
    protected Vacations.RoomsFurnitureDataset RoomsFurnitureSet;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand8;
    protected Vacations.AttractionsDistancesDataset AttractionsDistancesSet;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand4;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand3;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand33;
    protected System.Data.SqlClient.SqlCommand sqlSelectCommand1;
    protected Vacations.FullLocationDataset FullLocationSet1;
    protected System.Data.SqlClient.SqlCommand sqlCommand2;
    protected Vacations.FullLocationDataset FullLocationSet2;
    protected Vacations.FullLocationDataset FullLocationSet3;
    //protected System.Data.SqlClient.SqlConnection Connection;
    protected Vacations.EmailsDataset EmailsSet;
    public DataSet comment_set;
    public List<DataSet> commentimgset_list= new List<DataSet>();
    public bool pass_recaptcha = false;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        pass_recaptcha = false;
        if (IsPostBack)
        {
            string sec_key = "6LeiuBcUAAAAAPEGRRVqTcLsdO83GSnGetOwOfMM";
            string g_url = "https://www.google.com/recaptcha/api/siteverify";
            using (WebClient wc = new WebClient())
            {
                byte[] response =
                wc.UploadValues(g_url, new NameValueCollection()
                {
                   { "secret", sec_key },
                   { "response", Request["g-recaptcha-response"] }
                });

                string result = System.Text.Encoding.UTF8.GetString(response);
                JObject json = JObject.Parse(result);
                if(json["success"].ToString()!="True" || json["hostname"].ToString() != "www.vacations-abroad.com")
                {
                   // Response.Write(String.Format("{0} <<<<  {1}<<<< {2}", Request["g-recaptcha-response"], json["success"].ToString(), json["hostname"].ToString()));
                    return;
                }
                pass_recaptcha = true;
            }
        }


        if (propertyid == -1)
            Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"), true);

        System.Data.SqlClient.SqlCommandBuilder builder2 = new System.Data.SqlClient.SqlCommandBuilder(EmailsAdapter);

        comment_set = BookDBProvider.getCommentSet(propertyid);
        int rows = comment_set.Tables[0].Rows.Count;
        for(int i=0; i<rows; i++)
        {
            commentimgset_list.Add(BookDBProvider.getCommentImageSet(Int32.Parse(comment_set.Tables[0].Rows[i]["id"].ToString())));
        }

        PropertiesAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;

        //lock (CommonFunctions.Connection)
        if (PropertiesAdapter.Fill(PropertiesFullSet) < 1)
            Response.Redirect(backlinkurl);
        lblTest.Text = PropertiesAdapter.SelectCommand.CommandText;
        using (SqlConnection connection = CommonFunctions.GetConnection())
        {
            connection.Open();
            username = CommonFunctions.GetUsername(connection, (int)PropertiesFullSet.Tables["Properties"].Rows[0]["UserID"]);
            connection.Close();
        }

        AmenitiesAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
        AttractionsAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
        RoomsAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
        FurnitureAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
        RatesAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
        PaymentMethodsAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;


        AmenitiesAdapter.Fill(AmenitiesSet);

        AttractionsAdapter.Fill(AttractionsDistancesSet);

        RoomsAdapter.Fill(RoomsFurnitureSet);

        FurnitureAdapter.Fill(RoomsFurnitureSet);

        RatesAdapter.Fill(RatesSet);

        PaymentMethodsAdapter.Fill(PaymentMethodsSet);

        RoomsFurnitureSet.Relations.Add("RoomsFurniture", RoomsFurnitureSet.Tables["RoomInfo"].Columns["ID"],
            RoomsFurnitureSet.Tables["FurnitureItems"].Columns["RoomID"]);

        if (!(bool)PropertiesFullSet.Tables["Properties"].Rows[0]["IfApproved"] &&
                (!AuthenticationManager.IfAuthenticated ||
                ((AuthenticationManager.UserID != (int)PropertiesFullSet.Tables["Properties"].Rows[0]["UserID"]) &&
                !AuthenticationManager.IfAdmin)) &&
                Request.QueryString.ToString().IndexOf("IfPopup") == -1)
            Response.Redirect(backlinkurl);

        PhotosAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;


        PhotosAdapter.Fill(PhotosSet);

        if ((bool)PropertiesFullSet.Tables["Properties"].Rows[0]["IfMoreThan7PhotosAllowed"])
        {
            PhotosAdapter.SelectCommand.CommandText =
                PhotosAdapter.SelectCommand.CommandText.Replace(" TOP 7", "");


            PhotosAdapter.Fill(ExtraPhotosSet);

            foreach (DataRow datarow in PhotosSet.Tables["PropertyPhotos"].Rows)
                foreach (DataRow datarow2 in ExtraPhotosSet.Tables["PropertyPhotos"].Rows)
                    if ((int)datarow["ID"] == (int)datarow2["ID"])
                    {
                        ExtraPhotosSet.Tables["PropertyPhotos"].Rows.Remove(datarow2);
                        break;
                    }
        }

        if (Request.QueryString["PropertyID"] != null)
            PopulateCal();

        if (!IsPostBack)
        { //***this part reads daily page views and updates***
            System.Data.SqlClient.SqlCommandBuilder builder =
                new System.Data.SqlClient.SqlCommandBuilder(PropertyViewsAdapter);

            PropertyViewsAdapter.SelectCommand.Parameters["@PropertyID"].Value = propertyid;
            PropertyViewsAdapter.SelectCommand.Parameters["@Date"].Value = DateTime.Now.Date;
            string region = PropertiesFullSet.Tables["Properties"].Rows[0]["Region"].ToString();
            country = PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString();
            stateprovince = PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString();
            city = PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString();
            if (CommonFunctions.SyncFill(PropertyViewsAdapter, PropertyViewsSet) > 0)
                PropertyViewsSet.Tables["PropertyViews"].Rows[0]["Viewed"] =
                    (int)PropertyViewsSet.Tables["PropertyViews"].Rows[0]["Viewed"] + 1;
            else
            {
                DataRow datarow = PropertyViewsSet.Tables["PropertyViews"].NewRow();

                datarow["PropertyID"] = propertyid;
                datarow["Date"] = DateTime.Now.Date;
                datarow["Viewed"] = 1;

                PropertyViewsSet.Tables["PropertyViews"].Rows.Add(datarow);
            }


            PropertyViewsAdapter.Update(PropertyViewsSet);

            DataBind();

            //**find and insert ip + country + date ...CAPTURE, CONVERT, STORE
            ipHandler();
            //**find and insert ip + country + date
            hyplnkRegionBackLink.NavigateUrl= "/" + region.ToLower().Replace(" ", "_") + "/default.aspx";
            ltrRegionBackText.Text = region + "<<";

            hyplnkCountryBackLink.NavigateUrl = "/" + country.ToLower().Replace(" ", "_") + "/default.aspx";
            ltrCountryBackText.Text = country + "<<";

            hyplnkStateBackLink.NavigateUrl = "/" + country.ToLower().Replace(" ", "_") + "/" + stateprovince.ToLower().Replace(" ", "_") + "/default.aspx";
            ltrStateBackText.Text = stateprovince + "<<";

            hyplnkCityBackLink.NavigateUrl = "/" + country.ToLower().Replace(" ", "_") + "/" + stateprovince.ToLower().Replace(" ", "_") +
                "/" + city.ToLower().Replace(" ", "_") + "/default.aspx";
            ltrCityBackText.Text = city + "<<";

        }

        //  if (WebsitePresent()) { websitelink.Visible = true; };

        HtmlHead head = Page.Header;

        HtmlMeta keywords = new HtmlMeta();

        keywords.Name = "keywords";
        if (PropertiesFullSet.Tables["Properties"].Rows.Count < 1)
            keywords.Content = "View property";
        else
            keywords.Content = Keywords.Text.Replace("%city%", PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString()).
                Replace("%bedroom%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                    Replace("%stateprovince%", PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString()).
                    Replace("%country%", PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString()).
                    Replace("%region%", PropertiesFullSet.Tables["Properties"].Rows[0]["Region"].ToString()).
                    Replace("%type%", PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString()).
                    Replace("%numbedrooms%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                    Replace("%numsleeps%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"].ToString());

        head.Controls.Add(keywords);

        HtmlMeta description = new HtmlMeta();

        PropertyDetailInfo pinfo = AjaxProvider.getPropertyDetailInfo(propertyid);

        // string Des = "%name% is a %city% %numbedrooms% Bedroom %type%, Sleeps %numsleeps%, Price: %low%-%high% %cur% per %quote%";
        string Des = "%name% is a %city% %numbedrooms% Bedroom %type%, Sleeps %numsleeps%, Price: %low%-%high% %cur% per night";


        description.Name = "description";
        if (PropertiesFullSet.Tables["Properties"].Rows.Count < 1)
            description.Content = "View property";
        else
            /*
              Replace("%stateprovince%", PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString()).
                    Replace("%country%", PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString()).
                    Replace("%region%", PropertiesFullSet.Tables["Properties"].Rows[0]["Region"].ToString()).
             */
            /*/ description.Content = Des.Replace("%city%", PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString()).
                    Replace("%type%", PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString()).
 Replace("%name%", PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"].ToString()).
                     Replace("%numbedrooms%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                     Replace("%numsleeps%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"].ToString()).
                     Replace("%low%", PropertiesFullSet.Tables["Properties"].Rows[0]["MinNightRate"].ToString()).
                     Replace("%high%", PropertiesFullSet.Tables["Properties"].Rows[0]["HiNightRate"].ToString()).
                     Replace("%cur%", PropertiesFullSet.Tables["Properties"].Rows[0]["MinRateCurrency"].ToString());
         */
            description.Content = Des.Replace("%city%", PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString()).
                       Replace("%type%", pinfo.CategoryTypes).
    Replace("%name%", PropertiesFullSet.Tables["Properties"].Rows[0]["Name2"].ToString()).
                        Replace("%numbedrooms%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                        Replace("%numsleeps%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"].ToString()).
                        Replace("%low%", PropertiesFullSet.Tables["Properties"].Rows[0]["MinNightRate"].ToString()).
                        Replace("%high%", PropertiesFullSet.Tables["Properties"].Rows[0]["HiNightRate"].ToString()).
                        Replace("%cur%", PropertiesFullSet.Tables["Properties"].Rows[0]["MinRateCurrency"].ToString()).
                        Replace("%quote%", min_rentaltypes[pinfo.MinimumNightlyRentalID]);
        head.Controls.Add(description);

        photosalt = Alt.Text.Replace("%city%", PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString()).
            Replace("%bedroom%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
            Replace("%stateprovince%", PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString()).
            Replace("%country%", PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString()).
            Replace("%region%", PropertiesFullSet.Tables["Properties"].Rows[0]["Region"].ToString()).
            Replace("%type%", PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString()).
            Replace("%name%", PropertiesFullSet.Tables["Properties"].Rows[0]["Name"].ToString()).
            Replace("%numbedrooms%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
            Replace("%numsleeps%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"].ToString());

        //((System.Web.UI.WebControls.Image)Master.FindControl("Logo")).AlternateText = PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString() + " " + PropertiesFullSet.Tables["Properties"].Rows[0]["Type"].ToString();

        city = PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString();
        //add cities to right column  
        DBConnection objR = new DBConnection();
        DataTable dt = new DataTable();
        try
        {
            dt = VADBCommander.CityInd(PropertiesFullSet.Tables["Properties"].Rows[0]["cityID"].ToString());
            int vStateID = Convert.ToInt32(dt.Rows[0]["stateprovinceid"]);
            dt = VADBCommander.StateProvinceInd(vStateID.ToString());
            city_ds = AjaxProvider.getCityListbyCityNum(Int32.Parse(PropertiesFullSet.Tables["Properties"].Rows[0]["cityID"].ToString()));
            string vState = dt.Rows[0]["stateprovince"].ToString();
            string vCountryID = dt.Rows[0]["countryID"].ToString();
            dt = VADBCommander.CountryInd(vCountryID);
            string vCountry = dt.Rows[0]["country"].ToString();
            DBConnection obj3 = new DBConnection();
            SqlDataReader reader3 =
                obj3.ExecuteRecordSetArtificial("SELECT Cities.* FROM Cities WHERE (Cities.StateProvinceID = " +
                                                vStateID +
                                                ") AND EXISTS ( SELECT * FROM Properties WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1) AND (Properties.CityID = Cities.ID)  AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID)) ORDER BY City");
            rtLow3.InnerHtml = "";
            rtHd3.InnerHtml = "";
            while (reader3.Read())
            {
                if (reader3["City"] is string)
                {
                    string temp = CommonFunctions.GetSiteAddress() + "/" + vCountry +
                                  "/" + vState + "/" + reader3["city"].ToString() + "/default.aspx";
                    temp = temp.ToLower();
                    temp = temp.Replace(' ', '_');

                    rtLow3.InnerHtml += "<a href=\"" + temp + "\"><span class=\"tdNoSleeps\">" +
                                        reader3["city"].ToString().Replace(" ", "&nbsp;") + "</span></a>, ";
                }
            }
            reader3.Close();
            if( rtLow3.InnerHtml.Length>2)  rtLow3.InnerHtml = rtLow3.InnerHtml.Remove(rtLow3.InnerHtml.Length - 2, 2);
            rtHd3.InnerHtml = vState + " Cities";
            SqlDataAdapter StateProvincesAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(),
                "SELECT StateProvinces.* " +
                "FROM StateProvinces " +
                "WHERE (StateProvinces.CountryID = @CountryID) AND EXISTS (" +
                " SELECT * FROM Properties INNER JOIN Cities ON Properties.CityID = Cities.ID" +
                " WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1)" +
                " AND (Cities.StateProvinceID = StateProvinces.ID) " +
                " AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID)) " +
                "ORDER BY StateProvince", SqlDbType.Int);
            StateProvincesAdapter.SelectCommand.Parameters["@CountryID"].Value = vCountryID;
            DataSet dsState = new DataSet();
            StateProvincesAdapter.Fill(dsState, "StateProvinces");
            //foreach (DataRow dr in dsState.Tables["StateProvinces"].Rows)
            //{
            //    string temp = CommonFunctions.GetSiteAddress() + "/" + vCountry +
            //                  "/" + dr["StateProvince"].ToString() + "/default.aspx";
            //    temp = temp.ToLower();
            //    temp = temp.Replace(' ', '_');
            //    rtStateLow.InnerHtml += "<a href=\"" + temp + "\"><span class=\"tdNoSleeps\">" +
            //                            dr["StateProvince"].ToString().Replace(" ", "&nbsp;") + "</span></a>, ";
            //}
            //rtStateLow.InnerHtml = rtStateLow.InnerHtml.Remove(rtStateLow.InnerHtml.Length - 2, 2);
            //rtStateHD.InnerHtml = vCountry + " States";

        }
        //catch (Exception ex) { lblInfo.Text = ex.Message; }
        finally { objR.CloseConnection(); }
        //Page.Header.Controls.Add(new LiteralControl("<link href='http://vacations-abroad.com/css/StyleSheetProperty.css' rel='stylesheet' type='text/css'></script>"));
        ContactEmail.Enabled = true;
        //PropertyInform pinfo = BookDBProvider.getPropertyInfo(propertyid);
        userinfo = BookDBProvider.getDetailedUserInfo(pinfo.UserID);
        if (!IsPostBack)
        {
            if (AuthenticationManager.IfAuthenticated && User.Identity.IsAuthenticated)
            {
                //userinfo = BookDBProvider.getDetailedUserInfo(AuthenticationManager.UserID);
                duserinfo = BookDBProvider.getUserInfo(AuthenticationManager.UserID);

                //ContactName.Text = duserinfo.FirstName + " " + duserinfo.LastName;
                ContactName.Text = duserinfo.firstname + " " + duserinfo.lastname;
                //ContactEmail.Text = userinfo.Email;
                ContactEmail.Text = duserinfo.email;
                ContactEmail.Enabled = false;
            }
        }
        

    }
    public void ipHandler()
    {  //capture, convert, store
        DBConnection obj = new DBConnection();
        DataTable dt = new DataTable();
        string nowip = "";
        long longIP = 0;
        try
        {
            //1.
            nowip = "";
            if (Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
                nowip = Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            if (nowip == "")
            {
                nowip = Request.ServerVariables["REMOTE_ADDR"].ToString();
            }


            //2.
            string dottedip = "";

            string[] tempAry = new string[4];

            dottedip = nowip;

            tempAry = dottedip.Split('.');

            //longIP = (a + b + c + d).ToString();
            longIP = (Convert.ToInt64(tempAry[0]) * 16777216) + (Convert.ToInt64(tempAry[1]) * 65536) +
            (Convert.ToInt64(tempAry[2]) * 256) + Convert.ToInt64(tempAry[3]);

            string ipCountry = "";
            dt = VADBCommander.IPCountryList(longIP.ToString());
            if (dt.Rows.Count > 0)
            {
                ipCountry = dt.Rows[0]["long"].ToString();
            }

            //3.
            VADBCommander.IPPropertyLogAdd(nowip, ipCountry, propertyid.ToString());
        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.Message;
        }
    }
    public string GetTitle()
    {
        if (PropertiesFullSet.Tables["Properties"].Rows.Count < 1)
            return "View Property";
        else
            return Title.Text.Replace("%city%", PropertiesFullSet.Tables["Properties"].Rows[0]["City"].ToString()).
                Replace("%bedroom%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                Replace("%stateprovince%", PropertiesFullSet.Tables["Properties"].Rows[0]["StateProvince"].ToString()).
                Replace("%country%", PropertiesFullSet.Tables["Properties"].Rows[0]["Country"].ToString()).
                Replace("%region%", PropertiesFullSet.Tables["Properties"].Rows[0]["Region"].ToString()).
                Replace("%type%", PropertiesFullSet.Tables["Properties"].Rows[0]["type"].ToString()).
                Replace("%numbedrooms%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumBedrooms"].ToString()).
                Replace("%numsleeps%", PropertiesFullSet.Tables["Properties"].Rows[0]["NumSleeps"].ToString()).
                Replace("%name%", PropertiesFullSet.Tables["Properties"].Rows[0]["Name"].ToString()).
        Replace("%propid%", propertyid.ToString());
    }

    public bool IfAmenityPresent(string Amenity)
    {
        foreach (DataRow datarow in AmenitiesSet.Tables["Amenities"].Rows)
            if (datarow.RowState != DataRowState.Deleted)
                if (string.Compare((string)datarow["Amenity"], Amenity, true) == 0)
                    return true;

        return false;
    }

    public bool WebsitePresent()
    {
        bool returnval = false;

        if ((PropertiesFullSet.Tables["Properties"].Rows[0]["Website"]).ToString() == null) { return false; };

        string tmp = (PropertiesFullSet.Tables["Properties"].Rows[0]["Website"]).ToString();
        if (tmp.Length > 5) { return true; };


        return returnval;

        //return ((int)PropertiesFullSet.Tables["Properties"].Rows[0]["IfPaid"] == 1) &&
        //    (PropertiesFullSet.Tables["Properties"].Rows[0]["Website"] is string) &&
        //    (((string)PropertiesFullSet.Tables["Properties"].Rows[0]["Website"]).Length > 5) &&
        //    (((string)PropertiesFullSet.Tables["Properties"].Rows[0]["Website"]).StartsWith("http://"));
    }

    public bool Approved()
    {
        return (bool)PropertiesFullSet.Tables["Properties"].Rows[0]["IfApproved"];
    }

    public bool IfShowContactInfo()
    {
        return (int)PropertiesFullSet.Tables["Properties"].Rows[0]["IfPaid"] == 1;
    }

    public bool PicturesTooWide(int maxwidth, int startindex, int endindex)
    {
        int i;
        int sumlen;

        i = 0;
        sumlen = 0;
        foreach (DataRow datarow in PhotosSet.Tables["PropertyPhotos"].Rows)
        {
            if ((startindex <= i) && (i <= endindex))
                sumlen += (int)datarow["Width"];
            i++;
        }

        return (sumlen > maxwidth);
    }

    public bool IfEvenRow(System.Data.DataRowView rowview)
    {
        int i = 0;
        foreach (DataRowView curview in rowview.DataView)
        {
            if ((int)rowview.Row["ID"] == (int)curview.Row["ID"])
                break;
            i++;
        }

        return (i % 2) != 0;
    }

    public string ViewedText()
    {
        string retval = "";

        if (PropertiesFullSet.Tables["Properties"].Rows[0]["DateCreated"] is DateTime)
            retval += "Customer Since " +
                ((DateTime)PropertiesFullSet.Tables["Properties"].Rows[0]["DateCreated"]).ToString("MMM yyyy") + "<br />";

        if (PropertiesFullSet.Tables["Properties"].Rows[0]["DateStartViewed"] is DateTime)
            retval += "Page Views Since " +
                ((DateTime)PropertiesFullSet.Tables["Properties"].Rows[0]["DateStartViewed"]).ToString("MMM yyyy") + "<br />";

        {
            object result = null;
            using (SqlConnection connection = CommonFunctions.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("PropertyViewsAdd", connection);
                command.Parameters.Add("@PropertyID", System.Data.SqlDbType.Int, 4);
                command.Parameters.Add("@Date", System.Data.SqlDbType.SmallDateTime, 4);
                command.Parameters["@PropertyID"].Value = propertyid;
                command.Parameters["@Date"].Value = DateTime.Now.Date;
                command.CommandType = CommandType.StoredProcedure;
                result = command.ExecuteScalar();
                connection.Close();
            }
            if (result is int)
                retval += "Today " + ((int)result).ToString() + ", ";
        }

        {
            object result = null;
            using (SqlConnection connection = CommonFunctions.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ISNULL(SUM(Viewed),0) FROM PropertyViews WHERE (PropertyID = @PropertyID) AND (MONTH(Date) = MONTH(@Date)) AND (YEAR(Date) = YEAR(@Date))", connection);
                command.Parameters.Add("@PropertyID", System.Data.SqlDbType.Int, 4);
                command.Parameters.Add("@Date", System.Data.SqlDbType.SmallDateTime, 4);
                command.Parameters["@PropertyID"].Value = propertyid;
                command.Parameters["@Date"].Value = DateTime.Now.Date;

                //if (CommonFunctions.Connection.State == ConnectionState.Closed)
                //CommonFunctions.Connection.Open ();

                result = command.ExecuteScalar();
                connection.Close();
            }

            if (result is int)
                retval += "This month " + ((int)result).ToString() + "<br />";
        }

        {
            object result = null;
            using (SqlConnection connection = CommonFunctions.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ISNULL(SUM(Viewed),0) FROM PropertyViews WHERE (PropertyID = @PropertyID) AND (YEAR(Date) = YEAR(@Date))", connection);
                command.Parameters.Add("@PropertyID", System.Data.SqlDbType.Int, 4);
                command.Parameters.Add("@Date", System.Data.SqlDbType.SmallDateTime, 4);
                command.Parameters["@PropertyID"].Value = propertyid;
                command.Parameters["@Date"].Value = DateTime.Now.Date;

                //if (CommonFunctions.Connection.State == ConnectionState.Closed)
                //CommonFunctions.Connection.Open ();

                result = command.ExecuteScalar();
                connection.Close();
            }
            if (result is int)
                retval += "YTD " + ((int)result).ToString() + ", ";
        }

        {
            object result = null;
            using (SqlConnection connection = CommonFunctions.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT ISNULL(SUM(Viewed),0) FROM PropertyViews WHERE (PropertyID = @PropertyID)", connection);
                command.Parameters.Add("@PropertyID", System.Data.SqlDbType.Int, 4);
                command.Parameters["@PropertyID"].Value = propertyid;

                //if (CommonFunctions.Connection.State == ConnectionState.Closed)
                //CommonFunctions.Connection.Open ();

                result = command.ExecuteScalar();
                connection.Close();
            }
            if (result is int)
                retval += "Total " + ((int)result).ToString() + "<br />";
        }

        return retval;
    }

    public bool ShowRatesTable()
    {
        if ((PropertiesFullSet.Tables["Properties"].Rows[0]["RatesTable"] is bool) && (bool)PropertiesFullSet.Tables["Properties"].Rows[0]["RatesTable"])
            return true;
        else
            return false;
    }
    public bool CalendarEntriesPresent()
    {
        bool retval = false;
        object result = null;
        {

            using (SqlConnection connection = CommonFunctions.GetConnection())
            {
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT Count(id) From PropertyAvailDates WHERE (PropertyID = @PropertyID)", connection);
                command.Parameters.Add("@PropertyID", System.Data.SqlDbType.Int, 4);
                command.Parameters["@PropertyID"].Value = propertyid;

                //if (CommonFunctions.Connection.State == ConnectionState.Closed)
                //CommonFunctions.Connection.Open ();

                result = command.ExecuteScalar();
                connection.Close();
            }

        }
        //if (result is int) 
        int numrows = ((int)result);
        if (numrows > 0) retval = true;

        return retval;
    }
    public bool PaymentMethodsPresent()
    {
        return (PaymentMethodsSet.Tables["PaymentMethods"].Rows.Count > 0);
    }

    public bool LodgingTaxPresent()
    {
        return (PropertiesFullSet.Tables["Properties"].Rows[0]["LodgingTax"] is string);
    }

    #region Web Form Designer generated code
    override protected void OnInit(EventArgs e)
    {
        //
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
        //
        InitializeComponent();
        base.OnInit(e);
    }

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
        //CommonFunctions.Connection = new System.Data.SqlClient.SqlConnection();
        this.PropertiesFullSet = new Vacations.PropertiesFullDataset();
        this.PhotosSet = new Vacations.PhotosDataset();
        this.PhotosAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlCommand1 = new System.Data.SqlClient.SqlCommand();
        this.ExtraPhotosSet = new Vacations.PhotosDataset();
        this.AmenitiesAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlInsertCommand1 = new System.Data.SqlClient.SqlCommand();
        this.sqlSelectCommand2 = new System.Data.SqlClient.SqlCommand();
        this.AttractionsAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand3 = new System.Data.SqlClient.SqlCommand();
        this.sqlSelectCommand33 = new System.Data.SqlClient.SqlCommand();
        this.AmenitiesSet = new Vacations.AmenitiesDataset();
        this.PropertyViewsAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand4 = new System.Data.SqlClient.SqlCommand();
        this.PropertyViewsSet = new Vacations.PropertyViewsDataset();
        this.PropertiesAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand1 = new System.Data.SqlClient.SqlCommand();
        this.PaymentMethodsAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlInsertCommand4 = new System.Data.SqlClient.SqlCommand();
        this.sqlSelectCommand5 = new System.Data.SqlClient.SqlCommand();
        this.PaymentMethodsSet = new Vacations.PaymentMethodsDataset();
        this.RatesAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand6 = new System.Data.SqlClient.SqlCommand();
        this.RatesSet = new Vacations.RatesDataset();
        this.RoomsAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand7 = new System.Data.SqlClient.SqlCommand();
        this.FurnitureAdapter = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlSelectCommand8 = new System.Data.SqlClient.SqlCommand();
        this.RoomsFurnitureSet = new Vacations.RoomsFurnitureDataset();
        this.AttractionsDistancesSet = new Vacations.AttractionsDistancesDataset();
        this.FullLocationSet1 = new Vacations.FullLocationDataset();
        this.GetLocationInfo = new System.Data.SqlClient.SqlDataAdapter();
        this.sqlCommand2 = new System.Data.SqlClient.SqlCommand();
        this.FullLocationSet2 = new Vacations.FullLocationDataset();
        this.FullLocationSet3 = new Vacations.FullLocationDataset();
        this.EmailsSet = new Vacations.EmailsDataset();
        this.EmailsAdapter = new System.Data.SqlClient.SqlDataAdapter();

        ((System.ComponentModel.ISupportInitialize)(this.PropertiesFullSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.PhotosSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.ExtraPhotosSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.AmenitiesSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.PropertyViewsSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.PaymentMethodsSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.RatesSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.RoomsFurnitureSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.AttractionsDistancesSet)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet1)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet2)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet3)).BeginInit();
        ((System.ComponentModel.ISupportInitialize)(this.EmailsSet)).BeginInit();

        // 
        // CommonFunctions.Connection
        // 
        //CommonFunctions.Connection.ConnectionString = "workstation id=MAIN;packet size=4096;integrated security=SSPI;data source=MAIN;pe" +
        //"rsist security info=False;initial catalog=Vacations";
        // 
        // PropertiesFullSet
        // 
        this.PropertiesFullSet.DataSetName = "PropertiesFullDataset";
        this.PropertiesFullSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // PhotosSet
        // 
        this.PhotosSet.DataSetName = "PhotosDataset";
        this.PhotosSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // PhotosAdapter
        // 
        this.PhotosAdapter.SelectCommand = this.sqlCommand1;
        this.PhotosAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																								new System.Data.Common.DataTableMapping("Table", "PropertyPhotos", new System.Data.Common.DataColumnMapping[] {
																																																				  new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																				  new System.Data.Common.DataColumnMapping("PropertyID", "PropertyID"),
																																																				  new System.Data.Common.DataColumnMapping("FileName", "FileName"),
																																																				  new System.Data.Common.DataColumnMapping("OrderNumber", "OrderNumber"),
																																																				  new System.Data.Common.DataColumnMapping("Width", "Width"),
																																																				  new System.Data.Common.DataColumnMapping("Height", "Height")})});
        // 
        // sqlCommand1
        // 
        this.sqlCommand1.CommandText = "SELECT TOP 7 ID, PropertyID, FileName, OrderNumber, Width, Height FROM PropertyPh" +
            "otos WHERE (PropertyID = @PropertyID) ORDER BY OrderNumber";
        this.sqlCommand1.Connection = CommonFunctions.GetConnection();
        this.sqlCommand1.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // ExtraPhotosSet
        // 
        this.ExtraPhotosSet.DataSetName = "PhotosDataset";
        this.ExtraPhotosSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // AmenitiesAdapter
        // 
        this.AmenitiesAdapter.InsertCommand = this.sqlInsertCommand1;
        this.AmenitiesAdapter.SelectCommand = this.sqlSelectCommand2;
        this.AmenitiesAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																								   new System.Data.Common.DataTableMapping("Table", "Amenities", new System.Data.Common.DataColumnMapping[] {
																																																				new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																				new System.Data.Common.DataColumnMapping("Amenity", "Amenity")})});
        // 
        // sqlInsertCommand1
        // 
        this.sqlInsertCommand1.CommandText = "INSERT INTO Amenities(ID, Amenity) VALUES (@ID, @Amenity)";
        this.sqlInsertCommand1.Connection = CommonFunctions.GetConnection();
        this.sqlInsertCommand1.Parameters.Add(new System.Data.SqlClient.SqlParameter("@ID", System.Data.SqlDbType.Int, 4, "ID"));
        this.sqlInsertCommand1.Parameters.Add(new System.Data.SqlClient.SqlParameter("@Amenity", System.Data.SqlDbType.NVarChar, 300, "Amenity"));
        // 
        // sqlSelectCommand2
        // 
        this.sqlSelectCommand2.CommandText = @"SELECT Amenities.ID, Amenities.Amenity FROM Amenities INNER JOIN PropertiesAmenities ON Amenities.ID = PropertiesAmenities.AmenityID WHERE (PropertiesAmenities.PropertyID = @PropertyID) AND (Amenities.Amenity <> 'TV') AND (Amenities.Amenity <> 'VCR') AND (Amenities.Amenity <> 'CD Player')";
        this.sqlSelectCommand2.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand2.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // AttractionsAdapter
        // 
        this.AttractionsAdapter.SelectCommand = this.sqlSelectCommand3;
        this.AttractionsAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																									 new System.Data.Common.DataTableMapping("Table", "Attractions", new System.Data.Common.DataColumnMapping[] {
																																																					new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																					new System.Data.Common.DataColumnMapping("Attraction", "Attraction"),
																																																					new System.Data.Common.DataColumnMapping("DistanceID", "DistanceID"),
																																																					new System.Data.Common.DataColumnMapping("Distance", "Distance")})});
        // 
        // sqlSelectCommand3
        // 
        this.sqlSelectCommand3.CommandText = @"SELECT Attractions.ID, Attractions.Attraction, Distances.ID AS DistanceID, Distances.Distance FROM Attractions INNER JOIN PropertiesAttractions ON Attractions.ID = PropertiesAttractions.AttractionID INNER JOIN Distances ON PropertiesAttractions.DistanceID = Distances.ID WHERE (PropertiesAttractions.PropertyID = @PropertyID)";
        this.sqlSelectCommand3.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand3.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // AmenitiesSet
        // 
        this.AmenitiesSet.DataSetName = "AmenitiesDataset";
        this.AmenitiesSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // PropertyViewsAdapter
        // 
        this.PropertyViewsAdapter.SelectCommand = this.sqlSelectCommand4;
        this.PropertyViewsAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																									   new System.Data.Common.DataTableMapping("Table", "PropertyViews", new System.Data.Common.DataColumnMapping[] {
																																																						new System.Data.Common.DataColumnMapping("PropertyID", "PropertyID"),
																																																						new System.Data.Common.DataColumnMapping("Date", "Date"),
																																																						new System.Data.Common.DataColumnMapping("Viewed", "Viewed")})});
        // 
        // sqlSelectCommand4
        // 
        this.sqlSelectCommand4.CommandText = "SELECT PropertyID, Date, Viewed FROM PropertyViews WHERE (PropertyID = @PropertyI" +
            "D) AND (Date = @Date)";
        this.sqlSelectCommand4.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand4.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        this.sqlSelectCommand4.Parameters.Add(new System.Data.SqlClient.SqlParameter("@Date", System.Data.SqlDbType.DateTime, 4, "Date"));
        // 
        // PropertyViewsSet
        // 
        this.PropertyViewsSet.DataSetName = "PropertyViewsDataset";
        this.PropertyViewsSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // PropertiesAdapter
        // 
        this.PropertiesAdapter.SelectCommand = this.sqlSelectCommand1;
        this.PropertiesAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																									new System.Data.Common.DataTableMapping("Table", "Properties", new System.Data.Common.DataColumnMapping[] {
																																																				  new System.Data.Common.DataColumnMapping("MinimumNightlyRental", "MinimumNightlyRental"),
																																																				  new System.Data.Common.DataColumnMapping("Type", "Type"),
																																																				  new System.Data.Common.DataColumnMapping("FirstName", "FirstName"),
																																																				  new System.Data.Common.DataColumnMapping("LastName", "LastName"),
																																																				  new System.Data.Common.DataColumnMapping("PrimaryTelephone", "PrimaryTelephone"),
																																																				  new System.Data.Common.DataColumnMapping("OwnerCountry", "OwnerCountry"),
																																																				  new System.Data.Common.DataColumnMapping("Email", "Email"),
																																																				  new System.Data.Common.DataColumnMapping("Username", "Username"),
																																																				  new System.Data.Common.DataColumnMapping("OwnerAddress", "OwnerAddress"),
																																																				  new System.Data.Common.DataColumnMapping("EveningTelephone", "EveningTelephone"),
																																																				  new System.Data.Common.DataColumnMapping("DaytimeTelephone", "DaytimeTelephone"),
																																																				  new System.Data.Common.DataColumnMapping("MobileTelephone", "MobileTelephone"),
																																																				  new System.Data.Common.DataColumnMapping("Website", "Website"),
																																																				  new System.Data.Common.DataColumnMapping("OwnerCity", "OwnerCity"),
																																																				  new System.Data.Common.DataColumnMapping("OwnerState", "OwnerState"),
																																																				  new System.Data.Common.DataColumnMapping("OwnerZip", "OwnerZip"),
																																																				  new System.Data.Common.DataColumnMapping("Registered", "Registered"),
																																																				  new System.Data.Common.DataColumnMapping("IfPayTravelAgents", "IfPayTravelAgents"),
																																																				  new System.Data.Common.DataColumnMapping("City", "City"),
																																																				  new System.Data.Common.DataColumnMapping("StateProvince", "StateProvince"),
																																																				  new System.Data.Common.DataColumnMapping("Country", "Country"),
																																																				  new System.Data.Common.DataColumnMapping("Region", "Region"),
																																																				  new System.Data.Common.DataColumnMapping("Smoking", "Smoking"),
																																																				  new System.Data.Common.DataColumnMapping("PetFriendly", "PetFriendly"),
																																																				  new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																				  new System.Data.Common.DataColumnMapping("UserID", "UserID"),
																																																				  new System.Data.Common.DataColumnMapping("Name", "Name"),
																																																				  new System.Data.Common.DataColumnMapping("TypeID", "TypeID"),
																																																				  new System.Data.Common.DataColumnMapping("Address", "Address"),
																																																				  new System.Data.Common.DataColumnMapping("CityID", "CityID"),
																																																				  new System.Data.Common.DataColumnMapping("IfShowAddress", "IfShowAddress"),
																																																				  new System.Data.Common.DataColumnMapping("NumBedrooms", "NumBedrooms"),
																																																				  new System.Data.Common.DataColumnMapping("NumBaths", "NumBaths"),
																																																				  new System.Data.Common.DataColumnMapping("NumSleeps", "NumSleeps"),
																																																				  new System.Data.Common.DataColumnMapping("MinimumNightlyRentalID", "MinimumNightlyRentalID"),
																																																				  new System.Data.Common.DataColumnMapping("NumTVs", "NumTVs"),
																																																				  new System.Data.Common.DataColumnMapping("NumVCRs", "NumVCRs"),
																																																				  new System.Data.Common.DataColumnMapping("NumCDPlayers", "NumCDPlayers"),
																																																				  new System.Data.Common.DataColumnMapping("Description", "Description"),
																																																				  new System.Data.Common.DataColumnMapping("Amenities", "Amenities"),
																																																				  new System.Data.Common.DataColumnMapping("LocalAttractions", "LocalAttractions"),
																																																				  new System.Data.Common.DataColumnMapping("Rates", "Rates"),
																																																				  new System.Data.Common.DataColumnMapping("CancellationPolicy", "CancellationPolicy"),
																																																				  new System.Data.Common.DataColumnMapping("DepositRequired", "DepositRequired"),
																																																				  new System.Data.Common.DataColumnMapping("IfMoreThan7PhotosAllowed", "IfMoreThan7PhotosAllowed"),
																																																				  new System.Data.Common.DataColumnMapping("IfFinished", "IfFinished"),
																																																				  new System.Data.Common.DataColumnMapping("IfApproved", "IfApproved"),
																																																				  new System.Data.Common.DataColumnMapping("IfPaid", "IfPaid"),
																																																				  new System.Data.Common.DataColumnMapping("DateAdded", "DateAdded"),
																																																				  new System.Data.Common.DataColumnMapping("DateStartViewed", "DateStartViewed"),
																																																				  new System.Data.Common.DataColumnMapping("VirtualTour", "VirtualTour"),
																																																				  new System.Data.Common.DataColumnMapping("RatesTable", "RatesTable"),
																																																				  new System.Data.Common.DataColumnMapping("PricesCurrency", "PricesCurrency"),
																																																				  new System.Data.Common.DataColumnMapping("CheckIn", "CheckIn"),
																																																				  new System.Data.Common.DataColumnMapping("CheckOut", "CheckOut"),
																																																				  new System.Data.Common.DataColumnMapping("LodgingTax", "LodgingTax"),
																																																				  new System.Data.Common.DataColumnMapping("TaxIncluded", "TaxIncluded"),
																																																				  new System.Data.Common.DataColumnMapping("DateAvailable", "DateAvailable"),
																																																				  new System.Data.Common.DataColumnMapping("IfDiscounted", "IfDiscounted"),
																																																				  new System.Data.Common.DataColumnMapping("IfLastMinuteCancellations", "IfLastMinuteCancellations"),
																																																				  new System.Data.Common.DataColumnMapping("LastMinuteComments", "LastMinuteComments"),
																																																				  new System.Data.Common.DataColumnMapping("HomeExchangeCityID1", "HomeExchangeCityID1"),
																																																				  new System.Data.Common.DataColumnMapping("HomeExchangeCityID2", "HomeExchangeCityID2"),
																																																				  new System.Data.Common.DataColumnMapping("HomeExchangeCityID3", "HomeExchangeCityID3"),
																																																				  new System.Data.Common.DataColumnMapping("HomeExchangeComments", "HomeExchangeComments")})});
        // 
        // sqlSelectCommand1
        // 
        this.sqlSelectCommand1.CommandText = "SELECT CityID, MinimumNightlyRentalTypes.Name AS MinimumNightlyRental, " +
            " PropertyTypes.Name as Type, Users.FirstName, Users.LastName, Users.PrimaryTelephone, Users.Country" +
            " AS OwnerCountry, Users.Email, Users.Username, Users.Address AS OwnerAddress, Us" +
            "ers.EveningTelephone, Users.DaytimeTelephone, Users.MobileTelephone, Users.Websi" +
            "te, Users.City AS OwnerCity, Users.State AS OwnerState, Users.Zip AS OwnerZip, U" +
            "sers.Registered, Users.IfPayTravelAgents, Users.DateCreated, Cities.City, StateProvinces.StateProvi" +
            "nce, Countries.Country, Regions.Region, CASE WHEN EXISTS (SELECT * FROM Properti" +
            "esAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID" +
            " WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity =" +
            " \'Smoking Permitted\')) THEN \'Yes\' ELSE \'No\' END AS Smoking, CASE WHEN EXISTS (SE" +
            "LECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.Amen" +
            "ityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND " +
            "(Amenities.Amenity = \'Pet Friendly\')) THEN \'Yes\' ELSE \'No\' END AS PetFriendly, P" +
            "roperties.ID, Properties.UserID, Properties.Name, Properties.TypeID, Properties." +
            "Address, Properties.CityID, Properties.IfShowAddress, Properties.NumBedrooms, Pr" +
            "operties.NumBaths, Properties.NumSleeps,Properties.MinNightRate,Properties.HiNightRate,Properties.MinRateCurrency,Properties.Name2, Properties.MinimumNightlyRentalID, Prop" +
            "erties.NumTVs, Properties.NumVCRs, Properties.NumCDPlayers, Properties.Descripti" +
            "on, Properties.Amenities, Properties.LocalAttractions, Properties.Rates, Propert" +
            "ies.CancellationPolicy, Properties.DepositRequired, Properties.IfMoreThan7Photos" +
            "Allowed, Properties.IfFinished, Properties.IfApproved, CASE WHEN EXISTS (SELECT " +
            "* FROM Invoices WHERE (Invoices.PropertyID = Properties.ID) AND (PaymentAmount >= InvoiceAmount) AND (GETDATE() <= RenewalDate)) THEN 1" +
            " ELSE 0 END AS IfPaid, Properties.DateAdded, Properties.DateStartViewed, Propert" +
            "ies.VirtualTour, Properties.RatesTable, Properties.PricesCurrency, Properties.Ch" +
            "eckIn, Properties.CheckOut, Properties.LodgingTax, Properties.TaxIncluded, Prope" +
            "rties.DateAvailable, Properties.IfDiscounted, Properties.IfLastMinuteCancellatio" +
            "ns, Properties.LastMinuteComments, Properties.HomeExchangeCityID1, Properties.Ho" +
            "meExchangeCityID2, Properties.HomeExchangeCityID3, Properties.HomeExchangeCommen" +
            "ts FROM Properties INNER JOIN Cities ON Properties.CityID = Cities.ID INNER JOIN" +
            " StateProvinces ON StateProvinces.ID = Cities.StateProvinceID INNER JOIN Countri" +
            "es ON StateProvinces.CountryID = Countries.ID INNER JOIN Regions ON Countries.Re" +
            "gionID = Regions.ID INNER JOIN Users ON Properties.UserID = Users.ID LEFT OUTER " +
            "JOIN MinimumNightlyRentalTypes ON Properties.MinimumNightlyRentalID = MinimumNig" +
            "htlyRentalTypes.ID LEFT OUTER JOIN PropertyTypes ON Properties.TypeID = Property" +
            "Types.ID LEFT JOIN PropertyCategories ON PropertyCategories.ID=PropertyTypes.Category WHERE (Properties.ID = @PropertyID)";
        this.sqlSelectCommand1.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand1.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "ID"));
        // 
        // PaymentMethodsAdapter
        // 
        this.PaymentMethodsAdapter.InsertCommand = this.sqlInsertCommand4;
        this.PaymentMethodsAdapter.SelectCommand = this.sqlSelectCommand5;
        this.PaymentMethodsAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																										new System.Data.Common.DataTableMapping("Table", "PaymentMethods", new System.Data.Common.DataColumnMapping[] {
																																																						  new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																						  new System.Data.Common.DataColumnMapping("PaymentMethod", "PaymentMethod")})});
        // 
        // sqlInsertCommand4
        // 
        this.sqlInsertCommand4.CommandText = "INSERT INTO PaymentMethods(ID, PaymentMethod) VALUES (@ID, @PaymentMethod)";
        this.sqlInsertCommand4.Connection = CommonFunctions.GetConnection();
        this.sqlInsertCommand4.Parameters.Add(new System.Data.SqlClient.SqlParameter("@ID", System.Data.SqlDbType.Int, 4, "ID"));
        this.sqlInsertCommand4.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PaymentMethod", System.Data.SqlDbType.NVarChar, 300, "PaymentMethod"));
        // 
        // sqlSelectCommand5
        // 
        this.sqlSelectCommand5.CommandText = "SELECT PaymentMethods.ID, PaymentMethods.PaymentMethod FROM PaymentMethods INNER " +
            "JOIN PropertiesPaymentMethods ON PaymentMethods.ID = PropertiesPaymentMethods.Pa" +
            "ymentMethodID WHERE (PropertiesPaymentMethods.PropertyID = @PropertyID)";
        this.sqlSelectCommand5.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand5.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // PaymentMethodsSet
        // 
        this.PaymentMethodsSet.DataSetName = "PaymentMethodsDataset";
        this.PaymentMethodsSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // RatesAdapter
        // 
        this.RatesAdapter.SelectCommand = this.sqlSelectCommand6;
        this.RatesAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																							   new System.Data.Common.DataTableMapping("Table", "Rates", new System.Data.Common.DataColumnMapping[] {
																																																		new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																		new System.Data.Common.DataColumnMapping("PropertyID", "PropertyID"),
																																																		new System.Data.Common.DataColumnMapping("StartDate", "StartDate"),
																																																		new System.Data.Common.DataColumnMapping("EndDate", "EndDate"),
																																																		new System.Data.Common.DataColumnMapping("Nightly", "Nightly"),
																																																		new System.Data.Common.DataColumnMapping("Weekly", "Weekly"),
																																																		new System.Data.Common.DataColumnMapping("Monthly", "Monthly")})});
        // 
        // sqlSelectCommand6
        // 
        this.sqlSelectCommand6.CommandText = "SELECT ID, PropertyID, StartDate, EndDate, Nightly, Weekly, Monthly FROM Rates WH" +
            "ERE (PropertyID = @PropertyID)";
        this.sqlSelectCommand6.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand6.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // RatesSet
        // 
        this.RatesSet.DataSetName = "RatesDataset";
        this.RatesSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // RoomsAdapter
        // 
        this.RoomsAdapter.SelectCommand = this.sqlSelectCommand7;
        this.RoomsAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																							   new System.Data.Common.DataTableMapping("Table", "RoomInfo", new System.Data.Common.DataColumnMapping[] {
																																																		   new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																		   new System.Data.Common.DataColumnMapping("PropertyID", "PropertyID"),
																																																		   new System.Data.Common.DataColumnMapping("RoomTitle", "RoomTitle")})});
        // 
        // sqlSelectCommand7
        // 
        this.sqlSelectCommand7.CommandText = "SELECT ID, PropertyID, RoomTitle FROM RoomInfo WHERE (PropertyID = @PropertyID)";
        this.sqlSelectCommand7.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand7.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // FurnitureAdapter
        // 
        this.FurnitureAdapter.SelectCommand = this.sqlSelectCommand8;
        this.FurnitureAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																								   new System.Data.Common.DataTableMapping("Table", "FurnitureItems", new System.Data.Common.DataColumnMapping[] {
																																																					 new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																					 new System.Data.Common.DataColumnMapping("FurnitureItem", "FurnitureItem"),
																																																					 new System.Data.Common.DataColumnMapping("RoomID", "RoomID")})});
        // 
        // sqlSelectCommand8
        // 
        this.sqlSelectCommand8.CommandText = @"SELECT FurnitureItems.ID, FurnitureItems.FurnitureItem, RoomFurnitureItems.RoomID FROM FurnitureItems INNER JOIN RoomFurnitureItems ON FurnitureItems.ID = RoomFurnitureItems.FurnitureItemID INNER JOIN RoomInfo ON RoomFurnitureItems.RoomID = RoomInfo.ID WHERE (RoomInfo.PropertyID = @PropertyID)";
        this.sqlSelectCommand8.Connection = CommonFunctions.GetConnection();
        this.sqlSelectCommand8.Parameters.Add(new System.Data.SqlClient.SqlParameter("@PropertyID", System.Data.SqlDbType.Int, 4, "PropertyID"));
        // 
        // RoomsFurnitureSet
        // 
        this.RoomsFurnitureSet.DataSetName = "RoomsFurnitureDataset";
        this.RoomsFurnitureSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // AttractionsDistancesSet
        // 
        this.AttractionsDistancesSet.DataSetName = "AttractionsDistancesDataset";
        this.AttractionsDistancesSet.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // FullLocationSet1
        // 
        this.FullLocationSet1.DataSetName = "FullLocationDataset";
        this.FullLocationSet1.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // GetLocationInfo
        // 
        this.GetLocationInfo.SelectCommand = this.sqlCommand2;
        this.GetLocationInfo.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																								  new System.Data.Common.DataTableMapping("Table", "Cities", new System.Data.Common.DataColumnMapping[] {
																																																			new System.Data.Common.DataColumnMapping("CityID", "CityID"),
																																																			new System.Data.Common.DataColumnMapping("City", "City"),
																																																			new System.Data.Common.DataColumnMapping("StateProvinceID", "StateProvinceID"),
																																																			new System.Data.Common.DataColumnMapping("StateProvince", "StateProvince"),
																																																			new System.Data.Common.DataColumnMapping("CountryID", "CountryID"),
																																																			new System.Data.Common.DataColumnMapping("Country", "Country"),
																																																			new System.Data.Common.DataColumnMapping("RegionID", "RegionID"),
																																																			new System.Data.Common.DataColumnMapping("Region", "Region")})});
        // 
        // sqlCommand2
        // 
        this.sqlCommand2.CommandText = @"SELECT Cities.ID AS CityID, Cities.City, StateProvinces.ID AS StateProvinceID, StateProvinces.StateProvince, Countries.ID AS CountryID, Countries.Country, Regions.ID AS RegionID, Regions.Region FROM Cities INNER JOIN StateProvinces ON StateProvinces.ID = Cities.StateProvinceID INNER JOIN Countries ON StateProvinces.CountryID = Countries.ID INNER JOIN Regions ON Countries.RegionID = Regions.ID WHERE (Cities.ID = @CityID)";
        this.sqlCommand2.Connection = CommonFunctions.GetConnection();
        this.sqlCommand2.Parameters.Add(new System.Data.SqlClient.SqlParameter("@CityID", System.Data.SqlDbType.Int, 4, "CityID"));
        // 
        // FullLocationSet2
        // 
        this.FullLocationSet2.DataSetName = "FullLocationDataset";
        this.FullLocationSet2.Locale = new System.Globalization.CultureInfo("en-US");
        // 
        // FullLocationSet3
        // 
        this.FullLocationSet3.DataSetName = "FullLocationDataset";
        this.FullLocationSet3.Locale = new System.Globalization.CultureInfo("en-US");

        // 
        // EmailsAdapter
        // 
        this.EmailsAdapter.SelectCommand = this.sqlSelectCommand33;
        this.EmailsAdapter.TableMappings.AddRange(new System.Data.Common.DataTableMapping[] {
																								new System.Data.Common.DataTableMapping("Table", "Emails", new System.Data.Common.DataColumnMapping[] {
																																																		  new System.Data.Common.DataColumnMapping("ID", "ID"),
																																																		  new System.Data.Common.DataColumnMapping("PropertyID", "PropertyID"),
																																																		  new System.Data.Common.DataColumnMapping("DateTime", "DateTime"),
																																																		  new System.Data.Common.DataColumnMapping("ContactName", "ContactName"),
																																																		  new System.Data.Common.DataColumnMapping("ContactEmail", "ContactEmail"),
																																																		  new System.Data.Common.DataColumnMapping("ContactTelephone", "ContactTelephone"),
																																																		  new System.Data.Common.DataColumnMapping("ArrivalDate", "ArrivalDate"),
																																																		  new System.Data.Common.DataColumnMapping("DepartureDate", "DepartureDate"),
																																																		  new System.Data.Common.DataColumnMapping("Nights", "Nights"),
																																																		  new System.Data.Common.DataColumnMapping("Adults", "Adults"),
																																																		  new System.Data.Common.DataColumnMapping("Children", "Children"),
																																																		  new System.Data.Common.DataColumnMapping("Telephone", "Telephone"),
																																																		  new System.Data.Common.DataColumnMapping("Telephone2", "Telephone2"),
																																																		  new System.Data.Common.DataColumnMapping("Notes", "Notes"),
																																																		  new System.Data.Common.DataColumnMapping("Email", "Email"),
																																																		  new System.Data.Common.DataColumnMapping("IfCustom", "IfCustom")})});
        // 
        // sqlSelectCommand3
        // 
        this.sqlSelectCommand33.CommandText = "SELECT ID, PropertyID, DateTime, ContactName, ContactEmail, ContactTelephone, Arr" +
            "ivalDate, DepartureDate, Nights, Adults, Children, Telephone, Telephone2, Notes," +
            " Email, IfCustom FROM Emails";
        this.sqlSelectCommand33.Connection = CommonFunctions.GetConnection();
        // 
        // EmailsSet
        // 
        this.EmailsSet.DataSetName = "EmailsDataset";
        this.EmailsSet.Locale = new System.Globalization.CultureInfo("en-US");
        ((System.ComponentModel.ISupportInitialize)(this.EmailsSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.PropertiesFullSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.PhotosSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.ExtraPhotosSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.AmenitiesSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.PropertyViewsSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.PaymentMethodsSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.RatesSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.RoomsFurnitureSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.AttractionsDistancesSet)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet1)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet2)).EndInit();
        ((System.ComponentModel.ISupportInitialize)(this.FullLocationSet3)).EndInit();

    }
    #endregion

    protected void ApproveButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("ApproveProperty.aspx?UserID=" + userid.ToString() +
            "&PropertyID=" + propertyid.ToString(), "Property Item"));
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("DeleteProperty.aspx?UserID=" + userid.ToString() +
            "&PropertyID=" + propertyid.ToString() + "&BackLink=" + HttpUtility.UrlEncode(backlinkurl)));
    }

    protected void SendEmailButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("SendCustomEmail.aspx?PropertyID=" + propertyid.ToString(),
            "Property Item"));
    }

    protected void CancelButton_Click(object sender, EventArgs e)
    {
        Response.Redirect(backlinkurl);
    }


    public bool EmailPresent()
    {
        System.Text.RegularExpressions.Regex regex =
            new System.Text.RegularExpressions.Regex("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$");

        return (PropertiesFullSet.Tables["Properties"].Rows[0]["Email"] is string) &&
            regex.Match((string)PropertiesFullSet.Tables["Properties"].Rows[0]["Email"]).Success;
    }
    protected void SubmitButton_Click(object sender, System.EventArgs e)
    {
        //if (txtimgcode.Text.ToLower() == Session["CaptchaImageText"].ToString().ToLower())
        //{
        //    captchapassed = true;
        //}

        if (!Page.IsValid) return;
        if (!pass_recaptcha) return;
        
        /*
        if (!User.Identity.IsAuthenticated || !AuthenticationManager.IfAuthenticated)
        {
            FormsAuthentication.SignOut();

            if (BookDBProvider.checkUserEmail(ContactEmail.Text))
            {
                Response.Redirect("/accounts/login.aspx?type=1&Em=" + ContactEmail.Text +"&ReturnUrl=" + Request.RawUrl);
            }else
            {
                Response.Redirect("/accounts/login.aspx?type=0&Name="+ContactName.Text+"&Em="+ContactEmail.Text+"&ReturnUrl=" + Request.RawUrl);
            }
        }
        */
        
        if (Page.IsValid)
        {
            string contactname =Server.HtmlEncode(ContactName.Text);
            string contactemail = Server.HtmlEncode( ContactEmail.Text);
            if (contactname == "" || contactemail == "") return;
            string arrivedate = String.Format("{0}-{1}-{2}",ArrivalYear.Text, ArrivalMonth.Text, ArrivalDay.Text);
            string phone = ContactTelephone.Text;
            int adults, children , nights, ownerid=0;
            if(!Int32.TryParse(  HowManyAdults.Text, out adults))adults=0;
            if(!Int32.TryParse(HowManyChildren.Text, out children))children=0;
            if(!Int32.TryParse(HowManyNights.Text, out nights)) nights=0;
            ownerid = BookDBProvider.getUsrIDbyProperty(propertyid);

            string comment = Comments.Text;

            UserInfo ownerinfo = BookDBProvider.getUserInfo(ownerid);
            UserInfo userinfo = BookDBProvider.getUserInfo(userid);

            //PropertyInform propinfo = BookDBProvider.getPropertyInfo(propertyid);
            PropertyDetailInfo propinfo = AjaxProvider.getPropertyDetailInfo(propertyid);

            try
            {
                using (WebClient client = new WebClient())
                {
                    string f_name="", l_name="";
                    char[] delimiterChars = { ' ', ',', '.', ':', '\t' };
                    string[] words = contactname.Split(delimiterChars);
                    if (words.Length > 1)
                    {
                        f_name = words[0]; l_name = words[1];
                    }else if (words.Length == 1)
                    {
                        f_name = words[0];
                    }

                    byte[] response =
                    client.UploadValues("https://api.madmimi.com/audience_lists/Travelers/add", new NameValueCollection()
                    {
                       { "username", "noreply@vacations-abroad.com" },
                       { "api_key", "9881316569391d3dbfba35b71670b4b2" },
                       { "email", contactemail },
                       { "first_name", f_name},
                        {"last_name", l_name }
                    });

                    //string result = System.Text.Encoding.UTF8.GetString(response);
                }
            }
            catch
            {

            }

            //   Response.Write(String.Format("{0}   {1} {2} {3}", ownerinfo.id, ownerinfo.name, ownerinfo.email, ownerinfo.lastname));
            //  Response.Write(String.Format("{0}   {1} {2} {3}", userinfo.id, userinfo.name, userinfo.email, userinfo.lastname));
            //  return;
            /*
                        BookDBProvider.sendEmailToAdmin(ownerinfo.name, ownerinfo.email,
                            contactname, contactemail, arrivedate, nights, adults, children, comment, phone, propinfo.name);

                        BookDBProvider.sendEmailToOwner(ownerinfo.name, ownerinfo.email,
                            contactname, contactemail, arrivedate, nights, adults, children, comment, phone, propinfo.name);

                        BookDBProvider.sendEmailToTraveler(userinfo.name, userinfo.email,
                            contactname, contactemail, arrivedate, nights, adults, children, comment, phone, propinfo.name);

                        BookDBProvider.sendEmailToTraveler(contactname, contactemail,
                contactname, contactemail, arrivedate, nights, adults, children, comment, phone, propinfo.name);
                */

            //adding sending email to emailquote table.
            if (BookDBProvider.addEmailQuote(contactname, contactemail, arrivedate, adults, children, comment,phone,userid,  propertyid, ownerid, nights))
            {
                
                string ownermsg_format = @"<body>
  <style>
  </style>
  <table border='0px' width='600px'>
    <tr>
      <td>
         <table  style='width:600px;'>
         	<tr>
         	  <td style='color:#000;font-size:16pt;width:300px;font-family: Verdana;'>
         	  	<b>Vacations Abroad</b>
         	  </td>
         	  <td style='color:#000;font-size:10pt;width:300px;text-align: right;font-family: Verdana;'>
         	    {0}
         	  </td>
         	</tr>
         </table>
      </td>
    </tr>
    <tr>
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;font-family: Verdana;'>
         <b>Dear {1}: You have an inquiry!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{2}' download='vacations.jpg'><img src='{2}' style='width:350px;height: 220px;' width='350' height='220' /></a>
      </td>
    </tr>
    <tr>
    	<td style='text-align: center;font-size:10pt;font-family: Verdana;'>
    	   Name of property:{3} &nbsp;&nbsp; Type of property:{4}
    	</td>
    </tr>
    <tr>
      <td style='padding: 10px;'>
        <table style='border:1px dashed #000;width:600px;font-size:12pt;'>
        	<tr>
        		<td style='padding:10px;font-family: Verdana;'>
					<a href='{5}' style='text-decoration: none;'>Property {6}</a> <br/>
					Date of Arrival: {7} <br/>
					{8} of nights <br/>
					# of Guests:  {9} Adults, {10} children <br/>
					Renter's Name: {11}<br/>
					Comments:{12}        		
        		</td>
        	</tr>
        </table>
      </td>
    </tr>
    <tr>
     <td style='padding: 15px; text-align: center;font-family: Verdana;'>
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;'>
	      <b>Login to Your Account to provide a response / quote.</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240' height='100'/></a>      
      </td>
    </tr>
  </table>
</body>
 ";

                string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", propinfo.Country, propinfo.StateProvince, propinfo.City,propinfo.ID).ToLower().Replace(" ","_");
                //string msg = String.Format(ownermsg_format, ownerinfo.name,contactemail,propinfo.Name ,String.Format("{0} Bedroom {1} in {2} {3} {4}",propinfo.NumBedrooms,propinfo.CategoryTypes,propinfo.City,propinfo.StateProvince, propinfo.Country),url,Request.UserHostAddress,contactname,contactemail,phone,arrivedate,nights,adults,children);
                string msg = String.Format(ownermsg_format, DateTime.Now.ToString("MMM d, yyyy"), ownerinfo.firstname,"https://www.vacations-abroad.com/images/"+ propinfo.FileName, propinfo.Name2, propinfo.CategoryTypes, url, propinfo.ID, arrivedate, nights, adults, children,  contactname, comment);
                //   string admin_msg = String.Format("Dear Linda. <br> The inquiry content is following. <br>The email of Traveler :{1} <br> {0}", msg, contactemail);
                //string admin_msg = String.Format("Dear Linda. <br> The inquiry content is following. <br>The email of Traveler :{1} <br> {0}", msg, contactemail);


                BookDBProvider.SendEmail(ownerinfo.email,String.Format("{0} {1},Reservation for {2}",  ownerinfo.firstname,ownerinfo.lastname, arrivedate) , msg);


                //Sending email to traveler
                string travelermsg_format = @"<body>
  <table border='0px' width='600px'>
    <tr>
      <td>
         <table  style='width:600px;'>
         	<tr>
         	  <td style='color:#000;font-size:16pt;width:300px;font-family: Verdana;'>
         	  	<b>Vacations Abroad</b>
         	  </td>
         	  <td style='color:#000;font-size:10pt;width:300px;text-align: right;font-family: Verdana;'>
         	    {0}
         	  </td>
         	</tr>
         </table>
      </td>
    </tr>
    <tr>
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;font-family: Verdana;'>
         <b>Dear {1}: Thanks for your inquiry!<b>
      </td>
    </tr>
    <tr>
      <td style='padding:5px 0px;font-size:12pt;font-family: Verdana;'>
        This is a copy of the inquiry you sent to <a href='{2}'>property {3}</a>-  listed on Vacations-Abroad.com
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{4}' download='vacations.jpg'><img src='{4}' style='width:350px;height: 220px;' width='350' height='220' /></a>
      </td>
    </tr>
    <tr>
    	<td style='text-align: center;font-size:10pt;font-family: Verdana;'>
    	   {5} Name: {6}
    	</td>
    </tr>
    <tr>
      <td style='padding: 10px;'>
        <table style='border:1px dashed #000;width:600px;font-size:12pt;'>
            <tr><td>Details of Your Inquiry:</td></tr>
        	<tr>
        		<td style='padding:10px;font-family: Verdana;'>
                    Name: {7} <br/>
                    Email: {8} <br/>
					Date of Arrival: {9} <br/>
					# of nights: {10} <br/>
					# of Guests:  {11} Adults, {12} children <br/>
					Telephone: {13}<br/>
					Comments:{14}        		
        		</td>
        	</tr>
        </table>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240' height='100'/></a>      
      </td>
    </tr>
  </table>
</body>
 ";

                string traveler_msg = String.Format(travelermsg_format, DateTime.Now.ToString("MMM d, yyyy"), contactname, url, propinfo.ID, "https://www.vacations-abroad.com/images/" + propinfo.FileName, propinfo.CategoryTypes , propinfo.Name2, contactname,contactemail, arrivedate, nights, adults, children,phone,  comment);
                BookDBProvider.SendEmail(contactemail, String.Format("You've sent an inquiry for property {0} : Vacations-abroad.com", propinfo.ID), traveler_msg);


                // BookDBProvider.SendEmail("prop@vacations-abroad.com", String.Format("{0} has received an inquiry for {1}",ownerinfo.name,url), admin_msg);
                string adminmsg_format = @"<body>
  <style>
  </style>
  <table border='0px' width='600px'>
    <tr>
      <td>
         <table  style='width:600px;'>
         	<tr>
         	  <td style='color:#000;font-size:16pt;width:300px;font-family: Verdana;'>
         	  	<b>Vacations Abroad</b>
         	  </td>
         	  <td style='color:#000;font-size:10pt;width:300px;text-align: right;font-family: Verdana;'>
         	    {0}
         	  </td>
         	</tr>
         </table>
      </td>
    </tr>
    <tr>
      <td bgcolor='#4472c4' style='border:1px solid #2f528f;text-align:center;padding: 10px 0px;color:#fff;font-size:12pt;font-family: Verdana;'>
         <b>Dear {1}: You have an inquiry!<b>
      </td>
    </tr>
    <tr>
      <td style='text-align: center;padding: 10px 0px;'>
        <a href='{2}' download='vacations.jpg'><img src='{2}' style='width:350px;height: 220px;' width='350' height='220' /></a>
      </td>
    </tr>
    <tr>
    	<td style='text-align: center;font-size:10pt;font-family: Verdana;'>
    	   Name of property:{3} &nbsp;&nbsp; Type of property:{4}
    	</td>
    </tr>
    <tr>
      <td style='padding: 10px;'>
        <table style='border:1px dashed #000;width:600px;font-size:12pt;'>
        	<tr>
        		<td style='padding:10px;font-family: Verdana;'>
					<a href='{5}' style='text-decoration: none;'>Property {6}</a> <br/>
					Date of Arrival: {7} <br/>
					{8} of nights <br/>
					# of Guests:  {9} Adults, {10} children <br/>
					Renter's Name: {11}<br/>
                    Traveler's Name: {14} <br/>
                    Traveler's Email: {15} <br/>
                    Phone Number:{13} <br/>
					Comments:{12}        		
        		</td>
        	</tr>
        </table>
      </td>
    </tr>
    <tr>
     <td style='padding: 15px; text-align: center;font-family: Verdana;'>
   	    <a href='https://www.vacations-abroad.com/userowner/listings.aspx' style='padding:3px 20px;border:1px solid #000;cursor: pointer;color: #f86308;text-decoration: none;font-size:12pt;'>
	      <b>Login to Your Account to provide a response / quote.</b>
	    </a> 
     </td>
    </tr>
    <tr>
      <td style='text-align: center;'>
        <a href='https://www.vacations-abroad.com/images/elogo.jpg' download='vacations.jpg'><img src='https://www.vacations-abroad.com/images/elogo.jpg' style='width:240px;height: 100px;' width='240' height='100'/></a>      
      </td>
    </tr>
  </table>
</body>
 ";
                string adminmsg = String.Format(adminmsg_format, DateTime.Now.ToString("MMM d, yyyy"), ownerinfo.firstname, "https://www.vacations-abroad.com/images/" + propinfo.FileName, propinfo.Name2, propinfo.CategoryTypes, url, propinfo.ID, arrivedate, nights, adults, children, contactname, comment, phone, contactname, contactemail);
                BookDBProvider.SendEmail("linda@vacations-abroad.com", String.Format("{0} has received an inquiry for {1}", ownerinfo.name, url), adminmsg, contactemail);

              //  BookDBProvider.sendEmailToTraveler(contactname, contactemail,contactname, contactemail, arrivedate, nights, adults, children, comment, phone, propinfo.Name);

            }

        }
    }
    protected void ClearButton_Click(object sender, System.EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("SendEmail.aspx?" + Request.QueryString.ToString()));
    }
    private string First(string str, int numchars)
    {
        if (str.Length <= numchars)
            return str;
        else
            return str.Substring(0, numchars);
    }
    
    #region Calendar Section
    private void PopulateCal()
    {
        DBConnection obj = new DBConnection();
        List<DateTime> DatesTaken = new List<DateTime>();

        DataTable dt = new DataTable();
        dt = VADBCommander.PropertyAvailDatesByProperty(Request.QueryString["PropertyID"].ToString());

        foreach (DataRow row in dt.Rows)
        {
            DatesTaken.Add(Convert.ToDateTime(row["PropertyDates"].ToString()));
        }
        Session["DatesTaken"] = DatesTaken;

        Calendar2.SelectedDate = DateTime.Now.AddMonths(1);
        Calendar2.VisibleDate = Calendar2.SelectedDate;

        Calendar3.SelectedDate = DateTime.Now.AddMonths(2);
        Calendar3.VisibleDate = Calendar3.SelectedDate;
        Calendar4.SelectedDate = DateTime.Now.AddMonths(3);
        Calendar4.VisibleDate = Calendar4.SelectedDate;

        Calendar5.SelectedDate = DateTime.Now.AddMonths(4);
        Calendar5.VisibleDate = Calendar5.SelectedDate;
        Calendar6.SelectedDate = DateTime.Now.AddMonths(5);
        Calendar6.VisibleDate = Calendar6.SelectedDate;
        Calendar7.SelectedDate = DateTime.Now.AddMonths(6);
        Calendar7.VisibleDate = Calendar7.SelectedDate;
        Calendar8.SelectedDate = DateTime.Now.AddMonths(7);
        Calendar8.VisibleDate = Calendar8.SelectedDate;

        Calendar9.SelectedDate = DateTime.Now.AddMonths(8);
        Calendar9.VisibleDate = Calendar9.SelectedDate;
        Calendar10.SelectedDate = DateTime.Now.AddMonths(9);
        Calendar10.VisibleDate = Calendar10.SelectedDate;
        Calendar11.SelectedDate = DateTime.Now.AddMonths(10);
        Calendar11.VisibleDate = Calendar11.SelectedDate;
        Calendar12.SelectedDate = DateTime.Now.AddMonths(11);
        Calendar12.VisibleDate = Calendar12.SelectedDate;
    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        List<DateTime> DatesTaken = (List<DateTime>)Session["DatesTaken"];
        if (DatesTaken.Contains(e.Day.Date))
        {
            e.Cell.BackColor = System.Drawing.Color.Red;
            e.Cell.ForeColor = System.Drawing.Color.White;
        }

        if (e.Day.IsOtherMonth == true)
        {

            e.Cell.Text = "";
            e.Cell.BackColor = System.Drawing.Color.White;
        }
        e.Cell.Text = e.Day.DayNumberText;

    }
    #endregion

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
       // Image1.ImageUrl = "http://www.vacations-abroad.com/captcha/CImage.aspx";
    }

    public string GetImage(int id)
    {
        string result = "<li></li>";
        if (PhotosSet.Tables["PropertyPhotos"].Rows.Count > id)
        {
            //result = "<li><img src=\"" + ConfigurationManager.AppSettings["ImagesVirtualLocation"] + PhotosSet.Tables["PropertyPhotos"].Rows[id]["FileName"].ToString() 
            //    + "\" width = \"" + PhotosSet.Tables["PropertyPhotos"].Rows[id]["Width"] + "\" " + "height = \""
            //    + PhotosSet.Tables["PropertyPhotos"].Rows[id]["Height"].ToString() + "\" /></li>";
        }
        return result;
    }
}
