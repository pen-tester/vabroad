using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for AjaxHelper
/// </summary>
public class AjaxHelper
{
    public AjaxHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }
}

public class Ajaxcountryinfo
{
    public string name { get; set; }    
    public int id { get; set; }

}

public class AjaxStateInfo
{
    public string name { get; set; }
    public int id { get; set; }

}

public class AjaxStateList
{
    public List<AjaxStateInfo> statelist { get; set; }
    public int countryid { get; set; }
}

public class AjaxCountryList
{
    public List<Ajaxcountryinfo> statelist { get; set; }
    public int regionid { get; set; }
}

public class NumbersPropertybyCountry
{
    public string Region { get; set; }
    public string Country { get; set; }
    public int NumProCountry { get; set; }
}