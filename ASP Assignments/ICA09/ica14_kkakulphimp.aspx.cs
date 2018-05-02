using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Default2 : System.Web.UI.Page
{
    /// <summary>
    /// Nothing really happening here
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
        }
        else
        {
            int thing;
            if (!int.TryParse(Part1TB.Text, out thing))
            {
                Part1TB.Text = "";
            }
        }
    }
    /// <summary>
    /// Update GV button with customer
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Part1Button_Click(object sender, EventArgs e)
    {
        Part1GV.DataBind();
    }
    /// <summary>
    /// Delete handler, this was meant to be outside of the northwindaccess file
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Part1DeleteButton_Click(object sender, EventArgs e)
    {
        if (Part1GV.SelectedIndex >= 0)
        {
            
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["kkakulphimp1_NorthwindNewConnectionString"].ConnectionString))
            {
                using (SqlCommand command = new SqlCommand("DeleteOrderDetails", conn))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@orderID", Part1GV.SelectedDataKey["OrderID"]));
                    command.Parameters.Add(new SqlParameter("@productID", Part1GV.SelectedDataKey["ProductID"]));
                    SqlParameter outputString = new SqlParameter("@status", SqlDbType.VarChar, 80);
                    outputString.Direction = ParameterDirection.Output;
                    command.Parameters.Add(outputString);
                    conn.Open();
                    command.ExecuteNonQuery();
                    Part1Label.Text = "Status: " + outputString.Value.ToString();
                    Part1GV.SelectedIndex = -1;
                    Part1GV.DataBind();
                }
            }
        }
    }
    /// <summary>
    /// Handle insertions, calls northwindaccess static function, handles errors in case it catches an exception
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Part2Button_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Part2TBOrderID.Text) && !string.IsNullOrEmpty(Part2TBQuantity.Text))
        {
            try
            {
                Part2Label.Text = "Status: " + NorthwindAccess.InsertOrderDetails(int.Parse(Part2TBOrderID.Text), int.Parse(Part2DDL.SelectedValue), short.Parse(Part2TBQuantity.Text));
                Part1TB.Text = Part2TBOrderID.Text;
                Part1GV.DataBind();
            }
            catch(Exception error)
            {
                Part2Label.Text = "Status " + error.Message;
            }

        }
    }
}