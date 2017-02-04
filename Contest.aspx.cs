﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txt_result.Visible = false;
    }

    protected void Agreecheck_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = chk_rule.Checked;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int ret= ContestHelper.addContestEmail(Server.HtmlEncode(firstname.Text), Server.HtmlEncode(lastname.Text), Server.HtmlEncode(email.Text), Server.HtmlEncode(phonenumber.Text));
            if (ret > 0)
            {
                txt_result.Text = "Thank you for your submission";
                txt_result.Visible = true;
            }
        }
    }
}