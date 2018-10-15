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
        
        if(ds_allinfo.Tables.Count != 5)
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
        num_states = Math.Min(ds_allinfo.Tables[4].Rows.Count, 4);
        string top_states = "";
        for(int ind_state = 0; ind_state<num_states; ind_state++)
        {
            top_states = ", " + ds_allinfo.Tables[4].Rows[ind_state]["StateProvince"].ToString();
        }
        if (top_states.Length > 1) top_states = top_states.Substring(2);
        str_meta = String.Format("Plan your 2019 {0} Vacation and book the perfect boutique hotel or vacation rental in {1} plus other locations.", country, top_states);
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
