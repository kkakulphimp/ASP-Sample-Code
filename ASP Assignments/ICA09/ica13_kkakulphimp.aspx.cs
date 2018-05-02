using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    /// <summary>
    /// Page load handler, will make sure DDL has all customers
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NorthwindAccess.FillCustomersDDL("", CustDDL);
        }
        else
        {
        }
    }
    /// <summary>
    /// Updates the DDL with filter
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CustBut_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(CustTB.Text))
        {
            NorthwindAccess.FillCustomersDDL(CustTB.Text, CustDDL);
        }
    }
    /// <summary>
    /// When the selected index changes, update GV, make sure the first index clears the GV
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CustDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (CustDDL.SelectedIndex > 0)
        {
            CustGV.DataSource = NorthwindAccess.CustomerCategorySummary(CustDDL.SelectedValue);
            CustGV.DataBind();
        }
        else
        {
            CustGV.DataSource = null;
            CustGV.DataBind();
        }
    }
    /// <summary>
    /// When data comes in make sure the cells are aligned properly
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CustGV_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
        e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
    }
}