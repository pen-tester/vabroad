using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GetPropertyNum : System.Web.UI.Page
{
    public List<NumbersPropertybyCountry> Num_list;
    protected void Page_Load(object sender, EventArgs e)
    {
        Num_list = AjaxProvider.getNumbersProperty();
        using (StreamWriter file = new StreamWriter(Server.MapPath("statisticsNumPro.txt"))) {
            file.WriteLine(String.Format("{0,-20}{1,-40}{2,-20}", "Region","Country", "# of Properties"));
            foreach (NumbersPropertybyCountry prop in Num_list)
            {
                file.WriteLine(String.Format("{0,-20}{1,-40}{2,-20}", prop.Region, prop.Country, prop.NumProCountry));
            }

        }
    }
}