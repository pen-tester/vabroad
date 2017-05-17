<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="/masterpage/mastermobile.master" CodeFile="treeview.aspx.cs" Inherits="treeview" %>
<asp:Content ID="body" ContentPlaceHolderID="bodycontent" runat="server">
        <div class="scontainer">
       <div>        
        
        <asp:TreeView ID="TreeView1" runat="server" 
            onselectednodechanged="TreeView1_SelectedNodeChanged" 
            ShowExpandCollapse="False">
            <Nodes>                
            </Nodes>
        </asp:TreeView>
    </div>
            </div>
</asp:Content>