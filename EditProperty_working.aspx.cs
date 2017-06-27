using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Text;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public partial class EditProperty : CommonPage
{
    protected PropertyDetailInfo propinfo;
    protected string json_propinfo="{}";
    protected DataSet prop_category;
    protected void Page_Load(object sender, System.EventArgs e)
    {
        prop_category = BookDBProvider.getDataSet("uspGetPropertyCategory", new List<SqlParameter>());
        //For new property
        if (propertyid == -1)
        {

        }
        else if (propertyid > 0)
        {
            //For the existed property
            propinfo = AjaxProvider.getPropertyDetailInfo(propertyid);
            json_propinfo = new JavaScriptSerializer().Serialize(propinfo);
        }


    }
    
}
