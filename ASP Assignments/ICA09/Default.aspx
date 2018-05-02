<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <div>
        <asp:PlaceHolder 
            ID="hyperlinkPlaceholder"
            Runat="server"
            ></asp:PlaceHolder>
    </div>
</asp:Content>