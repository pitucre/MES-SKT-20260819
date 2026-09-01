using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class FloorLineInfoList : BasePage
    {
        private int columnIndex_ModifyDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyDateTime")) + 1;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FLId";
            this.Master.DefaultSortExpression = "FLId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("FName", txtFName.Text);
            searchSettings.AddCondition("LineName", txtLineName.Text);
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Container.BLL.FloorLineInfo bll = new SKT.LeanMES.Container.BLL.FloorLineInfo();
                    bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                    WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //6改为columnIndex_ModifyDateTime
                if (e.Row.Cells[columnIndex_ModifyDateTime].Text == "9999/12/31 0:00:00" || e.Row.Cells[columnIndex_ModifyDateTime].Text == "0001/1/1 0:00:00")
                {
                    e.Row.Cells[columnIndex_ModifyDateTime].Text = "";
                }
            }
        }
    }
}