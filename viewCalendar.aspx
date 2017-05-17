<%@ Page Title="" Language="C#" MasterPageFile="/masterpage/MasterMobile.master" AutoEventWireup="true"
    CodeFile="viewCalendar.aspx.cs" Inherits="viewCalendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="bodycontent" runat="Server">
        <div class="scontainer">
<div class="internalpage">
    <div class="srow">
        <div style="height:300px">
<center>
    <asp:Calendar ID="Calendar1" runat="server" SelectionMode="Day" OnDayRender="Calendar1_DayRender"
        EnableViewState="False" SelectedDayStyle-ForeColor="Black"
        SelectedDayStyle-BackColor="Red" CellSpacing="2" CellPadding="2" CssClass="Calendar">
        <NextPrevStyle CssClass="CalendarNext" />
        <TitleStyle CssClass="CalendarTitle" />
    </asp:Calendar>
    <asp:Label ID="lblLinks" runat="server"></asp:Label>
    <asp:HyperLink ID="hlkCountry" runat="server"></asp:HyperLink>, 
    <asp:HyperLink ID="hlkState" runat="server"></asp:HyperLink>, 
    <asp:HyperLink ID="hlkCity" runat="server"></asp:HyperLink>, 
    <asp:HyperLink ID="hlkProperty" runat="server"></asp:HyperLink>
    </center>
    <asp:Label ID="lblInfo" runat="server"></asp:Label>
    </div>
    </div>
</div>
            </div>
</asp:Content>
