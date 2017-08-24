
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

    protected CountryInfoWithCityID countryinfo;

    protected DataSet ds_PropList, ds_citylocations, ds_statelist;
    protected string city_lists = "";
    protected List<string> list_city = new List<string>();

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


        ltrHeading.Text = String.Format("{0} Vacation Rentals and Boutique Hotels", countryinfo.StateProvince);

        //For stepbox radio button value, description text
        if (!IsPostBack)
        {
            txtCityText.Text = Server.HtmlDecode(countryinfo.CityText).Replace("<br />", Environment.NewLine);
            txtCityText2.Text = Server.HtmlDecode(countryinfo.CityText2).Replace("<br />", Environment.NewLine);
            //txtCityText2.Text = countryinfo.CityText2;
            rproptype_id = 0;
            rbedroom_id = 0;
            ramenity_id = 0;
            rsort_id = 0;
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


        ltrH1.Text = countryinfo.StateProvince + " Vacations";
        lblcityInfo.Text = Server.HtmlDecode(countryinfo.CityText).Replace(Environment.NewLine,"<br />");
        if (countryinfo.CityText == null || countryinfo.CityText == "")
        {
            lblcityInfo.Text = String.Format("Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}", countryinfo.City, countryinfo.Country);
            txtCityText.Text = String.Format("Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}", countryinfo.City, countryinfo.Country);
        }

        //Get the step box value

        List<SqlParameter> numparam = new List<SqlParameter>();
        for (int i = 0; i < 4; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@roomnum", i));
            numparam.Add(new SqlParameter("@amenityid", ramenity_id));
            numparam.Add(new SqlParameter("@proptype", rproptype_id));
            bedroominfo[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }

        for (int i = 0; i < 5; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@roomnum", rbedroom_id));
            numparam.Add(new SqlParameter("@proptype", rproptype_id));
            numparam.Add(new SqlParameter("@amenityid", amenity_id[i]));
            amenity_nums[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }

        for (int i = 0; i < 3; i++)
        {
            numparam.Clear();
            numparam.Add(new SqlParameter("@stateid", stateprovinceid));
            numparam.Add(new SqlParameter("@proptype", prop_typeval[i]));
           // numparam.Add(new SqlParameter("@roomnum", rbedroom_id));
            //numparam.Add(new SqlParameter("@proptype", rproptype_id));
           // numparam.Add(new SqlParameter("@amenityid", ramenity_id));
            prop_nums[i] = CommonProvider.getScalarValueFromDB("uspGetStatePropNumsByCondition", numparam);
        }


        //Get the property list for the state province

        List<SqlParameter> dsparam = new List<SqlParameter>();
        dsparam.Add(new SqlParameter("@stateid", stateprovinceid));
        dsparam.Add(new SqlParameter("@proptype", rproptype_id));
        dsparam.Add(new SqlParameter("@roomnum", rbedroom_id));
        dsparam.Add(new SqlParameter("@amenityid", ramenity_id));
        dsparam.Add(new SqlParameter("@ratesort", rsort_id));
        ds_PropList = BookDBProvider.getDataSet("uspGetStatePropListByCondition",dsparam);

        if (!IsPostBack)
        {
            if (ds_PropList.Tables[0].Rows.Count == 0)
            {
                Response.StatusCode = 404;
                Response.Status = "There is no state province";
                Response.Close();
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

            /*

                    HtmlHead head = Page.Header;




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
