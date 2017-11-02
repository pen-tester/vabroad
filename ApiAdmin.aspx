<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ApiAdmin.aspx.cs" Inherits="ApiAdmin" %>
<%@ Import Namespace="System.Web.Services" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    [WebMethod]
    // Get session state value.
    public static List<Unverifiedmap_Propery> Get_UnverifiedPropertyList(int page, string sorting_field, int sorttype) {
        if(AuthenticationManager.IfAuthenticated==false || AuthenticationManager.IfAdmin == false)
        {
            return null;
        }
        return AdminHelper.get_unverfiedmap_properties(page, sorting_field, sorttype);
    }
    [WebMethod]
    // Get session state value.
    public static string update_property_location(int propid, float lat, float lg, string addr) {
        if(AuthenticationManager.IfAuthenticated==false || AuthenticationManager.IfAdmin == false)
        {
            return null;
        }
        List<SqlParameter> param = new List<SqlParameter>();
        //[uspAddPropLatLong]@propid int=0, @lat float =0, @lng float =0
        param.Add(new SqlParameter("@propid", propid));
        param.Add(new SqlParameter("@lat", lat));
        param.Add(new SqlParameter("@lng", lg));
        AdminHelper.getDataSet("uspAddPropLatLong", param);
        param.Clear();
        param.Add(new SqlParameter("@propid", propid));
        param.Add(new SqlParameter("@addr", addr));
        AdminHelper.getDataSet("uspUpdatePropertyAddress", param);
        return String.Format("{{ id:{0},lat:{1}, lng:{2} }}",propid, lat,lg);
    }

    [WebMethod]
    public static int getnumber_unverifiedpropertylist()
    {
        if(AuthenticationManager.IfAuthenticated==false || AuthenticationManager.IfAdmin == false)
        {
            return 0;
        }
        List<SqlParameter> param = new List<SqlParameter>();
        //[uspAddPropLatLong]@propid int=0, @lat float =0, @lng float =0
        DataSet ds = AdminHelper.getDataSet("uspGetNumberProperties_map_unverified", param);
        if (ds.Tables.Count > 0)
        {
            try
            {
                return int.Parse(ds.Tables[0].Rows[0][0].ToString());
            }
            catch (Exception e)
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }
</script>