<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ica11_kkakulphimp.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" Runat="Server">
        <h2>ICA11 - More Data Aware Controls</h2>
    <asp:SqlDataSource runat="server" ID="SDSCust" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT [CustomerID], [CompanyName], [ContactName] FROM [Customers]">
        </asp:SqlDataSource>
    <asp:DropDownList runat="server" ID="dropDown" AutoPostBack="True" DataSourceID="SDSCust" DataTextField="CompanyName" DataValueField="CustomerID" OnSelectedIndexChanged="dropDown_SelectedIndexChanged"/>
    <asp:SqlDataSource runat="server" ID="SDSOrders" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" DeleteCommand="DELETE FROM [Orders] WHERE [OrderID] = @OrderID" InsertCommand="INSERT INTO [Orders] ([CustomerID], [OrderDate]) VALUES (@CustomerID, @OrderDate)" SelectCommand="SELECT [OrderID], [CustomerID], [OrderDate] FROM [Orders] WHERE ([CustomerID] = @CustomerID)" UpdateCommand="UPDATE [Orders] SET [CustomerID] = @CustomerID, [OrderDate] = @OrderDate WHERE [OrderID] = @OrderID" >
        <DeleteParameters>
            <asp:Parameter Name="OrderID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="String" />
            <asp:Parameter Name="OrderDate" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="dropDown" Name="CustomerID" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="String" />
            <asp:Parameter Name="OrderDate" Type="DateTime" />
            <asp:Parameter Name="OrderID" Type="Int32" />
        </UpdateParameters>
        </asp:SqlDataSource>
    <asp:ListView ID="DetailsListView" runat="server" DataKeyNames="OrderID" DataSourceID="SDSOrders" InsertItemPosition="LastItem" AutoPostBack="true">
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="SelectButton" runat="server" CommandName="Select" Text="Select" />
                </td>
                <td>
                    <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                </td>
                <td>
                    <asp:Label ID="CustomerIDLabel" runat="server" Text='<%# Eval("CustomerID") %>' />
                </td>
                <td>
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate", "{0:dd MMM yyyy}") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                </td>
                <td>
                    <asp:Label ID="OrderIDLabel1" runat="server" Text='<%# Eval("OrderID") %>' />
                </td>
                <td>
<%--                    <asp:TextBox ID="CustomerIDTextBox" runat="server" Text='<%# Bind("CustomerID") %>' />--%>
                        <asp:DropDownList ID="InsertCust" runat="server" DataSourceID="SDSCust" DataTextField="CompanyName" DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>'/>
                </td>
                <td>
                    <asp:TextBox ID="OrderDateTextBox" runat="server" Text='<%# Bind("OrderDate") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                </td>
                <td>&nbsp;</td>
                <td>
<%--                    <asp:TextBox ID="CustomerIDTextBox" runat="server" Text='<%# Bind("CustomerID") %>' />--%>
                    <asp:DropDownList ID="InsertCust" runat="server" DataSourceID="SDSCust" DataTextField="CompanyName" DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>'/>
                </td>
                <td>
                    <%--<asp:TextBox ID="OrderDateTextBox" runat="server" Text='<%# Bind("OrderDate") %>' />--%>
                    <asp:Calendar ID="OrderDateCalendar" runat="server" SelectedDate='<%# Bind("OrderDate") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                    <asp:Button ID="SelectButton" runat="server" CommandName="Select" Text="Select" />
                </td>
                <td>
                    <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                </td>
                <td>
                    <asp:Label ID="CustomerIDLabel" runat="server" Text='<%# Eval("CustomerID") %>' />
                </td>
                <td>
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                            <tr runat="server" style="">
                                <th runat="server"></th>
                                <th runat="server">OrderID</th>
                                <th runat="server">CustomerID</th>
                                <th runat="server">OrderDate</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                <td>
                    <asp:Label ID="OrderIDLabel" runat="server" Text='<%# Eval("OrderID") %>' />
                </td>
                <td>
                    <asp:Label ID="CustomerIDLabel" runat="server" Text='<%# Eval("CustomerID") %>' />
                </td>
                <td>
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
        </asp:ListView>
    <asp:SqlDataSource runat="server" ID="SDSDetails" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="select OD.OrderID as 'Order ID', C.CategoryID as 'Category ID', C.CategoryName as 'Category Name', SUM(P.UnitPrice * Quantity)  from
Products as P
inner join [Order Details] as OD
on P.ProductID = OD.ProductID
inner join [Categories] as C
on P.CategoryID = C.CategoryID
inner join [Orders] as O
on O.OrderID = OD.OrderID
WHERE (OD.OrderID = @OrderID)
group by 
OD.OrderID, C.CategoryID, C.CategoryName" >
        <SelectParameters>
            <asp:ControlParameter ControlID="DetailsListView" Name="OrderID" PropertyName="SelectedValue" />
        </SelectParameters>
        </asp:SqlDataSource>
    <asp:DetailsView runat="server" ID="DetailsView" DataSourceID="SDSDetails" AutoGenerateRows="False" DataKeyNames="Category ID" CellPadding="4" ForeColor="#333333" GridLines="None" >
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#FFFFC0" Font-Bold="True" />
        <FieldHeaderStyle BackColor="#FFFF99" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="Order ID" HeaderText="Order ID" SortExpression="Order ID" />
            <asp:BoundField DataField="Category ID" HeaderText="Category ID" InsertVisible="False" ReadOnly="True" SortExpression="Category ID" />
            <asp:BoundField DataField="Category Name" HeaderText="Category Name" SortExpression="Category Name" />
            <asp:BoundField DataField="Column1" HeaderText="Category Sum" ReadOnly="True" SortExpression="Column1" DataFormatString="{0:C}" />
        </Fields>
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <HeaderTemplate>
            Summary Category Details View
        </HeaderTemplate>
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        </asp:DetailsView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT [ProductID], [ProductName], [SupplierID] FROM [Alphabetical list of products]"></asp:SqlDataSource>
    </asp:Content>