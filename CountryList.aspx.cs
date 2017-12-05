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
using System.Net;
using System.IO;
using System.Text;
using Newtonsoft.Json;

/*
public class Location
{
    public string title;
    public double lat;
    public double lng;
    public string description;
}
*/
public partial class CountryList : CommonPage
{
   
    public string region;
    public string country;
    public string stateprovince;
    public string cities;
    public string County;
    public string altTag;

    private int regionid = -1;
    private int countryid = -1;
    private int stateprovinceid = -1;

    //For country title and description
    protected DataSet ds_allinfo;

    
    //For maping.
    protected DataSet ds_citylocations;
    protected DataSet ds_airports;
    protected string markers="{}";
    protected string airports_markers = "{}";
    protected string str_meta ,str_keyword = "";
    protected void Page_Load(object sender, System.EventArgs e)
    {

        if ((Request.Params["CountryID"] != null) && (Request.Params["CountryID"].Length > 0))
            try
            {
                countryid = Convert.ToInt32(Request.Params["CountryID"]);
            }
            catch (Exception)
            {
            }

        if (countryid == -1)
            Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"));

        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@countryid", countryid));//[uspGetCountry_Prop_StateInfo]
        ds_allinfo = BookDBProvider.getDataSet("uspGetCountry_Prop_StateInfo", param);
        
        if(ds_allinfo.Tables.Count != 4)
        {
            Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"));
        }

        region = ds_allinfo.Tables[0].Rows[0]["Region"].ToString();
        country = ds_allinfo.Tables[0].Rows[0]["Country"].ToString();

        string vText = "Vacations-abroad.com is a " + country + " accommodation directory of " + country + " rentals by owner and privately owned " + country + " holiday accommodation. Our short term " + country + " rentals include luxury " +
                          country + " holiday homes, " + country + " vacation homes and " + country + " vacation home rentals which are perfect for group or family vacation rentals in " + country + " " + region;

        if (!IsPostBack)
        {
            //For country description
            lblCountryInfo.Text = ds_allinfo.Tables[0].Rows[0]["countryText"].ToString().Replace(Environment.NewLine, "<br />");
            txtCountryText.Text = ds_allinfo.Tables[0].Rows[0]["countryText"].ToString().Replace("<br />", Environment.NewLine);

            if (lblCountryInfo.Text == null || lblCountryInfo.Text == "")
            {
                lblCountryInfo.Text = vText;
                txtCountryText.Text = vText;
            }

            lblInfo2.Text = ds_allinfo.Tables[0].Rows[0]["countryText2"].ToString().Replace(Environment.NewLine, "<br />");
            if (string.IsNullOrEmpty(lblInfo2.Text) || lblInfo2.Text == "")
            {
                OrangeTitle.Visible = false;
            }
            txtCountryText2.Text = ds_allinfo.Tables[0].Rows[0]["countryText2"].ToString().Replace("<br />", Environment.NewLine);
        }



        /*    /////// common for postback and ! postback
            List<string> vList = new List<string>();
            DataTable dt = new DataTable();
            DataFunctions obj = new DataFunctions();
            DataTable dtCategories = new DataTable();
            DBConnection obj1 = new DBConnection();

            try
            {
                if (!IsPostBack)
                {
                    dt = obj.PropertiesByCase(vList, countryid, "Country");
                    DataView dv = dt.DefaultView;
                    dv.Sort = "category asc";
                    dt = dv.ToTable();
                    Session["dt"] = dt;
                     int[] i = new int[4];
                    i = FindNumAmenities(dt);

                    dtCategories = obj.FindNumCategories(dt);
                    DataView dvMax = dtCategories.DefaultView;
                    dvMax.Sort = "count desc";
                    DataTable dtMax = dvMax.ToTable();
                    int vCategoryCount = 0;
                    string firstCategory = "";
                    string subCategory = "";
                    foreach (DataRow row in dtMax.Rows)
                    {
                        int index = dtMax.Rows.IndexOf(row);
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

                        //dtlStates.DataSource = dtCategories;
                        //dtlStates.DataBind();
                    }
                    //numbedrooms filter
                    dtCategories = obj.FindNumBedrooms(dt);
                    int vBedCount = 0;
                    foreach (DataRow row in dtCategories.Rows)
                    {
                        vBedCount += Convert.ToInt32(row["count"]);
                    }

                    Page page = (Page)HttpContext.Current.Handler;
                    if (Request.QueryString["category"] != null)
                    {
                        Response.Clear();
                        Response.StatusCode = 404;
                        Response.End();
                    }
                    if (dt.Rows.Count <= 10)
                    {
                        //Implement 404 logic less then 10 property with Prorerty in URL - Develop By Nimesh Sapovadiya
                        if(Request.QueryString["category"] != null)
                        {
                            Response.Clear();
                            Response.StatusCode = 404;
                            Response.End(); 
                        }
                        string dispString = "";
                        string dispString2 = "";
                        if (subCategory.Contains("_"))
                        {
                            string[] strSplit = subCategory.Split('_');
                            dispString = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                        }
                        else
                        {
                            dispString = UppercaseFirst(subCategory) + "s";
                        }
                        firstCategory = dt.Rows[0]["category"].ToString();
                        if (firstCategory.Contains("_"))
                        {
                            string[] strSplit = firstCategory.Split('_');
                            dispString2 = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                        }
                        else
                        {
                            dispString2 = UppercaseFirst(firstCategory) + "s";
                        }

                        altTag = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals";
                        ltrH11.Text = char.ToUpper(country[0]) + country.Substring(1) + " Vacations";
                        hyplnkBackLink.NavigateUrl = "/" + region.ToLower().Replace(" ", "_")+"/default.aspx";
                        ltrBackText.Text = region + "<<";
                hyplnkAllProps.NavigateUrl = "/" + country.ToLower().Replace(" ", "_") + "/countryproperties.aspx";
                        ltrAllProps.Text = " View all " + char.ToUpper(country[0]) + country.Substring(1) + " properties";
                        string scountry=char.ToUpper(country[0]) + country.Substring(1);
                        country = scountry;
                        ltrHeading.Text = scountry + " Vacation Rentals and Boutique Hotels";

                        page.Title = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals, Boutique Hotels | Vacations Abroad";

                       string tempcountry1 = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") +
                                                   "/default.aspx";

                      /*  HtmlMeta description = new HtmlMeta();
                        description.Name = "description";
                        description.Content = "Plan your next " + char.ToUpper(country[0]) + country.Substring(1) + " vacation: where to stay and places to visit ";
                        head.Controls.Add(description);

                    }
                    else
                    {

                        if (Request.QueryString["category"] != null)
                        {
                            firstCategory = Convert.ToString(Request.QueryString["category"]);
                        }
                        {
                            string dispString = "";
                            string dispString2 = "";
                            if (subCategory.Contains("_"))
                            {
                                string[] strSplit = subCategory.Split('_');
                                dispString = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1])+"s";
                            }
                            else
                            {
                                dispString = UppercaseFirst(subCategory) + "s";
                            }
                            if (firstCategory.Contains("_"))
                            {
                                string[] strSplit = firstCategory.Split('_');
                                dispString2 = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                            }
                            else
                            {
                                dispString2 = UppercaseFirst(firstCategory) + "s";
                            }
                            altTag = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals";
                            ltrH11.Text = char.ToUpper(country[0]) + country.Substring(1) + " Vacations";
                            hyplnkBackLink.NavigateUrl = "/" + region.ToLower().Replace(" ", "_")+"/default.aspx";
                            ltrBackText.Text = region + " Vacations <<";
                hyplnkAllProps.NavigateUrl = "/" + country.ToLower().Replace(" ", "_") + "/countryproperties.aspx";
                ltrAllProps.Text = " View all " + char.ToUpper(country[0]) + country.Substring(1) + " properties";
                            string scountry = char.ToUpper(country[0]) + country.Substring(1);
                            country = scountry;
                            ltrHeading.Text = scountry + " Vacation Rentals and Boutique Hotels"; 

                            //ltrCountryThing.Text = char.ToUpper(country[0]) + country.Substring(1);
                            page.Title = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals, Boutique Hotels | Vacations Abroad";

                        }
                        if (firstCategory == "bandb")
                        {
                            firstCategory = "B&B";
                        }


                        DataTable dtCategory = dt.Clone();
                        foreach (DataRow dr in dt.Rows)
                        {
                            string vTemp = dr["Category"].ToString(); 
                            if (vTemp.ToLower().Replace(" ", "").Trim() == firstCategory.ToLower().Replace("_", " ").Replace(" ", ""))
                            {
                                subCategory = dr["SubCategory"].ToString();
                                dtCategory.ImportRow(dr);
                            }
                        }
                        DataView dv1 = dtCategory.DefaultView;
                        dv1.Sort = "MinNightRate desc";

                        if (Request.QueryString["category"] != null)
                        {
                            string dispString = "";
                            if (firstCategory.Contains("_"))
                            {
                                string[] strSplit = firstCategory.Split('_');
                                dispString = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1])+"s";
                            }
                            else
                            {
                                dispString = UppercaseFirst(firstCategory) + "s";
                            }
                            ltrH11.Text = char.ToUpper(country[0]) + country.Substring(1) + " Vacations";
                            page.Title = char.ToUpper(country[0]) + country.Substring(1) + "Vacation Rentals, Boutique Hotels | Vacations Abroad";
                            altTag = subCategory + " in " + country;
                            Label3.Text = altTag;
                        }
                        else
                        {
                            string dispString = "";
                            string dispString2 = "";
                            if (subCategory.Contains("_"))
                            {
                                string[] strSplit = subCategory.Split('_');
                                dispString = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                            }
                            else
                            {
                                dispString = UppercaseFirst(subCategory) + "s";
                            }
                            if (firstCategory.Contains("_"))
                            {
                                string[] strSplit = firstCategory.Split('_');
                                dispString2 = UppercaseFirst(strSplit[0]) + " " + UppercaseFirst(strSplit[1]) + "s";
                            }
                            else
                            {
                                dispString2 = UppercaseFirst(firstCategory) + "s";
                            }
                            altTag = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals";
                            ltrH11.Text = char.ToUpper(country[0]) + country.Substring(1) + " Vacations";
                            page.Title = char.ToUpper(country[0]) + country.Substring(1) + " Vacation Rentals, Boutique Hotels | Vacations Abroad";

                        }
                        string tempcountry = CommonFunctions.GetSiteAddress() + "/" + country.ToLower().Replace(" ", "_") +
                                                    "/default.aspx";


                    }

                    ViewState["firstCategory"] = firstCategory;
                    DataTable dt1 = new DataTable();
                    try
                    {
                        dt1 = VADBCommander.CountryTextInd(countryid.ToString(), firstCategory);
                    }
                    catch (Exception ex) { lblInfo.Text = ex.Message; }

                    string vText = "Vacations-abroad.com is a " + country + " accommodation directory of " + country + " rentals by owner and privately owned " + country + " holiday accommodation. Our short term " + country + " rentals include luxury " +
                   country + " holiday homes, " + country + " vacation homes and " + country + " vacation home rentals which are perfect for group or family vacation rentals in " + country + " " + region;

                    if (dt1.Rows.Count > 0)
                    {

                        if (dt1.Rows[0]["countryText"] != null)
                        {
                            if (!IsPostBack)
                            {
                                lblCountryInfo.Text = dt1.Rows[0]["countryText"].ToString();
                                txtCountryText.Text = dt1.Rows[0]["countryText"].ToString().Replace("<br />", Environment.NewLine);
                            }
                            ////Editor.Value = dt.Rows[0]["cityText"].ToString();
                        }
                        else
                        {
                            lblCountryInfo.Text = vText;
                            txtCountryText.Text = vText;
                        }
                        if (dt1.Rows[0]["countryText2"] != null)
                        {
                            if (!IsPostBack)
                            {
                                lblInfo2.Text = dt1.Rows[0]["countryText2"].ToString();
                                if (string.IsNullOrEmpty(lblInfo2.Text) || lblInfo2.Text == "")
                                {
                                    OrangeTitle.Visible = false;
                                }
                                txtCountryText2.Text = dt1.Rows[0]["countryText2"].ToString().Replace("<br />", Environment.NewLine);
                            }
                        }
                        else
                        {
                            OrangeTitle.Visible = false;
                        }
                    }
                    else
                    {
                        lblCountryInfo.Text = vText;
                        txtCountryText.Text = vText;
                        OrangeTitle.Visible = false;
                    }
                }
            }
            catch (Exception ex) { lblInfo.Text = ex.Message; }

            DBConnection obj3 = new DBConnection();
            SqlDataReader reader = obj3.ExecuteRecordSetArtificial("SELECT Cities.* FROM Cities WHERE (Cities.StateProvinceID = " + stateprovinceid + ") " + "AND EXISTS ( SELECT * FROM Properties WHERE (Properties.IfFinished = 1) AND (Properties.IfApproved = 1) AND " + "(Properties.CityID = Cities.ID)  AND NOT EXISTS (SELECT * FROM Auctions WHERE PropertyID = Properties.ID)) ORDER " + "BY City");
            string states1 = "";
            string regionCountry = "";
            foreach (DataRow dr in MainDataSet.Tables["CountriesRegion"].Rows)
            {
                string temp = "/" + dr["Country"].ToString().ToLower().Replace(" ", "_") + "/default.aspx";
                temp = temp.ToLower();
                temp = temp.Replace(' ', '_');
                rtLow3.Text += "<li><a href=\"" + temp + "\"><span class=\"tdNoSleeps\">" + dr["Country"].ToString().Replace(" ", "&nbsp;") + ",&nbsp; </span></a></li>";
                states1 += "<a href=\"" + temp + "\"><span class=\"tdNoSleeps\" style=\"font-weight:normal;font-style:normal\">" + dr["Country"].ToString().Replace(" ", "&nbsp;") + "</span></a>, ";
                regionCountry = dr["Region"].ToString();
            }
            states1 = "";
            foreach (DataRow dr in MainDataSet.Tables["StateProvinces"].Rows)
            {
                string temp = "/" + country.ToLower().Replace(" ", "_") + "/" + dr["StateProvince"].ToString().ToLower().Replace(" ", "_") + "/default.aspx";
                states1 += "<a href=\"" + temp + "\"><span class=\"tdNoSleeps\" style=\"font-weight:normal;font-style:normal\">" + dr["StateProvince"].ToString().Replace(" ", "&nbsp;") + "</span></a>, ";
            }

            states1 = "";
            string str_states = "";

            int ind = 0;
            // string cls = " class='borderright' ";
            string cls = "border-right:1px solid #0094ff;";
            string li = "";
            foreach (DataRow dr in MainDataSet.Tables["StateProvinces"].Rows)
            {
                DataFunctions objcate = new DataFunctions();
                DataTable dt1 = new DataTable();
                dt = obj.PropertiesByCase(vList, Convert.ToInt32(dr["id"]), "State");

                //li =" style='"+ ((ind > 4) ? "border-top:0px;" : "")+ (((ind++ % 5) == 4) ? cls : "")+"'";

                string temp = "/" + country.ToLower().Replace(" ", "_") + "/" + dr["StateProvince"].ToString().ToLower().Replace(" ", "_") + "/default.aspx";
                states1 += "<li"+li +"><a href='" + temp + "' class='StateTitle'>" + dr["StateProvince"].ToString().Replace(" ", "&nbsp;") + "</a><br/> ";
                states1 += "<a href=\"" + temp + "\"><div class='drop-shadow effect4'><img width='160' height='125' src='/images/" + Convert.ToString(dt.Rows[0]["PhotoImage"]) + "' alt='" + Convert.ToString(dr["StateProvince"]) +" ' title='" + Convert.ToString(dr["StateProvince"])  + "' /></div></a></li>";
                //states1 += "<a href=\"" + temp + "\"><div class='drop-shadow effect4'><img width='160' height='125' src='/images/" + Convert.ToString(dt.Rows[0]["PhotoImage"]) + "' alt='" + Convert.ToString(dr["StateProvince"]) + " vacation rentals and boutique hotels in "+country+"' title='" + Convert.ToString(dr["StateProvince"]) + " vacation rentals and boutique hotels in " + country + "' /></div></a></li>";
                // states1 += "<a href=\"" + temp + "\"><div class='drop-shadow effect4'><img width='160' height='125' src='/images/" + Convert.ToString(dt.Rows[0]["PhotoImage"]) + "' alt='" + Convert.ToString(dr["propnum"]) + " properties in " + Convert.ToString(dr["StateProvince"]) + "' title='" + Convert.ToString(dr["propnum"]) + " properties in " + Convert.ToString(dr["StateProvince"]) + "' /></div></a></li>";
                //states1 += "<a href=\"" + temp + "\"><div class='drop-shadow effect4'><img width='160' height='125' src='/images/" + Convert.ToString(dt.Rows[0]["PhotoImage"]) + "' alt='" + Convert.ToString(dr["propnum"]) + " properties in " + Convert.ToString(dr["StateProvince"]) + "' title='" + Convert.ToString(dr["propnum"]) + " properties in " + Convert.ToString(dr["StateProvince"]) + "' /></div></a></li>";
                str_states += Convert.ToString(dr["StateProvince"]) + ", ";
                str_keyword += Convert.ToString(dr["StateProvince"]) + " " + country + ", ";
            }
            //rtLow3.Text = rtLow3.Text.Remove(rtLow3.Text.Length - 1, 1);
            rtHd3.InnerHtml = regionCountry + " Countries: ";





            Statesul.InnerHtml = states1;
            //Page.Header.Controls.Add(new LiteralControl("<link href='http://vacations-abroad.com/css/StyleSheetBig4.css' rel='stylesheet' type='text/css'></script>"));



            //For the meta tag
            str_meta = "(%number%) %country% vacation rentals and boutique hotels in %states% etc.";
            str_meta = str_meta.Replace("%country%", country).Replace("%states%", str_states).Replace("%number%", Convert.ToString(num_properties));
            str_keyword = str_keyword + "etc.";
        */
        //For meta tag
        int num_states = ds_allinfo.Tables[1].Rows.Count;
        string str_states = "";
        for (int ind_state = 0; ind_state < num_states; ind_state++)
        {
            string comma = (ind_state == (num_states - 1)) ? "" : ", ";
            DataRow row = ds_allinfo.Tables[1].Rows[ind_state];
            str_states += (row["StateProvince"].ToString() + comma);
            str_keyword += String.Format("{0} {1}{2}", row["StateProvince"].ToString(), country, comma);
        }

        string num_properties = ds_allinfo.Tables[3].Rows[0][0].ToString();
        if (num_states == 0) Response.Redirect("/default.aspx");
        // str_meta = String.Format("({0}) {1} vacation rentals and boutique hotels in {2} etc.", num_properties, country, str_states);
        str_meta = String.Format("Explore {0} while staying in our vacation rentals and boutique hotels.", country);
        str_keyword = str_keyword + " etc.";


        //For google map
        List<SqlParameter> sparam = new List<SqlParameter>();
            sparam.Add(new SqlParameter("@countryid", countryid));
            ds_citylocations = BookDBProvider.getDataSet("uspGetCityLocationListbyCountry", sparam);

            markers = CommonProvider.getMarkersJsonString(ds_citylocations);
        sparam.Clear();
            sparam.Add(new SqlParameter("@country", country));
            ds_airports = BookDBProvider.getDataSet("usp_list_airports_bycountry", sparam);
            airports_markers = CommonProvider.getMarkersJsonString(ds_airports,"airport");

    }
    static string UppercaseFirst(string s)
    {
        if (string.IsNullOrEmpty(s))
        {
            return string.Empty;
        }
        char[] a = s.ToCharArray();
        a[0] = char.ToUpper(a[0]);
        return new string(a);
    }

    //For adminstrator text modification
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        string strCoutryText2 = txtCountryText2.Text.Replace(Environment.NewLine, "<br />");

        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@countryid", countryid));//[uspUpdateCountryText]
        param.Add(new SqlParameter("@text", strCoutryText2));
        param.Add(new SqlParameter("@index", 1));

        BookDBProvider.getDataSet("uspUpdateCountryText", param);

        lblInfo2.Text = txtCountryText2.Text.Replace(Environment.NewLine, "<br />");
     }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
 
        string strCountryText = txtCountryText.Text.Replace(Environment.NewLine, "<br />");
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@countryid", countryid));//[uspUpdateCountryText]
        param.Add(new SqlParameter("@text", strCountryText));
        param.Add(new SqlParameter("@index", 0));

        BookDBProvider.getDataSet("uspUpdateCountryText", param);

        //For country description
        lblCountryInfo.Text = txtCountryText.Text.Replace(Environment.NewLine, "<br />");
    }


}
