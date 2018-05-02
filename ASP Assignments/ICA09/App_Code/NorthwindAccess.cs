using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

/// <summary>
/// Summary description for NorthwindAccess
/// </summary>
public static class NorthwindAccess
{
    /// <summary>
    /// Get suppliers, filter on company name
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public static SqlDataSource GetSuppliersSDS(string input)
    {
        string query = "select * from suppliers where companyname like " + "'%" + input + "%'";
        SqlDataSource sds = new SqlDataSource(
            ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString,
            query);
        return sds;
    }
    /// <summary>
    /// Get products matchign supplierID, fill list of list of string as a table
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public static List<List<string>> GetProducts(string input)
    {
        List<List<string>> ListList = new List<List<string>>();
        string query = "select productname as 'Product Name', quantityperunit as 'Quantity Per Unit', unitsinstock as 'Units In Stock' from products where supplierID =" + input;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = command.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
                if (!reader.HasRows) return ListList;
                List<string> header = new List<string>();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    header.Add(reader.GetName(i));
                }
                ListList.Add(header);
                while (reader.Read())
                {
                    List<string> row = new List<string>();
                    for (int i = 0; i < header.Count; i++)
                    {
                        row.Add(reader[header[i]].ToString());
                    }
                    ListList.Add(row);
                }
            }
        }
        return ListList;
    }
    /// <summary>
    /// Fill a dropdownlist with customers
    /// </summary>
    /// <param name="companyName"></param>
    /// <param name="DDL"></param>
    public static void FillCustomersDDL(string companyName, DropDownList DDL)
    {
        string query = "exec GetCustomers " + companyName;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString);
        SqlCommand command = new SqlCommand(query, con);
        con.Open();
        DDL.DataSource = command.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        DDL.DataTextField = "CompanyName";
        DDL.DataValueField = "CustomerID";
        DDL.Items.Clear();
        DDL.DataBind();
        DDL.Items.Insert(0, new ListItem("Please Pick One", ""));
        DDL.AutoPostBack = true;
    }
    /// <summary>
    /// Execute the stored procedure with customerID, get back the reader with the data
    /// </summary>
    /// <param name="customerID"></param>
    /// <returns></returns>
    public static SqlDataReader CustomerCategorySummary(string customerID)
    {
        string query = "exec CustCatSummary '" + customerID + "'";
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString);
        SqlCommand command = new SqlCommand(query, con);
        con.Open();
        return command.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
    }
    /// <summary>
    /// Inserts into the order details executing a stored procedure requiring orderID, productID and quanitity, the discount is default 0 and there's no provisions to change that in copde currently
    /// </summary>
    /// <param name="OID"></param>
    /// <param name="PID"></param>
    /// <param name="Quantity"></param>
    /// <returns></returns>
    public static string InsertOrderDetails(int OID, int PID, short Quantity)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString))
        {
            using (SqlCommand command = new SqlCommand("InsertOrderDetails", conn))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@OrderID", OID));
                command.Parameters.Add(new SqlParameter("@ProductID", PID));
                command.Parameters.Add(new SqlParameter("Quantity", Quantity));
                SqlParameter returnVal = new SqlParameter("@rows", 0);
                returnVal.Direction = ParameterDirection.ReturnValue;
                command.Parameters.Add(returnVal);
                conn.Open();
                command.ExecuteNonQuery();
                return "Inserted: " + returnVal.Value.ToString() + " rows";
            }
        }
    }
}