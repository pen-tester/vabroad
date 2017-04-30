using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_propertymap : ClosedPage// Page   //ClosedPage
{
    protected DataSet ds_proplocation;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            // Response.Write(userid);
            float hlat, hlng;
            string haddr, hcity;
            int hcityid, hpropid, hstateid;
            if (!float.TryParse(Request["hlat"], out hlat)) hlat = 0;
            if (!float.TryParse(Request["hlng"], out hlng)) hlng = 0;
            haddr = Request["haddr"];
            hcity = Request["hcity"];
            if (!int.TryParse(Request["hcityid"], out hcityid)) hcityid = 0;
            if (!int.TryParse(Request["hstateid"], out hstateid)) hstateid = 0;
            if (!int.TryParse(Request["hpropid"], out hpropid)) hpropid = 0;

            if (hcityid == 0)
            {
                List<SqlParameter> sparam = new List<SqlParameter>();
                sparam.Add(new SqlParameter("@stateid", hstateid));
                sparam.Add(new SqlParameter("@city", hcity));
                DataSet ds= BookDBProvider.getDataSet("uspAddCity", sparam);
                hcityid = int.Parse(ds.Tables[0].Rows[0][0].ToString());
            }
            List<SqlParameter> tparam = new List<SqlParameter>();
            tparam.Add(new SqlParameter("@propid", hpropid));
            tparam.Add(new SqlParameter("@lat", hlat));
            tparam.Add(new SqlParameter("@lng", hlng));
            tparam.Add(new SqlParameter("@cityid", hcityid));
            BookDBProvider.getDataSet("uspAddPropLatLong", tparam);
        }


        int userid = int.Parse(Request["userid"]);
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@userid", userid));
        ds_proplocation = BookDBProvider.getDataSet("uspGetPropertyLocationsByUserID", param);

    }
}