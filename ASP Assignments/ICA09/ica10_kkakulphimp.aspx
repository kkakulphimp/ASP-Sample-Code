<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ica10_kkakulphimp.aspx.cs" Inherits="Default2" Theme="ADO"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="Server">
    <h2>ICA10 - Data Aware Controls</h2>
    <div class="container">
        <asp:Button runat="server" Text="Show Products" ID="productsButton" OnClick="productsButton_Click" />
        <asp:Button runat="server" Text="Edit Employees" ID="employeesButton" OnClick="employeesButton_Click" />
        <asp:MultiView ID="multiview" runat="server">
            <asp:View ID="view1" runat="server">
                <asp:SqlDataSource runat="server" ID="productsdatasource" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT [ProductName], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued], [CategoryName] FROM [Alphabetical list of products] ORDER BY [ProductName]"></asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="productsdatasource" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" >
                        <HeaderStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="QuantityPerUnit" HeaderText="Quantity Per Unit" SortExpression="QuantityPerUnit" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="Unit Price" SortExpression="UnitPrice" DataFormatString="{0:c}" />
                        <asp:BoundField DataField="UnitsInStock" HeaderText="Units In Stock" SortExpression="UnitsInStock" />
                        <asp:BoundField DataField="UnitsOnOrder" HeaderText="Units On Order" SortExpression="UnitsOnOrder" />
                        <asp:BoundField DataField="ReorderLevel" HeaderText="Reorder Level" SortExpression="ReorderLevel" />
                        <asp:CheckBoxField DataField="Discontinued" HeaderText="Discontinued" SortExpression="Discontinued" />
                        <asp:BoundField DataField="CategoryName" HeaderText="Category Name" SortExpression="CategoryName" />
                    </Columns>
                </asp:GridView>
            </asp:View>
            <asp:View ID="view2" runat="server">
                <asp:SqlDataSource runat="server" ID="employeesdatasource" ConnectionString="<%$ ConnectionStrings:kkakulphimp1_NorthwindNewConnectionString %>" SelectCommand="SELECT [EmployeeID], [LastName], [FirstName], [Title], [HireDate], [City], [Address], [Country] FROM [Employees]" DeleteCommand="DELETE FROM [Employees] WHERE [EmployeeID] = @EmployeeID" InsertCommand="INSERT INTO [Employees] ([LastName], [FirstName], [Title], [HireDate], [City], [Address], [Country]) VALUES (@LastName, @FirstName, @Title, @HireDate, @City, @Address, @Country)" UpdateCommand="UPDATE [Employees] SET [LastName] = @LastName, [FirstName] = @FirstName, [Title] = @Title, [HireDate] = @HireDate, [City] = @City, [Address] = @Address, [Country] = @Country WHERE [EmployeeID] = @EmployeeID">
                    <DeleteParameters>
                        <asp:Parameter Name="EmployeeID" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="Title" Type="String" />
                        <asp:Parameter Name="HireDate" Type="DateTime" />
                        <asp:Parameter Name="City" Type="String" />
                        <asp:Parameter Name="Address" Type="String" />
                        <asp:Parameter Name="Country" Type="String" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="Title" Type="String" />
                        <asp:Parameter Name="HireDate" Type="DateTime" />
                        <asp:Parameter Name="City" Type="String" />
                        <asp:Parameter Name="Address" Type="String" />
                        <asp:Parameter Name="Country" Type="String" />
                        <asp:Parameter Name="EmployeeID" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView2" runat="server" DataSourceID="employeesdatasource" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="EmployeeID">
                    <Columns>
                        <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                        <asp:BoundField DataField="EmployeeID" HeaderText="Employee ID" SortExpression="EmployeeID" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                        <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName" />
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="HireDate" DataFormatString="{0:d}" HeaderText="Hire Date" SortExpression="HireDate" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                        <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                    </Columns>
                </asp:GridView>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
