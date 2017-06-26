<%@ Page Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true" CodeFile="Coupons.aspx.cs" Inherits="admin_Coupons" %>

<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Coupons
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
 .modalLoading{
        margin-top:270px;
    }
    .dlgMsg{
        background-color:#fafbfc;
        border:5px solid #f0b892;
        border-radius:55px;
        color:#767271;
        width:300px;
        position:relative;
        margin:auto;
        margin-top:300px;
        padding:40px;
    }
     .modalhead{
        position:absolute;right:15px; top:10px;
    }
        table {
            width: 100%;
            font-family: Verdana;
            border-collapse: collapse;
            font-size:10pt;
            margin-top:20px;
        }
        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
        .couponinput{width:90%;}
        .hidden{display:none;}
        ul.wwpages li{list-style:none;display:inline-block;color:#6698ff;cursor:pointer;}
        .activepage{font-weight:bold;}
    </style>
    <link rel="stylesheet" href="/Assets/js/jqueryui112/jquery-ui.min.css" />
</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
    <form id="mainform" runat="server">
         <div id="msgdlg" class="modalform">
                  <div id="modal_dialog" class="dlgMsg" >
                      <div class="modalhead">
                            <span id="msgclose" class="mclose">x</span>
                      </div>
                      <div class="srow">
                          <div class="col-4">Message:</div>
                          <div class="col-8" id="modalmsg"></div>
                      </div>
                  </div>
            </div>
    <div class="internalpagewidth">
        <div class="srow">
            <div class="srow">
                <asp:Button ClientIDMode="Static" ID="newcoupon" OnClick="newcoupon_Click" runat="server" CssClass="hidden"/>
                <table>
                    <tr>
                        <th>Coupon ID 13 Characters Alphanumeric</th>
                        <th>Discount %</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Action</th>
                    </tr>
                    <% int cou_count = ds_coupons.Tables[0].Rows.Count;
                        int pages = (cou_count+9) / 10;

                        for(int ind_page=0; ind_page<pages; ind_page++)
                        {
                            int max_page = ((ind_page + 1) * 10 < cou_count) ? (ind_page + 1) * 10 : cou_count;
                            if (ind_page == 0)
                            {
                            %>
                            
                     <tr class="cou_page0 hidden">
                        <td><input type="text" class="couponinput" id="n_coupon" name="n_coupon"/></td>
                          <td><input type="text" id="n_discount" name="n_discount"  /></td>
                          <td><input type="text" id="n_start" name="n_start" readonly="true"/></td>
                          <td><input type="text" id="n_end" name="n_end" readonly="true"/></td>
                          <td><input type="button" id="n_add" value="New" /></td>
                    </tr>
                         <%} %>
                        <% for (int ind_cou = ind_page * 10; ind_cou < max_page; ind_cou++)
                            {
                                var cou_row = ds_coupons.Tables[0].Rows[ind_cou];
                                string classname = "cou_page" + ind_page;
                                string del_com = String.Format("del_coupon({0})", cou_row["CID"]); %>
                          <tr class="<%=classname %> hidden">
                              <td><%=cou_row["Coupon"] %></td>
                              <td><%=cou_row["Discount"] %></td>
                              <td><%=cou_row["Start_date"] %></td>
                              <td><%=cou_row["End_date"] %></td>
                              <td><input type="button"  onclick="<%=del_com %>" value="Del" /></td>
                          </tr>

                        <%} %>

                    <%} %>
                    <%
                    if (cou_count == 0)
                            {
                            %>
                            
                     <tr class="cou_page0">
                        <td><input type="text" class="couponinput" id="n_coupon" name="n_coupon"/></td>
                          <td><input type="text" id="n_discount" name="n_discount"  /></td>
                          <td><input type="text" id="n_start" name="n_start" readonly="true"/></td>
                          <td><input type="text" id="n_end" name="n_end" readonly="true"/></td>
                          <td><input type="button" id="n_add" value="New" /></td>
                    </tr>
                         <%} %>
                </table>
                <input type="hidden" name="del_id" id="del_id" />
                <asp:Button ID="DelCom" ClientIDMode="Static" CssClass="hidden" OnClick="DelCom_Click" runat="server" />
            </div>
            <div class="srow">
                <ul class="wwpages">
                    <li id="cprev">&lt; |</li>
                    <% for (int p_ind = 0; p_ind < pages; p_ind++)
                        { %>
                    <li class="cou_page" id="_cpage<%=p_ind %>"><%=p_ind+1 %> |</li>


                    <%} %>
                    <li id="cnext">&gt;</li>
                </ul>
                <input type="hidden" id="cpages" value="<%=pages %>" />
            </div>
        </div>
        <div class="srow">
            <div class="srow">
                <table>
                    <tr>
                        <th>Coupon #</th>
                        <th>Date</th>
                        <th>Property #</th>
                        <th>Discount %</th>
                        <th>Amount Due from Renter</th>
                        <th>Amount Due to Owner</th>
                        <th>My cost of the coupon</th>
                    </tr>
                    <% int coupon_use_pages = ds_use_coupons.Tables[0].Rows.Count;
                        int cu_pages = (coupon_use_pages + 9) / 10;
                        for (int cu_page = 0; cu_page < cu_pages; cu_page++)
                        {
                            int max_page = ((cu_page + 1) * 10 < coupon_use_pages) ? (cu_page + 1) * 10 : coupon_use_pages;
                            for (int cu_ind = cu_page * 10; cu_ind < max_page; cu_ind++)
                            {
                                var row = ds_use_coupons.Tables[0].Rows[cu_ind];
                                decimal mc_gross, mc_fee, renter_amt, owner_amt, my_cost;
                                int discount;
                                if (!int.TryParse(row["Discount"].ToString(), out discount)) discount = 0;
                                if (!decimal.TryParse(row["mc_gross"].ToString(), out mc_gross)) mc_gross = 0;
                                if (!decimal.TryParse(row["mc_fee"].ToString(), out mc_fee)) mc_fee = 0;
                                decimal   _total_sum = decimal.Parse(row["NightRate"].ToString());
                                decimal _lodgingval = _total_sum *decimal.Parse(row["LoadingTax"].ToString()) / 100;
                                decimal _balance = _lodgingval + decimal.Parse(row["CleaningFee"].ToString())
                                      + decimal.Parse(row["SecurityDeposit"].ToString());
                                decimal _total = _total_sum + _balance;
                                owner_amt = _total * 90 / 100;
                                my_cost = mc_gross - owner_amt;
                                %>
                                <tr class="cu_page<%=cu_page %>">
                                    <td><%=row["custom"] %></td>
                                    <td><%=row["payment_date"] %></td>
                                    <td><%=row["PropertyID"] %></td>
                                    <td><%=discount %></td>
                                    <td><%=BookDBProvider.DoFormat(mc_gross) %></td>
                                    <td><%=BookDBProvider.DoFormat(owner_amt) %></td>
                                    <td><%=BookDBProvider.DoFormat(my_cost) %></td>
                                </tr>

                            <%} %>
                        
                    <%} %>
                </table>
            </div>
            <div class="srow">
                <ul class="wwpages">
                    <li id="cuprev">&lt; |</li>
                    <% for (int p_ind = 0; p_ind < pages; p_ind++)
                        { %>
                    <li class="cu_page" id="_cupage<%=p_ind %>"><%=p_ind+1 %> |</li>


                    <%} %>
                    <li id="cunext">&gt;</li>
                </ul>
                <input type="hidden" id="cp_pages" value="<%=coupon_use_pages %>" />
            </div>
        </div>
    </div>
    <script defer="defer" src="/Assets/js/jqueryui112/jquery-ui.min.js"></script>
    <script defer="defer" src="/Assets/js/coupons.js"></script>
</form>
</asp:Content>