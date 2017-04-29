using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_propertymap : ClosedPage
{
    protected DataSet ds_proplocation;
    protected void Page_Load(object sender, EventArgs e)
    {
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@userid", userid));
        ds_proplocation = BookDBProvider.getDataSet("uspGetPropertyLocationsByUserID", param);
    }
}