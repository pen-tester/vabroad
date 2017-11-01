<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApiAdmin.aspx.cs" Inherits="ApiAdmin" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    [WebMethod]
    // Get session state value.
    public static List<Unverifiedmap_Propery> Get_UnverifiedPropertyList() {
        return AdminHelper.get_unverfiedmap_properties();
    }
    [WebMethod]
    // Get session state value.
    public static string update_property_location(int propid, float lat, float lg) {
        List<SqlParameter> param = new List<SqlParameter>();
        //[uspAddPropLatLong]@propid int=0, @lat float =0, @lng float =0
        param.Add(new SqlParameter("@propid", propid));
        param.Add(new SqlParameter("@lat", lat));
        param.Add(new SqlParameter("@lng", lg));
        AdminHelper.getDataSet("uspAddPropLatLong", param);
        return String.Format("{{ id:{0},lat:{1}, lng:{2} }}",propid, lat,lg);
    }
</script>