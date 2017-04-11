using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class userowner_Listing : ClosedPage
{
    public DetailedUserInfo userinfo;
   // public DataSet inquiry_set, traveler_inquery_set;
    public DataSet property_set;
    // public DataSet owner_response_set, traveler_response_set;
    // public DataSet owner_book_set, traveler_book_set;
    public DataSet owner_ds, traveler_ds;
    public string[] cssclass_tabs = { "", "", "" };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!AuthenticationManager.IfAuthenticated) FormsAuthentication.SignOut();

       // Response.Write("Uid" + userid);

        userinfo = BookDBProvider.getDetailedUserInfo(userid);

        property_set = BookDBProvider.getPropertySet(userid);
        propertylist.DataSource = property_set;
        propertylist.DataBind();

        if (userinfo.Zip == "") Response.Redirect("/ownerinformation.aspx?userid="+userinfo.ID);

         
        List<SqlParameter> param = new List<SqlParameter>();
        SqlParameter puserid = new SqlParameter("@userid", SqlDbType.Int);
        puserid.Value = userid;
        param.Add(puserid);

        owner_ds = BookDBProvider.getDataSet("uspGetOwnerResponseList", param);
        //For Traveller
     /*   param.Clear();
        SqlParameter pemail = new SqlParameter("@email", SqlDbType.NVarChar, 500);
        pemail.Value = userinfo.Email;
        param.Add(pemail);

        traveler_ds = BookDBProvider.getDataSet("uspGetTravelerResponseList", param);

    */


        if (owner_ds.Tables[0].Rows.Count != 0) cssclass_tabs[0] = "active";
        else
        {
            cssclass_tabs[0] = "hidden";
            if (property_set.Tables[0].Rows.Count == 0)
            {
                cssclass_tabs[1] = "hidden";
                cssclass_tabs[2] = "active";
            }
            else cssclass_tabs[1] = "active";
        }

        //Displaying the tabs 
    }

    protected void ListProperty_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("EditProperty.aspx?UserID=" + userid.ToString(), "*User* Listings"));
    }
    protected void ListTour_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("EditTour.aspx?UserID=" + userid.ToString(), "*User* Listings"));
    }

    protected void OurCommision_Click(object sender, EventArgs e)
    {
        Response.Redirect(CommonFunctions.PrepareURL("AgentAccount.aspx?UserID=" + userid.ToString(), "*User* Account"));
    }

    protected void bt_payment_Command(object sender, CommandEventArgs e)
    {
        //CommonFunctions.PrepareURL ("MakePayment.aspx?UserID=" + userid.ToString () + "&PropertyID=" + DataBinder.Eval(Container.DataItem, "ID", "{0:d}") + "&InvoiceID=-1", "*User* Listings"
        Button btn = (Button)(sender);
        string prop_id = btn.CommandArgument;
        Response.Redirect(CommonFunctions.PrepareURL(String.Format("MakePayment.aspx?UserID={0}&PropertyID={1}&InvoiceID=-1",userid, prop_id), "*User* Listings"));
    }

    protected void bt_edittxt_Command(object sender, CommandEventArgs e)
    {
        //CommonFunctions.PrepareURL ("EditProperty.aspx?UserID=" + userid.ToString () + "&PropertyID=" + DataBinder.Eval(Container.DataItem, "ID", "{0:d}"), "*User* Listings")
        Button btn = (Button)(sender);
        string prop_id = btn.CommandArgument;
        Response.Redirect(CommonFunctions.PrepareURL(String.Format("EditProperty.aspx?UserID={0}&PropertyID={1}", userid, prop_id), "*User* Listings"));

    }

    protected void bt_editphoto_Command(object sender, CommandEventArgs e)
    {
        // CommonFunctions.PrepareURL ("PropertyPhotos.aspx?UserID=" + userid.ToString () + "&PropertyID=" + DataBinder.Eval(Container.DataItem, "ID", "{0:d}"), "*User* Listings") 
        Button btn = (Button)(sender);
        string prop_id = btn.CommandArgument;
        Response.Redirect(CommonFunctions.PrepareURL(String.Format("PropertyPhotos.aspx?UserID={0}&PropertyID={1}", userid, prop_id), "*User* Listings"));

    }

    protected void bt_calendar_Command(object sender, CommandEventArgs e)
    {
        //CommonFunctions.PrepareURL ("PropertyCalendar.aspx?UserID=" + userid.ToString () + "&PropertyID=" + DataBinder.Eval(Container.DataItem, "ID", "{0:d}"), "*User* Listings")
        Button btn = (Button)(sender);
        string prop_id = btn.CommandArgument;
        Response.Redirect(CommonFunctions.PrepareURL(String.Format("PropertyCalendar.aspx?UserID={0}&PropertyID={1}", userid, prop_id), "*User* Listings"));
     //   Response.Write(CommonFunctions.PrepareURL(String.Format("PropertyCalendar.aspx?UserID={0}&PropertyID={1}", userid, prop_id), "*User* Listings"));

    }
    protected void bt_delete_Command(object sender, CommandEventArgs e)
    {
        //"DeleteProperty.aspx?PropertyID=" + propertyid + "&BackLink=<%= System.Web.HttpUtility.UrlEncode (Request.Url.ToString ()) %>"
        Button btn = (Button)(sender);
        string prop_id = btn.CommandArgument;
        Response.Redirect(CommonFunctions.PrepareURL(String.Format("DeleteProperty.aspx?UserID={0}&PropertyID={1}", userid, prop_id), System.Web.HttpUtility.UrlEncode(Request.Url.ToString())));

    }
}