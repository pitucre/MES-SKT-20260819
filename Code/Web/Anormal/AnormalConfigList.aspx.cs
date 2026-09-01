using System;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data;
using System.Reflection;
using SKT.Common.Model;
using System.Web.UI;
using System.Linq;

namespace SKT.LeanMES.Web.Anormal
{
    public partial class AnormalConfigList : BasePage
    {
        private int columnIndex_SendWay = -1;
        private int columnIndex_ModifyBy = -1;
        private int columnIndex_ModifyDateTime = -1;
        SKT.Common.Model.SearchSettings searchSettings;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_SendWay = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "SendWay")) + 1;
            columnIndex_ModifyBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyBy")) + 1;
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "AnormalConfigID";
            this.Master.DefaultSortExpression = "AnormalConfigID";
            this.Master.DefaultSortDirection = SortDirection.Descending;

            searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("AnormalTypeName", Server.HtmlEncode(this.txtAnormalTypeName.Text));
            if (this.ddlSendWay.SelectedValue != "-1") {
                searchSettings.AddCondition("SendWay", Server.HtmlEncode(this.ddlSendWay.SelectedValue));
            }

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;


            if (Request.Form["hdnOperate"] != null && Request.Form["hdnOperate"].ToLower() == "delete")
            {
                var userName = AccountController.GetCurrentUser().UserName;
                try
                {
                    ProdAnormal.BLL.AnormalConfig bll = new ProdAnormal.BLL.AnormalConfig();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(userName, ex, true);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_SendWay
                //7改为columnIndex_ModifyBy
                //8改为columnIndex_ModifyDateTime
                var SendWay = e.Row.Cells[columnIndex_SendWay].Text;
                switch (SendWay)
                {
                    case "1":
                        e.Row.Cells[columnIndex_SendWay].Text = "邮件发送";
                        break;
                    case "2":
                        e.Row.Cells[columnIndex_SendWay].Text = "微信发送";
                        break;
                    default:
                        break;
                }

                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyBy].Text) || e.Row.Cells[columnIndex_ModifyBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
            }
        }

    }
}