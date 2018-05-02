using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dropDown.AutoPostBack = true;
            dropDown.AppendDataBoundItems = true;
            dropDown.AppendDataBoundItems = true;
            dropDown.Items.Add(new ListItem("Pick a customer"));
            
        }
    }

    protected void dropDown_SelectedIndexChanged(object sender, EventArgs e)
    {
        DetailsListView.SelectedIndex = -1;
    }
}