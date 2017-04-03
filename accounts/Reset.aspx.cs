using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class accounts_Reset : System.Web.UI.Page
{
    public string errormsg = "", email="";
    public int  triger_redirect=0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
        else
        {
            email = Request["uemail"];
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@email", email));
            DataSet ds = BookDBProvider.getDataSet("uspGetUserInfo", param);

            if (ds.Tables[0].Rows.Count == 0)
            {
                errormsg = "You didn't input correct registered email!";
                return;
            }
            else
            {
                List<SqlParameter> newparam = new List<SqlParameter>();
                newparam.Add(new SqlParameter("@email", email));
                string uid = generateID();
                newparam.Add(new SqlParameter("@link", uid));
                BookDBProvider.getDataSet("uspAddPwdReset", newparam);

                //Sending email to reset password
                string msg_format = @"Notification from Vacations-abroad.com <br/>
                                   To Reset Password of vacations-abroad account,please click <a href='{0}'>{0}</a> <br />
                                   If this is not your activity, please contact administrator of vacation-abroad.com , 'prop@vacations-abroad.com'! <br/>
                                   Vacations-Abroad.com ";
                BookDBProvider.SendEmail(email, "Password Reset:Vacations-Abroad.com", String.Format(msg_format, String.Format("https://www.vacations-abroad.com/accounts/pwdreset.aspx?uid={0}",uid)));

                triger_redirect = 1;
                return;
            }
        }
    }
    public string generateID()
    {
        return AjaxProvider.Base64Encode(Guid.NewGuid().ToString("N"));
    }
}