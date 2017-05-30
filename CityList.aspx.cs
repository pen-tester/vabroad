//live
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

//public partial class newCityList : System.Web.UI.Page
public partial class newCityList : CommonPage
{

    private int regionid = -1;
    private int countryid = -1;
    private int stateprovinceid = -1;
    public int cityid = -1;

    public DataSet city_ds;

    public CountryInfoWithCityID countryinfo;

    public int[] bedroominfo = new int[4];
    public int[] amenity_id = { 8, 33, 1, 11, 0 };
    public int[] amenity_nums = new int[5];
    public int[] proptypeinfo = { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 };
    public string newdescription;

    // public string[] str_propcate = { "Chalet", "Apartment", "Villa", "Hotel", "Cottage", "Boat", "Castle", "B&B", "Guesthouse", "Farmhouse", "Display All" };
    // public int[] prop_typeval = { 17, 4, 1, 2, 9, 15, 16, 5, 11, 13, 0 };
    public string[] str_propcate = { "Vacation Rentals", "Hotels", "All" };
    public int[] prop_typeval = { 1, 2, 0 };
    public int[] prop_nums = new int[3];
    public int[] bedroom_id = { 1, 2, 3, 0 };
    public int[] sort_id = { 1, 2,  0 };
    public string[] min_rentaltypes = { "None", "2 Nights", "3 Nights", "1 Week", "2 Weeks", "Monthly", "1 Night" };
    public int[] property_typeval = { 8, 2, 5, 16, 11, 24, 2, 19, 22, 12 };

    public int rproptype_id, rbedroom_id,ramenity_id, rsort_id, pagenum;

    public string meta_str = "";

