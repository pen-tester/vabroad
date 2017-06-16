
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Newtonsoft.Json;

public partial class StateProvinceList : CommonPage
{
    public int stateprovinceid = 0;

    public int[] bedroominfo = new int[4];
    public int[] amenity_id = { 8, 33, 1, 11, 0 };
    public int[] amenity_nums = new int[5];
    public int[] proptypeinfo = { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 };
    public string newdescription;

    // public string[] str_propcate = { "Chalet", "Apartment", "Villa", "Hotel", "Cottage", "Boat", "Castle", "B&B", "Guesthouse", "Farmhouse", "Display All" };
    // public int[] prop_typeval = { 17, 4, 1, 2, 9, 15, 16, 5, 11, 13, 0 };
    public string[] str_propcate = { "Vacation Rentals", "Hotels, Resorts & Guesthouses", "All" };
    public int[] prop_typeval = { 1, 2, 0 };
    public int[] prop_nums = new int[3];
    public int[] bedroom_id = { 1, 2, 3, 0 };
    public int[] sort_id = { 1, 2, 0 };
    public string[] min_rentaltypes = { "None", "2 Nights", "3 Nights", "1 Week", "2 Weeks", "Monthly", "1 Night" };
    public int[] property_typeval = { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 };

    public int[] filtered_amenity = { 1, 3, 11, 12, 46, 8, 33, 4, 14, 47, 43, 5 };

    public int rproptype_id, rbedroom_id, ramenity_id, rsort_id, pagenum;
    public string meta_str = "";
    protected string markers = "[]";

    protected CountryInfoWithCityID countryinfo;

    protected DataSet ds_PropList, ds_citylocations;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        //Check the state province id;
        if(!Int32.TryParse(Request["StateProvinceID"].ToString(),out stateprovinceid)) stateprovinceid = -1;
        if (stateprovinceid == -1) Response.Redirect("/internalerror.aspx");

        List<SqlParameter> sparam = new List<SqlParameter>();
        sparam.Add(new SqlParameter("@stateid", stateprovinceid));

