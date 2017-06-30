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

public partial class EditProperty : ClosedPage
{
    protected PropertyDetailInfo propinfo;
    protected string json_propinfo="{}", json_amenity="{}",json_roomfurnitures="[]" ,json_attractions="[]", json_allfurnitures="[]";
    protected DataSet prop_category;
    protected DataSet prop_amenities;

    protected DataSet all_amenities;
    protected DataSet allfurnitures;
    protected DataSet allattractions;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        prop_category = BookDBProvider.getDataSet("uspGetPropertyCategory", new List<SqlParameter>());
        all_amenities =  BookDBProvider.getDataSet("uspGetAllAmenity", new List<SqlParameter>());
        allfurnitures = BookDBProvider.getDataSet("uspGetAllFurniture", new List<SqlParameter>());
        json_allfurnitures = CommonProvider.getJsonStringFromDs(allfurnitures);
        allattractions = BookDBProvider.getDataSet("uspGetAllAttraction", new List<SqlParameter>());

        //For new property
        if (propertyid == -1)
        {

        }
        else if (propertyid > 0)
        {
            //For the existed property
            propinfo = AjaxProvider.getPropertyDetailInfo(propertyid);
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@propid", propertyid));
            prop_amenities = BookDBProvider.getDataSet("uspGetPropertyAmenity", param);
            json_amenity = CommonProvider.getJsonStringFromDs(prop_amenities);
            json_propinfo = new JavaScriptSerializer().Serialize(propinfo);
            param.Clear();
            param.Add(new SqlParameter("@propid", propertyid));
            json_roomfurnitures = CommonProvider.getJsonStringFromDs(BookDBProvider.getDataSet("uspGetRoomFurnitures", param));
            param.Clear();
            param.Add(new SqlParameter("@propid", propertyid));
            json_attractions = CommonProvider.getJsonStringFromDs(BookDBProvider.getDataSet("uspGetPropertyAttractionByID", param));
        }


    }
    
}
