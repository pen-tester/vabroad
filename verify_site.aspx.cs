using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class verify_site : System.Web.UI.Page
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(connString))
        {
            SqlDataAdapter users = new SqlDataAdapter("select * from Users", con);
            SqlCommandBuilder cmdBuilder;
            DataSet ds_users = new DataSet();
            cmdBuilder = new SqlCommandBuilder(users);
            users.Fill(ds_users, "users");

            int count = ds_users.Tables[0].Rows.Count;
            for(int i=0;i < count; i++)
            {
                DataRow row = ds_users.Tables[0].Rows[i];

                if (row["Website"].ToString() == "") continue;
                Uri siteUri = new Uri(row["Website"].ToString());
                WebRequest wr = WebRequest.Create(siteUri);

                wr.Timeout = 5000;
                ds_users.Tables[0].Rows[i]["site_verified"] = 0;
                // now, request the URL from the server, to check it is valid and works
                try
                {
                    using (HttpWebResponse response = (HttpWebResponse)wr.GetResponse())
                    {
                        if (response.StatusCode == HttpStatusCode.OK)
                        {
                            // if the code execution gets here, the URL is valid and is up/works
                            ds_users.Tables[0].Rows[i]["site_verified"] = 1;
                        }
                        response.Close();
                    }
                }
                catch (Exception ex)
                {

                }
            }

            users.Update(ds_users, "Users");

            con.Close();
        }
        
    }
}