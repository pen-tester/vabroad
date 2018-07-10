<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxHelper.aspx.cs" Inherits="AjaxHelper" %>
<%@ Import Namespace="System.Web.Services" %>

<!DOCTYPE html>
<script runat="server">

    [WebMethod]
    // Get session state value.
    public static string GetCountryList(int id) {
        string res= AjaxProvider.getCountryInfo(id);
        return String.Format("{{\"id\":{0} , \"data\":{1} }}", id, res);
    }
    [WebMethod]
    // Get session state value.
    public static string GetStateList(int id) {
        string res= AjaxProvider.getSateInfo(id);
        return String.Format("{{\"id\":{0} , \"data\":{1} }}", id, res);
    }

    [WebMethod]
    // Get session state value.
    public static string GetCityList(int id) {
         string res= AjaxProvider.getCityInfo(id);
        return String.Format("{{\"id\":{0} , \"data\":{1} }}", id, res);
    }


    [WebMethod]
    // Get session state value.
    public static string GetTypeListByCategory(int id) {
        string res= AjaxProvider.getTypeList(id);
        return String.Format("{{\"id\":{0} , \"data\":{1} }}", id, res);
    }


    [WebMethod]
    // Get session state value.AjaxPropListSet
    public static AjaxPropListSet GetPropertyListKeyword(string keyword, int proptype, int amenitytype, int roomnum, int sorttype, int pagenum ) {
        return SearchProvider.getAjaxPropListSet(keyword, proptype, amenitytype, roomnum,sorttype,pagenum);
        // AjaxPropListSet ajx=SearchProvider.getAjaxPropListSet(keyword, proptype, amenitytype, roomnum,sorttype,pagenum);
        // return keyword + proptype + amenitytype + roomnum+sorttype+pagenum;
        // return keyword +ajx.allnums;

    }

    [WebMethod]
    // Get session state value.AjaxPropListSet
    public static AjaxPropListSet GetPropertyListCityID(int cityid, int proptype, int amenitytype, int roomnum, int sorttype, int pagenum) {
        return SearchProvider.getAjaxPropListSetWithCityID(cityid, proptype, amenitytype, roomnum,sorttype,pagenum);
        // AjaxPropListSet ajx=SearchProvider.getAjaxPropListSet(keyword, proptype, amenitytype, roomnum,sorttype,pagenum);
        // return keyword + proptype + amenitytype + roomnum+sorttype+pagenum;
        // return keyword +ajx.allnums;

    }
    [WebMethod]
    // Get session state value.AjaxPropListSet
    public static PropertyDetailInfo GetPropertyDetailInfo(int propid) {
        return AjaxProvider.getPropertyDetailInfo(propid);
        // AjaxPropListSet ajx=SearchProvider.getAjaxPropListSet(keyword, proptype, amenitytype, roomnum,sorttype,pagenum);
        // return keyword + proptype + amenitytype + roomnum+sorttype+pagenum;
        // return keyword +ajx.allnums;

    }
    [WebMethod]
    // Get session state value.AjaxPropListSet
    public static CouponItem getcouponitem(string coupon) {
        CouponItem item = AjaxProvider.getCouponItem(coupon);
        return item;
    }

    [WebMethod]
    // Get session state value.AjaxPropListSet
    public static  List<ObjectName> getcountryidlist(string cname) {
        List<string> param = new List<string>();
        List<string> pname = new List<string>();
        param.Add(cname); pname.Add("@name");
        List<ObjectName> list = MainHelper.getListFromDB<ObjectName>("uspGetCountryListByCountryName", MainHelper.getSqlParamList(param, pname));

        return list;
    }

     [WebMethod]
    public static  List<ObjectName> getstatesidlist(int id) {
        List<string> param = new List<string>();
        List<string> pname = new List<string>();
        param.Add(id.ToString()); pname.Add("@id");
        List<ObjectName> list = MainHelper.getListFromDB<ObjectName>("uspGetStateListByCountryID", MainHelper.getSqlParamList(param, pname));

        return list;
    }
    
     [WebMethod]
    public static  List<ObjectName> getcityidlist(int id) {
        List<string> param = new List<string>();
        List<string> pname = new List<string>();
        param.Add(id.ToString()); pname.Add("@id");
        List<ObjectName> list = MainHelper.getListFromDB<ObjectName>("uspGetCityListByStateID", MainHelper.getSqlParamList(param, pname));

        return list;
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml"  lang="en" xml:lang="en">
<head >
    <title></title>
</head>
<body>

</body>
</html>
