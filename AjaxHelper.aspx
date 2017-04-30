<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AjaxHelper.aspx.cs" Inherits="AjaxHelper" %>
<%@ Import Namespace="System.Web.Services" %>

<!DOCTYPE html>
<script runat="server">

    [WebMethod]
    // Get session state value.
    public static AjaxCountryList GetCountryList(int id) {
        return AjaxProvider.getCountryInfo(id);
    }
    [WebMethod]
    // Get session state value.
    public static AjaxStateList GetStateList(int id) {
        return AjaxProvider.getSateInfo(id);
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <title></title>
</head>
<body>

</body>
</html>
