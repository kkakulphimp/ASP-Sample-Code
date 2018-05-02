<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ica12_kkakulphimp.aspx.cs" Inherits="Default2" Theme="ADO" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <h2>ICA12 - ADO Part 1 - Basic Queries</h2>
    <div>
        Pick a Supplier:
        <asp:DropDownList ID="SupplierDDL" runat="server" OnSelectedIndexChanged="SupplierDDL_SelectedIndexChanged" />
        <asp:TextBox ID="FilterTB" runat="server" />
        <asp:Button ID="FilterB" runat="server" Text="Filter" OnClick="FilterB_Click" />
    </div>
    <hr />
    <div>
        <asp:Table ID="ProductT" runat="server">
        </asp:Table>
    </div>
</asp:Content>

