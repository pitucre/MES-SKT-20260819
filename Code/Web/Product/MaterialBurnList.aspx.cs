using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Molding.BLL;

namespace SKT.LeanMES.Web.Product
{
    public partial class MaterialBurnList : BasePage
    {
        private int columnIndex_ModifyByName = -1;
        private int columnIndex_ModifyTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_ModifyByName = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyByName")) + 1;
            columnIndex_ModifyTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ModifyTime")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "BurnId";
            this.Master.DefaultSortExpression = "BurnId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("Status", "1");
            if (txtSoftName.Text.Trim() != "")
            {
                searchSettings.AddCondition("SoftName", txtSoftName.Text.Trim());
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        MaterialBurn bll = new MaterialBurn();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch(Exception ex)
                    {
                        WebHelper.ShowMessage(ex.Message);
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //14改为columnIndex_ModifyByName
                //15改为columnIndex_ModifyTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_ModifyByName].Text) || e.Row.Cells[columnIndex_ModifyByName].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_ModifyTime].Text = "";
            }
        }
    }
}