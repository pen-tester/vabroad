using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class admin_Coupons : AdminPage
{
    public DataSet ds_coupons, ds_use_coupons;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ds_coupons = BookDBProvider.getDataSet("uspGetCouponItemList", new List<SqlParameter>());
        }
        ds_use_coupons = BookDBProvider.getDataSet("uspGetPaymentCouponList", new List<SqlParameter>());
    }

    protected void newcoupon_Click(object sender, EventArgs e)
    {
        string coupon = Request["n_coupon"], start_date = Request["n_start"], end_date = Request["n_end"];
        int discount;
        if (!Int32.TryParse(Request["n_discount"].ToString(), out discount)) discount = 0;

        if (coupon == "" || start_date == "" || end_date == "") return;

        List<SqlParameter> param = new List<SqlParameter>();
        SqlParameter p_coupon = new SqlParameter("@coupon", coupon);
        SqlParameter p_sd = new SqlParameter("@start", start_date);
        SqlParameter p_ed = new SqlParameter("@end", end_date);
        SqlParameter p_dis = new SqlParameter("@discount", discount);
        param.Add(p_coupon); param.Add(p_sd); param.Add(p_ed); param.Add(p_dis);

        BookDBProvider.getDataSet("uspAddCouponItem", param);
        ds_coupons = BookDBProvider.getDataSet("uspGetCouponItemList", new List<SqlParameter>());

    }


    protected void DelCom_Click(object sender, EventArgs e)
    {
        int cid;
        if (!int.TryParse(Request["del_id"], out cid)) cid = 0;
        if (cid == 0) return;
        List<SqlParameter> param = new List<SqlParameter>();
        param.Add(new SqlParameter("@id", cid));
        ds_coupons = BookDBProvider.getDataSet("uspGetCouponItemList", param);
    }
}