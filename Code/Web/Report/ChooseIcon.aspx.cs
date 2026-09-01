using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

namespace SKT.LeanMES.Web.Report
{
    public partial class ChooseIcon : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindIcon();
            }
        }

        /// <summary>
        /// 绑定图标到Gridview
        /// </summary>
        protected void BindIcon()
        {
            this.GridView1.DataSource = GetAllIcon();
            this.GridView1.DataBind();
        }

        /// <summary>
        /// 列出图标文件夹下的所有图标
        /// </summary>
        /// <returns></returns>
        private DataTable GetAllIcon()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Icon");
            string iconPath = "../Content/Theme/Metro/Images/Icon";
            DataRow dr = null;

            foreach (string icon in Directory.GetFiles(Server.MapPath(iconPath), "*", SearchOption.TopDirectoryOnly))
            {
                FileInfo fileInfo = new FileInfo(icon);
                dr = dt.NewRow();
                dr["Icon"] = iconPath + "/" + fileInfo.Name;
                dt.Rows.Add(dr);
            }

            return dt;
        }

        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string icon = e.Row.Cells[0].Text;
                e.Row.Cells[0].Text = "<img src=\"" + e.Row.Cells[0].Text + "\" width=\"16px\" height=\"16px\"/>";
                string iconName = icon.Substring(icon.LastIndexOf("/") + 1, icon.Length - icon.LastIndexOf("/") - 1);
                e.Row.Cells[1].Text = "<a href='javascript:void(0)' onclick=\"chooseIcon('" + icon + "','" + iconName + "');\">" + Resources.lang.ChooseIcon + "</a>";
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.GridView1.PageIndex = e.NewPageIndex;
            BindIcon();
        }

    }
}