<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/masterpage/MasterMobile.master" CodeFile="ReserveList.aspx.cs" Inherits="ReserveList" %>
<asp:Content ID="title" ContentPlaceHolderID="head" runat="server">
    Reserve Payment List
</asp:Content>
<asp:Content ID="links" ContentPlaceHolderID="links" runat="server">
    <style>
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
    </style>

</asp:Content>
<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
<form id="mainform" runat="server">
        <div class="scontainer">
    <div class="col-1"></div>
    <div class="col-10">
        <div class="srow">
            <table>
        <tr>
            <th>
                Inv#
            </th>
            <th>
                Inv Date
            </th>
            <th>
                Inv Amt
            </th>
            <th>
                Property #
            </th>
            <th>
                Payment Date
            </th>
            <th>
                Reservation Amt
            </th>
            <th>
                Amt sent to Owner
            </th>
            <th>
                Commission
            </th>
            <th>
                Currency
            </th>
        </tr>
                <% int counts = ds_payment.Tables[0].Rows.Count;

                    for (int rows = 0; rows < counts; rows++)
                    {
                        var row = ds_payment.Tables[0].Rows[rows];
                        decimal amt = Decimal.Parse(row["mc_gross"].ToString());
                        decimal fee = Decimal.Parse(row["mc_fee"].ToString());
                        int propertyid = Int32.Parse(row["PropertyID"].ToString());
                        
                        PropertyDetailInfo propinfo = AjaxProvider.getPropertyDetailInfo(propertyid);
                        string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", propinfo.Country, propinfo.StateProvince, propinfo.City, propinfo.ID).ToLower().Replace(" ","_");
                     %>
                    <tr>
                        <td>
                            <%=(rows+1) %>
                        </td>
                        <td>
                            <%=DateTime.Parse(row["DateReplied"].ToString()).ToString("MMM d, yyyy") %>
                        </td>
                        <td>
                            <%=row["mc_gross"] %>
                        </td>
                        <td>
                            <a href="<%=url %>">
                            <%=row["PropertyID"] %>
                             </a>
                        </td>
                        <td>
                            <%=row["payment_date"] %>
                        </td>
                        <td>
                            <%=BookDBProvider.DoFormat(amt-fee) %>
                        </td>
                        <td>
                            <%=BookDBProvider.DoFormat((amt-fee)*0.85m) %>
                        </td>
                        <td>
                            <%=BookDBProvider.DoFormat((amt-fee)*0.15m) %>
                        </td>
                        <td>
                            <%=row["mc_currency"] %>
                        </td>
                    </tr>


                <%} %>
    </table>
        </div>
    </div>
            </div>
</form>
</asp:Content>