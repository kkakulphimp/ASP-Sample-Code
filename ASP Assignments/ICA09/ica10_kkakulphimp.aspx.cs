using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Drawing;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void productsButton_Click(object sender, EventArgs e)
    {
        multiview.ActiveViewIndex = 0;
    }

    protected void employeesButton_Click(object sender, EventArgs e)
    {
        multiview.ActiveViewIndex = 1;
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e == null || e.Row == null || e.Row.DataItem == null)
        {
            return;
        }
        DataRowView drv = e.Row.DataItem as DataRowView;
        decimal price = decimal.Parse(drv["unitprice"].ToString());
        decimal units = decimal.Parse(drv["unitsinstock"].ToString());
        if (units < 25)
        {
            e.Row.BackColor = Color.LightSalmon;
        }
        int order;
        int.TryParse(drv["unitsonorder"].ToString(), out order);
        if (units < 20 && order < 5)
        {
            e.Row.BackColor = Color.Cyan;
            e.Row.Cells[3].BackColor = Color.GreenYellow;
        }
        if (price > 25)
        {
            e.Row.Cells[2].BackColor = Color.Yellow;
        }
        foreach (TableCell item in e.Row.Cells)
        {
            double doesntMatter = 0;
            if (double.TryParse(item.Text, out doesntMatter))
            {
                item.HorizontalAlign = HorizontalAlign.Right;
            }
        }
    }
}