using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contest : System.Web.UI.Page
{

    public ContestInfo cont_info;

    protected void Page_Load(object sender, EventArgs e)
    {
        txt_result.Visible = false;
        chkerror.Visible = false;

        cont_info = ContestHelper.getCotestInfo();
        if (!IsPostBack)
        {
         
            con_name.Text = Server.HtmlDecode(cont_info.Name); con_text.Text = Server.HtmlDecode(cont_info.Text);
            con_price.Text = cont_info.Price.ToString();
            con_rule.Text = Server.HtmlDecode(cont_info.RuleText).Replace("<br />", Environment.NewLine);
            con_valdation.Text = cont_info.ValidMonth.ToString();
            DateTime dt = DateTime.Parse(cont_info.StartDate);
            con_startdate.Text = dt.ToString("yyyy/MM/dd");
        }
    }

    protected void Agreecheck_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = chk_rule.Checked;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (!chk_rule.Checked)
        {
            chkerror.Visible = true;
            return;
        }
        if (Page.IsValid )
        {
            int ret= ContestHelper.addContestEmail(Server.HtmlEncode(firstname.Text), Server.HtmlEncode(lastname.Text), Server.HtmlEncode(email.Text), Server.HtmlEncode(phonenumber.Text));
            if (ret != 0)
            {
                txt_result.Text = "Thank you for your submission";
                txt_result.Visible = true;
                firstname.Text = ""; lastname.Text = "";email.Text = ""; phonenumber.Text = "";
            }
            else
            {
                txt_result.Text = "There is high traffic in the server. Please retry later!";
                txt_result.Visible = true;
            }
        }
    }

    protected void AdminSubmit_Click(object sender, EventArgs e)
    {
        string name = con_name.Text; string text = con_text.Text; string ruletext = Server.HtmlEncode( con_rule.Text.Replace(Environment.NewLine, "<br />"));
        int price, validmonth;
        Int32.TryParse(con_price.Text, out price);
        Int32.TryParse(con_valdation.Text, out validmonth);
        DateTime dt;
        DateTime.TryParse(con_startdate.Text,out dt);
        ContestHelper.addContest(name, text, price, validmonth, ruletext, dt.ToString());
       // Response.Write(name+text+ price+ validmonth+ ruletext+ dt.ToString());
        cont_info = ContestHelper.getCotestInfo();
    }
}