        //Get the step box value
        countryinfo = CommonProvider.ConvertToClassFromDataSet<CountryInfoWithCityID>(BookDBProvider.getDataSet("uspGetCountryInfoWithStateID", sparam));
        str_propcate[0] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[0]);
        str_propcate[1] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[1]);
        
        List<SqlParameter> numparam = new List<SqlParameter>();
        for (int i = 0; i < 4; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@roomnum", i));
            bedroominfo[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }
            
        for (int i = 0; i < 5; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@amenityid", amenity_id[i]));
            amenity_nums[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }

        for (int i = 0; i < 3; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@proptype", prop_typeval[i]));
            prop_nums[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }

        //For H1 title, state province text, links
        hyperRegion.NavigateUrl = "/" + countryinfo.Region.ToLower().Replace(" ", "_") + "/default.aspx";
        hyplnkCountryBackLink.NavigateUrl = "/" + countryinfo.Country.ToLower().Replace(" ", "_") + "/default.aspx";

        ltrH1.Text = countryinfo.City + " Vacation Rentals and " + countryinfo.City + " Hotels";
        lblcityInfo.Text = Server.HtmlDecode(countryinfo.CityText);
        if (countryinfo.CityText == null || countryinfo.CityText == "")
        {
            lblcityInfo.Text = String.Format("Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}", countryinfo.City, countryinfo.Country);
        }

        //For stepbox radio button value, description text
        if (!IsPostBack)
        {
            txtCityText.Text = Server.HtmlDecode(countryinfo.CityText).Replace("<br />", Environment.NewLine);
            txtCityText2.Text = Server.HtmlDecode(countryinfo.CityText2).Replace("<br />", Environment.NewLine);
            //txtCityText2.Text = countryinfo.CityText2;
            rproptype_id = 0;
            rbedroom_id = 0;
            ramenity_id = 0;
            rsort_id = 1;
            pagenum = 0;
        }
        else
        {
            rproptype_id = Int32.Parse(Request.Form["proptype"]);
            rbedroom_id = Int32.Parse(Request.Form["roomnums"]);
            ramenity_id = Int32.Parse(Request.Form["amenitytype"]);
            rsort_id = Int32.Parse(Request.Form["pricesort"]);
            pagenum = Int32.Parse(Request.Form["pagenums"]);

        }

        //Get the property list for the state province

        List<SqlParameter> dsparam = new List<SqlParameter>();
        dsparam.Add(new SqlParameter("@stateid", stateprovinceid));
        dsparam.Add(new SqlParameter("@proptype", rproptype_id));
        dsparam.Add(new SqlParameter("@roomnum", rbedroom_id));
        dsparam.Add(new SqlParameter("@amenityid", ramenity_id));
        dsparam.Add(new SqlParameter("@ratesort", rsort_id));
        ds_PropList = BookDBProvider.getDataSet("uspGetStatePropListByCondition",dsparam);

        //Get the city location info
        List<SqlParameter> param = new List<SqlParameter>();

        param.Clear();
        param.Add(new SqlParameter("@stateid", stateprovinceid));
        param.Add(new SqlParameter("@proptype", rproptype_id));
        param.Add(new SqlParameter("@roomnum", rbedroom_id));
        param.Add(new SqlParameter("@amenityid", ramenity_id));
        ds_citylocations = BookDBProvider.getDataSet("uspGetCityLocationListbyCondition", param);
        markers = CommonProvider.getMarkersJsonString(ds_citylocations);

        lblInfo2.Text = countryinfo.CityText2;
        /*

            StateProvincesAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(), "SELECT StateProvinces.* " +
                    "FROM StateProvinces " +
                    "WHERE (StateProvinces.CountryID = @CountryID) AND EXISTS (" +
                    " SELECT * FROM Properties INNER JOIN Cities ON Properties.CityID = Cities.ID" +
                    " WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1)" +
                    " AND (Cities.StateProvinceID = StateProvinces.ID) " +
                    " AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID)) " +
                    "ORDER BY StateProvince", SqlDbType.Int);
                CitiesAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(), String.Format(STR_SELECTCitiesFROMCitiesWHERECitiesStateProvinceID), SqlDbType.Int);

                const string STR_SELECTPropertiesInfo = "SELECT Properties.Name, Properties.NumBedrooms, Properties.NumBaths, Properties.NumSleeps, Properties.NumTVs, Properties.NumVCRs, Properties.CityID, Properties.NumCDPlayers, Properties.ID, CASE WHEN EXISTS (SELECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity = 'Beach Front')) THEN 'Beach Front' ELSE '' END AS BeachFront, CASE WHEN EXISTS (SELECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity = 'Seaside')) THEN 'Seaside' ELSE '' END AS Seaside, CASE WHEN EXISTS (SELECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity = 'Lake Front')) THEN 'Lake Front' ELSE '' END AS LakeFront, CASE WHEN EXISTS (SELECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity = 'River Front')) THEN 'River Front' ELSE '' END AS RiverFront, CASE WHEN EXISTS (SELECT * FROM PropertiesAmenities INNER JOIN Amenities ON PropertiesAmenities.AmenityID = Amenities.ID WHERE (PropertiesAmenities.PropertyID = Properties.ID) AND (Amenities.Amenity = 'Ski In Ski Out')) THEN 'Ski In Ski Out' ELSE '' END AS Ski, Cities.City, StateProvinces.StateProvince, Countries.Country, Regions.Region, MinimumNightlyRentalTypes.Name AS MinimumNightlyRental, PropertyTypes.Name AS Type FROM Properties INNER JOIN Cities ON Properties.CityID = Cities.ID INNER JOIN StateProvinces ON StateProvinces.ID = Cities.StateProvinceID INNER JOIN Countries ON StateProvinces.CountryID = Countries.ID INNER JOIN Regions ON Countries.RegionID = Regions.ID INNER JOIN Users ON Properties.UserID = Users.ID LEFT OUTER JOIN MinimumNightlyRentalTypes ON Properties.MinimumNightlyRentalID = MinimumNightlyRentalTypes.ID LEFT OUTER JOIN PropertyTypes ON Properties.TypeID = PropertyTypes.ID WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1) AND (Cities.StateProvinceID = @StateProvinceID) AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID) ORDER BY StateProvinces.StateProvince, Cities.City, Type, CASE WHEN EXISTS (SELECT * FROM Invoices WHERE (PropertyID = Properties.ID) AND (PaymentAmount >= InvoiceAmount) AND (GETDATE() <= Invoices.RenewalDate)) THEN 1 ELSE 0 END DESC, Properties.ID";
                PropertiesAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(), String.Format(STR_SELECTPropertiesInfo), SqlDbType.Int);

                AmenitiesAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(), "SELECT Amenities.ID, Amenity," +
                    " PropertiesAmenities.PropertyID " +
                    "FROM Amenities INNER JOIN PropertiesAmenities ON Amenities.ID = PropertiesAmenities.AmenityID" +
                    " INNER JOIN Properties ON PropertiesAmenities.PropertyID = Properties.ID " +
                    " INNER JOIN Cities ON Properties.CityID = Cities.ID " +
                    "WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1) AND (Cities.StateProvinceID = @StateProvinceID)" +
                    " AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID) AND (Amenities.Amenity NOT IN" +
                    " ('Lake Front', 'Beach Front', 'River Front', 'Seaside', 'Ski In Ski Out', 'TV', 'VCR', 'CD Player'))",
                    SqlDbType.Int);

                LocationAdapter = CommonFunctions.PrepareAdapter(CommonFunctions.GetConnection(), "SELECT StateProvinces.ID AS StateProvinceID," +
                    " StateProvinces.StateProvince, Countries.ID AS CountryID, Countries.Country, Regions.ID AS RegionID," +
                    " Regions.Region, stateprovinces.titleoverride, stateprovinces.descriptionoverride " +
                    "FROM StateProvinces INNER JOIN Countries ON StateProvinces.CountryID = Countries.ID" +
                    " INNER JOIN Regions ON Countries.RegionID = Regions.ID WHERE (StateProvinces.ID = @StateProvinceID)",
                    SqlDbType.Int);


                if ((Request.Params["StateProvinceID"] != null) && (Request.Params["StateProvinceID"].Length > 0))
                    try
                    {
                        stateprovinceid = Convert.ToInt32(Request.Params["StateProvinceID"]);
                    }
                    catch (Exception)
                    {
                    }
                // IF state is not found throw an error
                if (stateprovinceid == -1)
                    Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"));

                CitiesAdapter.SelectCommand.Parameters["@StateProvinceID"].Value = stateprovinceid;
                LocationAdapter.SelectCommand.Parameters["@StateProvinceID"].Value = stateprovinceid;
                PropertiesAdapter.SelectCommand.Parameters["@StateProvinceID"].Value = stateprovinceid;
                AmenitiesAdapter.SelectCommand.Parameters["@StateProvinceID"].Value = stateprovinceid;
                if (LocationAdapter.Fill(MainDataSet, "Location") > 0)
                {
                    regionid = (int)MainDataSet.Tables["Location"].Rows[0]["RegionID"];
                    countryid = (int)MainDataSet.Tables["Location"].Rows[0]["CountryID"];
                    region = (string)MainDataSet.Tables["Location"].Rows[0]["Region"];
                    country = (string)MainDataSet.Tables["Location"].Rows[0]["Country"];
                    stateprovince = (string)MainDataSet.Tables["Location"].Rows[0]["StateProvince"];
                }
                else
                    Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"));

                StateProvincesAdapter.SelectCommand.Parameters["@CountryID"].Value = countryid;
                CitiesAdapter.Fill(MainDataSet, "Cities");
                PropertiesAdapter.Fill(MainDataSet, "Properties");
                AmenitiesAdapter.Fill(MainDataSet, "Amenities");
                StateProvincesAdapter.Fill(MainDataSet, "StateProvinces");
                DBConnection objTemp = new DBConnection();
                DataTable dtTemp = new DataTable();
                try
                {
                    dtTemp = VADBCommander.CountyNamesWithProperties(Request.Params["StateProvinceID"].ToString());
                    DataTable dtCopy = dtTemp.Copy();
                    dtCopy.TableName = "dtcopy";
                    dtCopy.Namespace = "dtcopy";
                    MainDataSet.Tables.Add(dtCopy);
                    MainDataSet.Relations.Add("CitiesProperties", MainDataSet.Tables["Cities"].Columns["ID"],
                        MainDataSet.Tables["Properties"].Columns["CityID"]);
                    MainDataSet.Relations.Add("PropertiesAmenities", MainDataSet.Tables["Properties"].Columns["ID"],
                        MainDataSet.Tables["Amenities"].Columns["PropertyID"]);

                    MainDataSet.Relations.Add("CountyCities", MainDataSet.Tables["dtcopy"].Columns["ID"],
                        MainDataSet.Tables["Cities"].Columns["countyID"]);
                    LocationAdapterCountry.SelectCommand.Parameters["@CountryID"].Value = countryid;



                }
                catch (Exception ex) { lblInfo22.Text += ex.Message; }
                finally { objTemp.CloseConnection(); }

                foreach (DataRow datarow in MainDataSet.Tables["Cities"].Rows)
                    if (datarow["City"] is string)
                        cities += " " + (string)datarow["City"];

                HtmlHead head = Page.Header;



                DataBind();

                /////// common for postback and ! postback
                List<string> vList = new List<string>();
                DataTable dt = new DataTable();
                DataFunctions obj = new DataFunctions();
                DataTable dtCategories = new DataTable();
                DBConnection obj1 = new DBConnection();

                try
                {
                    Page page = (Page)HttpContext.Current.Handler;
                    if (!IsPostBack)
                    {
                        dt = obj.PropertiesByCase(vList, stateprovinceid, "State");
                        DataView dv = dt.DefaultView;
                        dv.Sort = "category asc";
                        dt = dv.ToTable();
                        Session["dt"] = dt;

                        int[] i = new int[4];
                        i = FindNumAmenities(dt);



                        //create rdo items from categories table
                        dtCategories = obj.FindNumCategories(dt);
                        int vCategoryCount = 0;
                        string firstCategory = "";
                        string subCategory = "";
                        foreach (DataRow row in dtCategories.Rows)
                        {
                            int index = dtCategories.Rows.IndexOf(row);
                            if (index == 0)
                            {
                                firstCategory = row["category"].ToString();
                                subCategory = dt.Rows[0]["SubCategory"].ToString();
                            }
                            string vTemp = row["category"].ToString() + " (" + row["count"].ToString() + ")";
                            vTemp = vTemp.Replace(" ", "&nbsp;");
                           vCategoryCount = vCategoryCount + Convert.ToInt32(row["count"].ToString());
                        }
                        if (!IsPostBack)
                        {


                        }        //numbedrooms filter
                        dtCategories = obj.FindNumBedrooms(dt);

                        int vBedCount = 0;
                        foreach (DataRow row in dtCategories.Rows)
                        {
                            vBedCount += Convert.ToInt32(row["count"]);
                        }

                            //Implement 404 logic less then 10 property with Prorerty in URL - Develop By Nimesh Sapovadiya
                            if(Request.QueryString["category"] != null)
                            {
                                Response.Clear();
                                Response.StatusCode = 404;
                                Response.End(); 
                            }
                            string dispString = "";
                            if (firstCategory.Contains("_"))
                            {
                                string[] strSplit = firstCategory.Split('_');
                                dispString = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                            }
                            else
                            {
                                dispString = UppercaseFirst(firstCategory) + "s";
                            }

                             statestr = char.ToUpper(stateprovince[0]) + stateprovince.Substring(1);
                            altTag = char.ToUpper(stateprovince[0]) + stateprovince.Substring(1) + " Vacation Rentals";
                            ltrH1.Text = char.ToUpper(stateprovince[0]) + stateprovince.Substring(1) + " Vacations";// Rentals";// And " +  dispString;
                            ltrHeading.Text = statestr + " Vacation Rentals and "+statestr+" Hotels";
                            ltrStateThing.Text = char.ToUpper(stateprovince[0]) + stateprovince.Substring(1);

                            hyplinkBackRegion.NavigateUrl = "/" + region.ToLower().ToLower().Replace(" ", "_") + "/" + "default.aspx";
                            ltrRegion.Text = region + " Vacations <<";

                            hyplnkBackLink.NavigateUrl = "/" + country.ToLower().ToLower().Replace(" ", "_") +"/" + "default.aspx";
                            ltrBackText.Text = country  + " Vacations <<";
                            //string iframe = "<iframe height='310' width='95%' frameborder='0' src='/" + country.ToLower().ToLower().Replace(" ", "_") + "/" + stateprovince.ToLower().ToLower().Replace(" ", "_") + "/maps.aspx'></iframe>";
                            //googlemap.InnerHtml = iframe;                    
                            page.Title = char.ToUpper(stateprovince[0]) + stateprovince.Substring(1) + " Vacation Rentals, Boutique Hotels | Vacations Abroad";

                            string tempcountry1 = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") + "/" + stateprovince.ToLower().Replace(" ", "_") +
                                                       "/default.aspx";

                    }

                    string vText = "Vacations-abroad.com is a " + stateprovince + " accommodation directory of " + stateprovince + " rentals by owner and privately owned " + stateprovince + " holiday accommodation. Our short term " + stateprovince + " rentals include luxury " +
                       stateprovince + " holiday homes, " + stateprovince + " vacation homes and " + stateprovince + " vacation home rentals which are perfect for group or family vacation rentals in " + stateprovince + " " + country;

                    //TOP DEFAULT TEXT
                    if (!IsPostBack)
                    {
                        txtCityText.Text = vText;
                    }
                    lblcityInfo.Text = vText;

                    //BOTTOM, NO DEFAULT TEXT                
                    dt = VADBCommander.CityTextByStateInd(stateprovinceid.ToString());

                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Rows[0]["cityText"] != null)
                        {
                            if (!IsPostBack)
                            {
                                lblcityInfo.Text = dt.Rows[0]["cityText"].ToString();
                                txtCityText.Text = Server.HtmlDecode(dt.Rows[0]["cityText"].ToString().Replace("<br />-ipx-", Environment.NewLine));
                            }

                        }
                        if (dt.Rows[0]["cityText2"] != null)
                        {
                            if (!IsPostBack)
                            {
                                lblInfo2.Text =Server.HtmlDecode( dt.Rows[0]["cityText2"].ToString());

                                if (string.IsNullOrEmpty(dt.Rows[0]["cityText2"].ToString()) || dt.Rows[0]["cityText2"].ToString() == "")
                                {
                                    OrangeTitle.Visible = false;
                                }
                                txtCityText2.Text = Server.HtmlDecode(dt.Rows[0]["cityText2"].ToString()).Replace("<br />", Environment.NewLine);
                            }
                        }
                        else
                        {
                            OrangeTitle.Visible = false;
                            ltrStateThing.Visible = false;
                        }
                    }
                    else
                    {
                        OrangeTitle.Visible = false;
                        ltrStateThing.Visible = false;
                    }

                    if (String.IsNullOrEmpty(lblcityInfo.Text))
                    {
                        //IF EMPTY VALUES OR 'DELETES' FROM ADMIN FOR TOP

                        txtCityText.Text = vText;
                        lblcityInfo.Text = vText;
                    }
                    if (Request.QueryString["Category"] != null)
                    {
                        lblInfo2.Visible = false;
                        OrangeTitle.Visible = false;
                        txtCityText.Visible = false;
                    }
                }
                catch (Exception ex) { lblInfo.Text = ex.Message; }
                rtLow3.Text = "";

                DBConnection obj3 = new DBConnection();
                SqlDataReader reader = obj3.ExecuteRecordSetArtificial("SELECT Cities.* FROM Cities WHERE (Cities.StateProvinceID = " + stateprovinceid + ") " + "AND EXISTS ( SELECT * FROM Properties WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1) AND " + "(Properties.CityID = Cities.ID)  AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID)) ORDER " + "BY City");
                foreach (DataRow dr in MainDataSet.Tables["StateProvinces"].Rows)
                {
                    string temp = CommonFunctions.GetSiteAddress() + "/" + country +
                           "/" + dr["StateProvince"].ToString() + "/default.aspx";
                    temp = temp.ToLower();
                    temp = temp.Replace(' ', '_');
                    rtLow3.Text += "<li><a href='" + temp + "'>" + dr["StateProvince"].ToString().Replace(" ", "&nbsp;") + ", </a></li>";
                }
                rtLow3.Text = rtLow3.Text;
                rtHd3.InnerHtml = country + " Regions: ";

                //add counties to right column        
                //add counties within state
                string query = "";

                dt = obj1.spGetRightSideCounties(stateprovinceid);
                if (dt.Rows.Count > 0)
                {
                    rtCountiesHd.InnerHtml = stateprovince + " Counties";
                    divCitiesRt.Text = "";
                    foreach (DataRow datarow in dt.Rows)
                    {
                        if (datarow["county"] is string)
                        {
                            string temp = CommonFunctions.GetSiteAddress() + "/" + stateprovince + "/Holiday-Rentals/" +
                                   datarow["county"].ToString() + "-Vacation_Rentals/default.aspx";
                            temp = temp.ToLower();
                            temp = temp.Replace(' ', '_');
                            divCitiesRt.Text += "<li><a href='" + temp + "'>" + datarow["county"].ToString().Replace(" ", "&nbsp;") + "</a></li> ";
                        }
                    }
                    divCitiesRt.Text = divCitiesRt.Text.Remove(divCitiesRt.Text.Length - 2, 2);
                }
                else
                {
                }

                //add counties within state                
                DataTable dtCountries = obj1.spStateProvByCountries(countryid);
                foreach (DataRow row in dtCountries.Rows)
                {
                    if (row["stateprovince"] is string)
                    {
                        string temp = CommonFunctions.GetSiteAddress() + "/" + country + "/" + row["stateprovince"].ToString() + "/default.aspx";
                        temp = temp.ToLower();
                        temp = temp.Replace(' ', '_');
                    }
                }        
                /////// common for postback and ! postback ////////
                string cities1 = "";
                string str_cities = "";

                foreach (DataRow dr in MainDataSet.Tables["Cities"].Rows)
                {
                    string temp = CommonFunctions.GetSiteAddress() + "/" + country +
                          "/"+stateprovince+"/" + dr["City"].ToString() + "/default.aspx";
                    temp = temp.ToLower();
                    temp = temp.Replace(' ', '_');
                    cities1 += "<a href='" + temp + "'><span class=\"tdNoSleeps\" style=\"font-weight:normal;font-style:normal\">" + dr["City"].ToString().Replace(" ", "&nbsp;") + "</span></a>, ";
                    str_cities += (dr["City"].ToString() + ", ");

                }





                if(str_cities.Length>1)str_cities = str_cities.Substring(0, str_cities.Length - 2);

                string tempcountry2 = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") + "/"+stateprovince.ToLower().Replace(" ", "_") +
                                                     "/default.aspx";

                string tempstate = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") +
                                                 "/" + stateprovince.ToLower().Replace(" ", "_") + "/default.aspx";
                string tempcountry3 = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") +
                                                         "/default.aspx";
                string tempregion = CommonFunctions.GetSiteAddress() + "/" + region.ToLower().Replace(" ", "_") +
                                                     "/default.aspx";
                Session["tempstate"] = stateprovince;
                Session["tempcountry"] = country;

                //FillCitiesColumn();
                /* HtmlMeta description = new HtmlMeta();

                 description.Name = "description";
                 description.Content = Description.Text.Replace("%country%", country).Replace("%stateprovince%", stateprovince).
                     Replace("%cities%", cities);
                 // Description OVER RIDE area

                 string DescripReplacement = MainDataSet.Tables["Location"].Rows[0]["descriptionoverride"].ToString();
                 if (DescripReplacement.Length > 0)
                     description.Content = DescripReplacement;
                description.Content = "Plan your next " + stateprovince + " vacation: where to stay and places to visit!";

                head.Controls.Add(description);
                /////
                List<SqlParameter> param = new List<SqlParameter>();
                param.Add(new SqlParameter("@stid", stateprovinceid));
                ds_PTypeNum = BookDBProvider.getDataSet("uspGetPropNumListbyState", param);

         ///*       if (!IsPostBack)
          //      {
                    List<SqlParameter> sparam = new List<SqlParameter>();
                    sparam.Add(new SqlParameter("@stid", stateprovinceid));
                    ds_PropList = BookDBProvider.getDataSet("uspGetStatePropList", sparam);

                     sparam.Clear();
                    sparam.Add(new SqlParameter("@stid", stateprovinceid));
                    ds_citylocations = BookDBProvider.getDataSet("uspGetCityLocationListbyCondition", sparam);

                markers = CommonProvider.getMarkersJsonString(ds_citylocations);
                // }

                if (IsPostBack)
                {
                    ptype = int.Parse(Request["ptypes"]);
                    psleep = int.Parse(Request["psleep"]);
                }

                for (int i=0; i < 4; i++)
                {
                    param.Clear();
                    param.Add(new SqlParameter("@stid", stateprovinceid));
                    param.Add(new SqlParameter("@sleep", i));
                    param.Add(new SqlParameter("@ptype", ptype));
                    DataSet ds_tmp = BookDBProvider.getDataSet("uspGetStatePropNumListbySleep",param);
                    sleeps[i] = int.Parse(ds_tmp.Tables[0].Rows[0]["Num"].ToString());
                }




                Page page1 = (Page)HttpContext.Current.Handler;


                HtmlMeta newdescription = new HtmlMeta();

                int counts = AjaxProvider.getPropertyNumsbyState(stateprovinceid);

                string str_meta = "(%counts%) %state% vacation rentals and boutique hotels in %cities%.";
                newdescription.Name = "description";
                newdescription.Content = str_meta.Replace("%state%", stateprovince ).Replace("%cities%", str_cities).Replace("%counts%", ds_PropList.Tables[0].Rows.Count.ToString());

                head.Controls.Add(newdescription);



                HtmlMeta keywords = new HtmlMeta();

                keywords.Name = "keywords";
                keywords.Content = Keywords.Text.Replace("%country%", country).Replace("%stateprovince%", stateprovince).
                    Replace("%cities%", cities);
                keywords.Content = page1.Title;
                head.Controls.Add(keywords);
               // ((System.Web.UI.WebControls.Image)Master.FindControl("Logo")).AlternateText = page1.Title;
               // Page.Header.Controls.Add(new LiteralControl("<link href='http://vacations-abroad.com/css/StyleSheetBig4.css' rel='stylesheet' type='text/css'></script>"));
               */
    }
  
    //For state province text update
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        HttpResponse.RemoveOutputCacheItem("/stateprovincelist.aspx");
        string strCityText2 =Server.HtmlEncode( txtCityText2.Text.Replace(Environment.NewLine, "<br />"));
        DataTable dt = VADBCommander.CityTextByStateInd(stateprovinceid.ToString());
        try
        {
            if (dt.Rows.Count > 0)
            {
                VADBCommander.CityText2ByStateEdit(stateprovinceid.ToString(), strCityText2);
            }
            else
            {
                VADBCommander.CityText2ByStateAdd(stateprovinceid.ToString(), strCityText2);
            }
            lblInfo2.Text = "Data saved.";
            DataTable dt4 = VADBCommander.CityTextByStateInd(stateprovinceid.ToString());
            if (dt4.Rows.Count > 0)
            {
                if (dt4.Rows[0]["cityText"] != null)
                {
                    lblcityInfo.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString());
                    txtCityText.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString().Replace("<br />-ipx-", Environment.NewLine));

                }
                if (dt4.Rows[0]["cityText2"] != null)
                {
                    lblInfo2.Text =Server.HtmlDecode( dt4.Rows[0]["cityText2"].ToString());
                    
                    if (string.IsNullOrEmpty(dt4.Rows[0]["cityText2"].ToString()) || dt4.Rows[0]["cityText2"].ToString() == "")
                    {
                        OrangeTitle.Visible = false;
                    }
                    txtCityText2.Text = Server.HtmlDecode(dt4.Rows[0]["cityText2"].ToString()).Replace("<br />", Environment.NewLine);
                }
                else
                {
                    OrangeTitle.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            lblInfo2.Text = ex.Message;
        }
        lblInfo2.ForeColor = System.Drawing.Color.Red;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        HttpResponse.RemoveOutputCacheItem("/stateprovincelist.aspx");
       string strCityText =Server.HtmlEncode( txtCityText.Text.Replace(Environment.NewLine, "<br />"));
        DataTable dt = VADBCommander.CityTextByStateInd(stateprovinceid.ToString());
        try
        {
            if (dt.Rows.Count > 0)
            {
                VADBCommander.CityTextByStateEdit(stateprovinceid.ToString(), strCityText);

            }
            else
            {
                VADBCommander.CityTextByStateAdd(stateprovinceid.ToString(), strCityText);
            }
            lblInfo.Text = "Data saved.";
            DataTable dt4 = VADBCommander.CityTextByStateInd(stateprovinceid.ToString());
            if (dt4.Rows.Count > 0)
            {
                if (dt4.Rows[0]["cityText"] != null)
                {
                    lblcityInfo.Text = dt4.Rows[0]["cityText"].ToString();
                    txtCityText.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString().Replace("<br />-ipx-", Environment.NewLine));

                }
                if (dt4.Rows[0]["cityText2"] != null)
                {
                    lblInfo2.Text = dt4.Rows[0]["cityText2"].ToString();
                    if (string.IsNullOrEmpty(dt4.Rows[0]["cityText2"].ToString()) || dt4.Rows[0]["cityText2"].ToString() == "")
                    {
                        OrangeTitle.Visible = false;
                    }
                    txtCityText2.Text =Server.HtmlDecode( dt4.Rows[0]["cityText2"].ToString().Replace("<br />", Environment.NewLine));
                }
                else
                {
                    OrangeTitle.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            lblInfo.Text = ex.Message;
        }

    }
 

}
