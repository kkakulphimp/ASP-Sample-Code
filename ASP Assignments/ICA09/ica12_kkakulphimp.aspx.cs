using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    /// <summary>
    /// Page load handler
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillDropList("");
        }
    }
    /// <summary>
    /// Fills the DDL on a filter input
    /// </summary>
    /// <param name="input"></param>
    protected void FillDropList(string input)
    {
        SqlDataSource result = NorthwindAccess.GetSuppliersSDS(input);
        SupplierDDL.AppendDataBoundItems = true;
        SupplierDDL.DataSource = result;
        SupplierDDL.DataTextField = "CompanyName";
        SupplierDDL.DataValueField = "SupplierID";
        SupplierDDL.Items.Clear();
        SupplierDDL.DataBind();
        SupplierDDL.Items.Insert(0, new ListItem("Now pick a company from[" + SupplierDDL.Items.Count + "]"));
        SupplierDDL.AutoPostBack = true;
    }
    /// <summary>
    /// Calls filter with the textbox text on button click
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void FilterB_Click(object sender, EventArgs e)
    {
        FillDropList(FilterTB.Text);
    }
    /// <summary>
    /// Update the gridview when the
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SupplierDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (SupplierDDL.SelectedIndex <= 0)
            return;
        List<List<string>> results = NorthwindAccess.GetProducts(SupplierDDL.SelectedValue);
        if (results.Count <= 0)
            return;
        TableHeaderRow header = new TableHeaderRow();
        results[0].ForEach(x => header.Cells.Add(new TableHeaderCell() { Text = x }));
        ProductT.Rows.Add(header);
        foreach (List<string> item in results.Skip(1))
        {
            TableRow row = new TableRow();
            item.ForEach(x => row.Cells.Add(new TableCell() { Text = x }));
            ProductT.Rows.Add(row);
        }
    }
}