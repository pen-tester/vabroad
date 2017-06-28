using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public class JsonResult
{
    public int status { get; set; }
    public string result { get; set; }
    public string error { get; set; }
    public int propid { get; set; }
    public JsonResult()
    {
        status = -1;
        result = "";
        propid = -1;
    }
}

public partial class userowner_SavePropertyInfo : Page
{
    protected PropertyDetailInfo propinfo;
    public int propid = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Clear();
        Response.ContentType = "application/json; charset=utf-8";
        JsonResult jsonresult = processRequest();

        Response.Write( JsonConvert.SerializeObject(jsonresult, Formatting.Indented));
        Response.End();
    }

    public JsonResult processRequest()
    {
        JsonResult jsonresult = new JsonResult();
        if (!AuthenticationManager.IfAuthenticated || !User.Identity.IsAuthenticated)
        {
            jsonresult.error = "Not Signed";
        }
        else if (HttpContext.Current.Request.HttpMethod != "POST")
        {
            jsonresult.error = "The function works in POST method";
        }
        //else{}  //If the user is signed
        
        if (!Int32.TryParse(Request["propid"], out propid)) propid = -1;
        
        if (propid != -1) //Create new property
        {

        }
        else //For the existed property
        {
            propinfo = AjaxProvider.getPropertyDetailInfo(propid);
            if (propinfo.UserID != AuthenticationManager.UserID && !AuthenticationManager.IfAdmin)
            {
                jsonresult.error = "You are trying to do malicious action.";
                return jsonresult;
            }
        }
        jsonresult.propid = propid;
        return jsonresult;
    }
}