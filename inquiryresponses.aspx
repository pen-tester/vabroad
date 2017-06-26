<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/masterpage/masterMobile.master" CodeFile="inquiryresponses.aspx.cs" Inherits="inquiryresponses" %>
<asp:Content ID="head" ContentPlaceHolderID="head" runat="server">
    Inquriry Response
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
<asp:Content ID="content" ContentPlaceHolderID="bodycontent" runat="server">
<form id="mainform" runat="server">
        <div class="scontainer">
    <div class="srow">
        <div class="col-1">

        </div>
        <div class="col-10">
            <table>
        <tr>
            <th>Property#</th>
            <th>Date of Inquiry</th>
            <th>Date of Arrival</th>
            <th>Traveler's Name</th>
            <th>Traveler's Phone</th>
            <th>Traveler's Email</th>
            <th>Owner Responded</th>
            <th>Property Booked</th>
        </tr>
                <% int counts = ds_quotes.Tables[0].Rows.Count;
                    for (int ind = 0; ind < counts; ind++)
                    {
                        var row = ds_quotes.Tables[0].Rows[ind];
                        int propertyid = Int32.Parse(row["PropertyID"].ToString());
                        PropertyDetailInfo propinfo = AjaxProvider.getPropertyDetailInfo(propertyid);
                        string url = String.Format("https://www.vacations-abroad.com/{0}/{1}/{2}/{3}/default.aspx", propinfo.Country, propinfo.StateProvince, propinfo.City, propinfo.ID).ToLower().Replace(" ", "_");
                        int replied, quoted;
                        if (!Int32.TryParse(row["IfReplied"].ToString(), out replied)) replied = 0;
                        if (!Int32.TryParse(row["IsQuoted"].ToString(), out quoted)) quoted = 0;
                        string ans_rep = (replied == 1) ? "Yes" : "No";
                        string ans_quot = (quoted == 1) ? "Yes" : "No";
                         %>
                     <tr>
                         <td><a href="<%=url %>"><%=propertyid %></a></td>
                         <td><%=DateTime.Parse(row["SentTime"].ToString()).ToString("MMM d, yyyy") %></td>
                         <td><%=DateTime.Parse(row["ArrivalDate"].ToString()).ToString("MMM d, yyyy") %></td>
                         <td><%=row["ContactorName"] %></td>
                         <td><%=row["Telephone"] %></td>
                         <td><%=row["ContactorEmail"] %></td>
                         <td><%=ans_rep%></td>
                         <td><%=ans_quot%></td>
                     </tr>
                <%} %>
    </table>
        </div>
    </div>
            </div>
</form>
</asp:Content>

