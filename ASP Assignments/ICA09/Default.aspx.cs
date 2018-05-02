using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DirectoryInfo directoryInfo = new DirectoryInfo(MapPath(""));
            FileInfo[] files = directoryInfo.GetFiles();
            foreach (FileInfo item in files)
            {
                if (item.Extension.Equals(".aspx"))
                {
                    HyperLink temp = new HyperLink();
                    temp.NavigateUrl = item.Name;
                    temp.Text = item.Name + "</br>";
                    hyperlinkPlaceholder.Controls.Add(temp);
                }
            }
        }
        catch
        {

        }
    }
}