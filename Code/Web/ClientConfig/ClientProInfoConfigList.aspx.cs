using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.ClientConfig
{
    public partial class ClientProInfoConfigList : BasePage
    {
        private int col1 = -1;
        private int col2 = -1;
        private int col3 = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            col1 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "IsDisplay")) + 1;
            col2 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "InfoType")) + 1;
            col3 = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "DisplayStyle")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxClientConfig));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ClientProInfoConfigId";
            this.Master.DefaultSortExpression = "ClientProInfoConfigId DESC"; 

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            if (this.txtInfoName.Text.Trim().Length > 0)
            {
                searchSettings.AddCondition("InfoName", this.txtInfoName.Text.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig bll = new SKT.LeanMES.ClientConfig.BLL.ClientProInfoConfig();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }

        string[] infoTypes = new string[] { "","产品信息","生产计数"};
        string[] displayStyles = new string[] { "", "普通Span样式", "Textarea样式" };
        System.Drawing.Color[] colors = new System.Drawing.Color[] { System.Drawing.Color.Blue, System.Drawing.Color.Blue, System.Drawing.Color.Black };
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang,yan 2024-4-23 col1 = 3;，col2 = 4;，col3 = 5;改为根据列名获取
                //显示状态
                if (e.Row.Cells[col1].Text.ToLower() == "true")
                {
                    e.Row.Cells[col1].Text = "显示";
                }
                else
                {
                    e.Row.Cells[col1].Text = "隐藏";
                    e.Row.Cells[col1].ForeColor = System.Drawing.Color.Red;
                }

                int infotype = Convert.ToInt32(e.Row.Cells[col2].Text);
                e.Row.Cells[col2].Text = infoTypes[infotype];
                e.Row.Cells[col2].ForeColor = colors[infotype];

                int displaystyle = Convert.ToInt32(e.Row.Cells[col3].Text);
                e.Row.Cells[col3].Text = displayStyles[displaystyle];
                e.Row.Cells[col3].ForeColor = colors[displaystyle];

            }
        }
    }
}