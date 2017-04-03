using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class accounts_PwdReset : System.Web.UI.Page
{
    public string errormsg = "", email = "", uid="";
    public int triger_redirect = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        uid = Request["uid"];
        string pwd = Request["upwd"];
        if (uid == "") Response.Redirect("/default.aspx");

        if (pwd == "")
        {
            errormsg = "You've not input password";
            return;
        }

        if (IsPostBack) {
            List<SqlParameter> param = new List<SqlParameter>();
            param.Add(new SqlParameter("@link", uid));
            DataSet ds = BookDBProvider.getDataSet("uspGetPwdReset", param);

            if(ds.Tables[0].Rows.Count==0)
            {
                errormsg = "You've gotten wrong link.";
                return;
            }

            email = ds.Tables[0].Rows[0]["Email"].ToString();


            byte[] salt = AuthenticationManager.GenerateSalt();
            int repeats = AuthenticationManager.GenerateRepeats();
            byte[] pwdhash = AuthenticationManager.HashPassword(pwd, salt, repeats);

            param.Clear();
            param.Add(new SqlParameter("@email", email));
            param.Add(new SqlParameter("@salt", salt));
            param.Add(new SqlParameter("@repeat", repeats));
            param.Add(new SqlParameter("@hash", pwdhash));

            BookDBProvider.getDataSet("uspUpdateUserPwd", param);

            string msg_format = @"Notification from Vacations-abroad.com <br/>
                                   You've reset the password of the account at vacations-abroad.com <br/>
                                   If this is not your activity, please contact administrator of vacation-abroad.com , 'prop@vacations-abroad.com'! <br/>
                                   Vacations-Abroad.com ";

            BookDBProvider.SendEmail(email, "Password changed : Vacations-abroad.com", msg_format);

            triger_redirect = 1;
        }

    }
}