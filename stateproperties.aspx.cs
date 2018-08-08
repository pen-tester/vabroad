//live
using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class stateproperties : CommonPage
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

    protected DataSet ds_PropList, ds_citylocations, ds_statelist, ds_airports;
    protected string city_lists = "";
    protected List<string> list_city = new List<string>();

    protected DataSet ds_allinfo;

    protected void Page_Load(object sender, System.EventArgs e)
    {

        //Check the state province id;
        if (!Int32.TryParse(Request["StateProvinceID"].ToString(), out stateprovinceid)) stateprovinceid = -1;
        if (stateprovinceid == -1) Response.Redirect("/internalerror.aspx");


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


        List<SqlParameter> sparam = new List<SqlParameter>();
        sparam.Add(new SqlParameter("@stateid", stateprovinceid));

        countryinfo = CommonProvider.ConvertToClassFromDataSet<CountryInfoWithCityID>(BookDBProvider.getDataSet("uspGetCountryInfoWithStateID", sparam));
        str_propcate[0] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[0]);
        str_propcate[1] = String.Format("{0} {1}", countryinfo.StateProvince, str_propcate[1]);

        //For stepbox radio button value, description text
        if (!IsPostBack)
        {
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


        //Get the property list for the state province
        List<SqlParameter> dsparam = new List<SqlParameter>();
        dsparam.Add(new SqlParameter("@stateid", stateprovinceid));
        dsparam.Add(new SqlParameter("@proptype", rproptype_id));
        dsparam.Add(new SqlParameter("@roomnum", rbedroom_id));
        dsparam.Add(new SqlParameter("@amenityid", ramenity_id));
        dsparam.Add(new SqlParameter("@ratesort", rsort_id));
        ds_PropList = BookDBProvider.getDataSet("uspGetStatePropListByCondition", dsparam);


        if (!IsPostBack)
        {
            if (ds_PropList.Tables[0].Rows.Count == 0)
            {
                Response.StatusCode = 404;
                // Response.Status = "There is no state province";
                Response.End();
            }
        }

 
    }
}
