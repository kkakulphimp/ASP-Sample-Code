<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ica14_kkakulphimp.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
    <h2>ICA14 - Modify Order Details</h2>
    <hr />
    <h2>Part 1 - Delete Order Details</h2>
    Enter OrderID:
    <asp:TextBox runat="server" ID="Part1TB" />
    <asp:Button runat="server" ID="Part1Button" Text="Get Order Details" OnClick="Part1Button_Click"/>
    <asp:SqlDataSource runat="server" ID="Part1SDS" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT OD.OrderID, OD.ProductID, P.ProductName, OD.UnitPrice, OD.Quantity, OD.Discount FROM [Order Details] as OD inner join Products as P on OD.ProductID = P.ProductID WHERE ([OrderID] = @OrderID)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="Part1TB" Name="OrderID" PropertyName="Text" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView runat="server" ID="Part1GV" DataSourceID="Part1SDS" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Vertical" DataKeyNames="OrderID,ProductID" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="OrderID" HeaderText="OrderID" SortExpression="OrderID" ReadOnly="True" />
<%--            <asp:BoundField DataField="ProductID" HeaderText="ProductID" SortExpression="ProductID" ReadOnly="True" />--%>
            <asp:BoundField DataField="ProductName" HeaderText="ProductName" SortExpression="ProductName" />
            <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" />
            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
            <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" />
        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
        <RowStyle BackColor="#F7F7DE" />
        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#FBFBF2" />
        <SortedAscendingHeaderStyle BackColor="#848384" />
        <SortedDescendingCellStyle BackColor="#EAEAD3" />
        <SortedDescendingHeaderStyle BackColor="#575357" />
    </asp:GridView>
    <br />
    <asp:Button ID="Part1DeleteButton" runat="server" Text="Delete Selected" OnClick="Part1DeleteButton_Click"/>
    <br />
    <asp:Label ID="Part1Label" runat="server" Text="Status: " />
    <h2>Part II - Insert Order Details</h2>
    Enter OrderID:
    <asp:TextBox ID="Part2TBOrderID" runat="server" />
    <br />
    <asp:SqlDataSource runat="server" ID="Part2SDSProducts" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName] FROM [Products] ORDER BY [ProductName]" />
    Enter Product:
    <asp:DropDownList ID="Part2DDL" runat="server" DataSourceID="Part2SDSProducts" DataTextField="ProductName" DataValueField="ProductID" />
    <br />
    Enter Quantity:
    <asp:TextBox ID="Part2TBQuantity" runat="server" />
    <br />
    <asp:Button ID="Part2Button" runat="server" Text="Insert Record" OnClick="Part2Button_Click" />
    <br />
    <asp:Label ID="Part2Label" runat="server" Text="Status: " />
</asp:Content>

