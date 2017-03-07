using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for CouponHelper
/// </summary>
public class CouponHelper
{
    public static string connString = ConfigurationManager.ConnectionStrings["ConnectionString"].ToString();
    public CouponHelper()
    {
        //
        // TODO: Add constructor logic here
        //
    }

        
}