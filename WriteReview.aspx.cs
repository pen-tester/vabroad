using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;

public partial class PropertyReview : CommonPage
{
    public int propNum = 0;
    public string propName = "";
    public int stateprovinceid = 0;
    public int cityID = 0;
    public int countyID = 0;
    public string county = "";
    public string city = "";
    public string state = "";
    public string country = "";
    public string imgurl;

    public string fname, lname, email, phonenumber, comment, vmon,vyear;
    public int rate=0, image_count=0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DBConnection obj = new DBConnection();
            try
            {
                if (Request.QueryString["propID"] != null)
                {
                    if (obj.IsNumeric(Request.QueryString["propID"]))
                    {
                        DataTable dt = obj.spSelectSingleProperty(Convert.ToInt32(Request.QueryString["propID"]));

                        if (dt.Rows.Count > 0)
                        {
                            propNum = Convert.ToInt32(Request.QueryString["propID"]);
                            
                            imgurl = CommonFunctions.GetSiteAddress() + "/images/" +
                                dt.Rows[0]["photoImage"].ToString();

                            if (dt.Rows[0]["name2"] != DBNull.Value)
                                propName = dt.Rows[0]["name2"].ToString();
                            else
                                propName = dt.Rows[0]["name"].ToString();
                           
                         //   imgProperty.Alt
                            //  lblAddress.Text = dt.Rows[0]["address"].ToString();

                            //hlkCity.Text = dt.Rows[0]["city"].ToString();
                            //hlkState.Text = dt.Rows[0]["stateprovince"].ToString();
                            //hlkCountry.Text = dt.Rows[0]["country"].ToString();

                            stateprovinceid = Convert.ToInt32(dt.Rows[0]["stateprovinceid"].ToString());

                            city = dt.Rows[0]["city"].ToString();
                            state = dt.Rows[0]["stateprovince"].ToString();
                            country = dt.Rows[0]["country"].ToString();
                            cityID = Convert.ToInt32(dt.Rows[0]["cityid"]);
                            if(dt.Rows[0]["countyid"] != DBNull.Value)
                            countyID = Convert.ToInt32(dt.Rows[0]["countyid"]);

                            if (dt.Rows[0]["county"] != DBNull.Value)
                                county = dt.Rows[0]["county"].ToString();
                            //CommonFunctions.GetSiteAddress() + 
                            string url = "/" + dt.Rows[0]["country"].ToString() + "/" +
                                dt.Rows[0]["stateprovince"].ToString() + "/" + dt.Rows[0]["city"].ToString() + "/" +
                                Request.QueryString["propID"].ToString() + "/default.aspx";
                            Session["commentsRedirect"] = url;

                            hlkPropNum.Text = "Return to Property #" + Request.QueryString["propID"].ToString();
                            hlkPropNum.NavigateUrl = url.Replace(' ', '_').ToLower();

                            url = CommonFunctions.GetSiteAddress() + "/" + dt.Rows[0]["country"].ToString() + "/" +
                                dt.Rows[0]["stateprovince"].ToString() + "/" + dt.Rows[0]["city"].ToString() +
                                "/default.aspx";
                            //hlkCity.NavigateUrl = url.Replace(' ', '_').ToLower();

                            url = CommonFunctions.GetSiteAddress() + "/" + dt.Rows[0]["country"].ToString() + "/" +
                                dt.Rows[0]["stateprovince"].ToString() +
                                "/default.aspx";
                            //hlkState.NavigateUrl = url.Replace(' ', '_').ToLower();

                            url = CommonFunctions.GetSiteAddress() + "/" + dt.Rows[0]["country"].ToString() +
                                "/default.aspx";
                            //hlkCountry.NavigateUrl = url.Replace(' ', '_').ToLower();
                            //Page.Header.Controls.Add(new LiteralControl("<link href='/css/StyleSheetBig4.css' rel='stylesheet' type='text/css'></script>"));

                            DataBind();
                        }
                    }
                }
            }
            catch (Exception ex) {  }
            finally { obj.CloseConnection(); }
        }else
        {
            btnComment_submit();
        }
    }

    protected void btnComment_submit()
    {
       // Request.SaveAs(Server.MapPath("~/assets/img/ss.tst"),true);
 
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {


        if (Page.IsValid)
        {
           
            
        }
    }
    
   
}
