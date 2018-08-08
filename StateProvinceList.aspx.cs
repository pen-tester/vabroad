
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
    public string[] str_propcate = { "Vacation Rentals", "Boutique Hotels, Resorts & Guesthouses", "Display All" };
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
    protected string airport_markers = "[]";

    protected CountryInfoWithCityID countryinfo;

    protected DataSet ds_PropList, ds_citylocations, ds_statelist , ds_airports;
    protected string city_lists = "";
    protected List<string> list_city = new List<string>();

    protected DataSet ds_allinfo;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        //Check the state province id;
        if(!Int32.TryParse(Request["StateProvinceID"].ToString(),out stateprovinceid)) stateprovinceid = -1;
        if (stateprovinceid == -1) Response.Redirect("/internalerror.aspx");

        List<SqlParameter> sparam = new List<SqlParameter>();
        sparam.Add(new SqlParameter("@stateid", stateprovinceid));

        countryinfo = CommonProvider.ConvertToClassFromDataSet<CountryInfoWithCityID>(BookDBProvider.getDataSet("uspGetCountryInfoWithStateID", sparam));
        str_propcate[0] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[0]);
        str_propcate[1] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[1]);

        //For H1 title, state province text, links
        hyperRegion.NavigateUrl = "/" + countryinfo.Region.ToLower().Replace(" ", "_") + "/default.aspx";
        hyplnkCountryBackLink.NavigateUrl = "/" + countryinfo.Country.ToLower().Replace(" ", "_") + "/default.aspx";


        rproptype_id = 0;
        rbedroom_id = 0;
        ramenity_id = 0;
        rsort_id = 0;
        pagenum = 0;
        //For stepbox radio button value, description text
        if (!IsPostBack)
        {
            txtCityText.Text = Server.HtmlDecode(countryinfo.CityText).Replace("<br />", Environment.NewLine);
            txtCityText2.Text = Server.HtmlDecode(countryinfo.CityText2).Replace("<br />", Environment.NewLine);
            //txtCityText2.Text = countryinfo.CityText2;
        }
        else
        {

            /*
            rproptype_id = Int32.Parse(Request.Form["proptype"]);
            rbedroom_id = Int32.Parse(Request.Form["roomnums"]);
            ramenity_id = Int32.Parse(Request.Form["amenitytype"]);
            rsort_id = Int32.Parse(Request.Form["pricesort"]);
            pagenum = Int32.Parse(Request.Form["pagenums"]);
            */

        }


        ltrH1.Text = countryinfo.StateProvince + " Vacations";
        lblcityInfo.Text = Server.HtmlDecode(countryinfo.CityText).Replace(Environment.NewLine,"<br />");
        if (countryinfo.CityText == null || countryinfo.CityText == "")
        {
            lblcityInfo.Text = String.Format("Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}", countryinfo.City, countryinfo.Country);
            txtCityText.Text = String.Format("Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}", countryinfo.City, countryinfo.Country);
        }

        //Get the property list for the state province
        List<SqlParameter> dparam = new List<SqlParameter>();
        dparam.Add(new SqlParameter("@stateid", stateprovinceid));//[uspGetCountry_Prop_StateInfo]
        ds_allinfo = BookDBProvider.getDataSet("uspGetState_Prop_CityInfo", dparam);


        if (!IsPostBack)
        {
            if (ds_allinfo.Tables[1].Rows.Count == 0)
            {
                Response.StatusCode = 404;
               // Response.Status = "There is no state province";
                Response.End();
            }
        }

        //Get the city location info
        List<SqlParameter> param = new List<SqlParameter>();

        param.Clear();
        param.Add(new SqlParameter("@stateid", stateprovinceid));
        param.Add(new SqlParameter("@proptype", rproptype_id));
        param.Add(new SqlParameter("@roomnum", rbedroom_id));
        param.Add(new SqlParameter("@amenityid", ramenity_id));
        ds_citylocations = BookDBProvider.getDataSet("uspGetCityLocationListbyCondition", param);
        markers = CommonProvider.getMarkersJsonString(ds_citylocations);

        sparam.Clear();
        sparam.Add(new SqlParameter("@state", countryinfo.StateProvince ));
        ds_airports = BookDBProvider.getDataSet("usp_list_airports_bystate", sparam);
        airport_markers = CommonProvider.getMarkersJsonString(ds_airports, "airport");


        lblInfo2.Text = Server.HtmlDecode(countryinfo.CityText2).Replace( Environment.NewLine , "<br />");

        param.Clear();
        param.Add(new SqlParameter("@stateid", stateprovinceid));
        //For state list
        ds_statelist = BookDBProvider.getDataSet("uspGetStateNameListbyCondition", param);

        int citycount = ds_citylocations.Tables[0].Rows.Count;
        for (int stid = 0; stid < citycount; stid++)
        {
            DataRow drow = ds_citylocations.Tables[0].Rows[stid];
            string comma = (stid == (citycount - 1)) ? "" : ", ";
            city_lists += (drow["City"]+comma);
            list_city.Add(drow["City"].ToString());
        }


    }
  
    //For state province text update
    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        HttpResponse.RemoveOutputCacheItem("/stateprovincelist.aspx");
        string strCityText2 =txtCityText2.Text;
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
                    lblcityInfo.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString()).Replace(Environment.NewLine, "<br />");
                    txtCityText.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString().Replace("<br />-ipx-", Environment.NewLine));

                }
                if (dt4.Rows[0]["cityText2"] != null)
                {
                    lblInfo2.Text =Server.HtmlDecode( dt4.Rows[0]["cityText2"].ToString()).Replace(Environment.NewLine, "<br />");
                    
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
       string strCityText = txtCityText.Text;
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
                    lblcityInfo.Text = dt4.Rows[0]["cityText"].ToString().Replace(Environment.NewLine, "<br />");
                    txtCityText.Text = Server.HtmlDecode(dt4.Rows[0]["cityText"].ToString().Replace("<br />-ipx-", Environment.NewLine));

                }
                if (dt4.Rows[0]["cityText2"] != null)
                {
                    lblInfo2.Text = dt4.Rows[0]["cityText2"].ToString().Replace(Environment.NewLine, "<br />");
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