    public AjaxPropListSet proplistset;
    public List<int> list_rating = new List<int>();
    //live
    protected void Page_Load(object sender, System.EventArgs e)
    {
        //Response.Clear();
        //Response.StatusCode = 404;
        //Response.End(); 
        //HttpResponse.RemoveOutputCacheItem("/CityList.aspx");
        //CommonFunctions.Connection.Open ();

        
        if ((Request.Params["CityID"] != null) && (Request.Params["CityID"].Length > 0))
            try
            {
                cityid = Convert.ToInt32(Request.Params["CityID"]);
            }
            catch (Exception)
            {
            }
        //lblcity.Text = cityid.ToString();
        //cityid = 3031;
        if (cityid == -1)
            Response.Redirect(CommonFunctions.PrepareURL("InternalError.aspx"));

      //  cityid = 3031;
        // propertyset = SearchProvider.getPropertyListInfoSet(strkeyword, 0, 0, 0);
        // propertylist.DataSource = propertyset;
        // propertylist.DataBind();
        // propertytypes = SearchProvider.getPropertyTypeListSet(strkeyword);
        for (int i = 0; i < 4; i++)
            bedroominfo[i] = SearchProvider.getNumbersOfCityID(cityid, 0, 0, i);
        for (int i = 0; i < 5; i++)
            amenity_nums[i] = SearchProvider.getNumbersOfCityID(cityid, 0, amenity_id[i], 0);

        for (int i = 0; i < 3; i++)
        {
            prop_nums[i] = SearchProvider.getNumbersOfCityID(cityid, prop_typeval[i], 0, 0);
        }
        // ajax_proplist = SearchProvider.getAjaxPropListSet(strkeyword, 0, 0, 0, 0, 0);

        // Response.Write(cityid + " City");
        //Response.Write(cityid);

        countryinfo = SearchProvider.getCountryInfoCityID(cityid);

        hyperRegion.NavigateUrl = "/" + countryinfo.Region.ToLower().Replace(" ", "_") + "/default.aspx";
        hyplnkCountryBackLink.NavigateUrl = "/" +  countryinfo.Country.ToLower().Replace(" ", "_") + "/default.aspx";
        hyplnkStateBackLink.NavigateUrl = "/" + countryinfo.Country.ToLower().Replace(" ", "_") + "/" + countryinfo.StateProvince.ToLower().Replace(" ", "_") + "/default.aspx";

        ltrH11.Text = countryinfo.City + " Vacation Rentals and "+ countryinfo.City + " Hotels";
        lblcity.Text = Server.HtmlDecode( countryinfo.CityText);
        if (countryinfo.CityText == null || countryinfo.CityText == "")
        {
            lblcity.Text =String.Format( "Vacations-abroad.com is a {0} {1} vacation rental directory of short term {0} vacation condos, privately owned {0} villas and {0} rentals by owner. Our unique and exotic boutique {0} hotels and luxury {0} resorts are perfect {0} {1} rentals for family and groups that are looking for vacation rentals in {0} {1}",countryinfo.City,countryinfo.Country);
        }

        DataSet ds = AjaxProvider.getProCatNumsbyCity(cityid);

        for(int i=0; i< ds.Tables[0].Rows.Count ;i++)
        {
            meta_str += String.Format("{1}s ({0}), ", ds.Tables[0].Rows[i][0], ds.Tables[0].Rows[i][1]).Replace("&"," ");
        }
        int ind_last = meta_str.Length - 2;
        meta_str = meta_str.Substring(0, (ind_last>0)?ind_last:0);

        if (!IsPostBack) {
            txtCityText.Text = Server.HtmlDecode( countryinfo.CityText).Replace("<br />", Environment.NewLine); 
            txtCityText2.Text = Server.HtmlDecode(countryinfo.CityText2).Replace("<br />", Environment.NewLine);
            //txtCityText2.Text = countryinfo.CityText2;
            CityParam.Value = cityid.ToString();
            rproptype_id = 0;
            rbedroom_id = 0;
            ramenity_id = 0;
            rsort_id = 1;
            pagenum = 0;
        }
        else
        {
            rproptype_id = Int32.Parse( Request.Form["proptype"]);
            rbedroom_id = Int32.Parse(Request.Form["roomnums"]);
            ramenity_id = Int32.Parse(Request.Form["amenitytype"]);
            rsort_id = Int32.Parse(Request.Form["pricesort"]);
            pagenum = Int32.Parse(Request.Form["pagenums"]);

        }


        proplistset = SearchProvider.getAjaxAllPropListSetWithCityID(cityid, rproptype_id, ramenity_id, rbedroom_id,rsort_id);
        for(int i=0;i< proplistset.allnums; i++)
        {
            list_rating.Add(BookDBProvider.getRatingbyID(proplistset.propertyList[i].detail.ID));
        }
        // Response.Write(cityid);
        //<meta name="description" content="<%=countryinfo.City %>, <%=countryinfo.StateProvince %> <%=meta_str %>" />
        //  HtmlMeta newdescription = new HtmlMeta();

        //  newdescription.Name = "description";
        //  newdescription.Content = Server.HtmlDecode(String.Format("Our {0}, {1} vacation rentals and boutique hotels include: {2} ", countryinfo.City, countryinfo.StateProvince,meta_str));
        newdescription = String.Format("Our {0}, {1} vacation rentals and boutique hotels include: {2} ", countryinfo.City, countryinfo.StateProvince, meta_str);
        city_ds = AjaxProvider.getCityListbyCityNum(cityid);
      //  Page.Header.Controls.Add(newdescription);
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


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        SearchProvider.setCityText(Int32.Parse(CityParam.Value), 0, Server.HtmlEncode(txtCityText.Text.Replace(Environment.NewLine, "<br />")));
        lblcity.Text = txtCityText.Text.Replace(Environment.NewLine, "<br />");
    }

    protected void btnSubmit2_Click(object sender, EventArgs e)
    {
        // Response.Write(CityParam.Value);
        SearchProvider.setCityText(Int32.Parse(CityParam.Value), 1, Server.HtmlEncode(txtCityText2.Text.Replace(Environment.NewLine,"<br />")));
        //        Counn = txtCityText.Text.Replace(Environment.NewLine, "<br />");
        countryinfo.CityText2 = txtCityText2.Text.Replace(Environment.NewLine, "<br />");
    }
}
