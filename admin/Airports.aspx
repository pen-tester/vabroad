<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Airports.aspx.cs" Inherits="admin_Airports" %>

<%@ Import Namespace="System.Web.Services" %>

<script runat="server"> 
     [WebMethod]
    public static  List<ObjectName> getcityidlist(int id) {
        List<string> param = new List<string>();
        List<string> pname = new List<string>();
        param.Add(id.ToString()); pname.Add("@id");
        List<ObjectName> list = MainHelper.getListFromDB<ObjectName>("uspGetCityListByStateID", MainHelper.getSqlParamList(param, pname));

        return list;
    }
</script>
