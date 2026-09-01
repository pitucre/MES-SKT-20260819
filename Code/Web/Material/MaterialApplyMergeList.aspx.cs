using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialApplyMergeList : BasePage
    {
        private int columnIndex_Statue = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Statue = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Statue")) + 1;

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MergeId";
            this.Master.DefaultSortExpression = "CreateDateTime desc"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("MergeApplyNo", txtMergeApplyNo.Text.Trim());
            searchSettings.AddCondition("ApplyNo", txtApplyNo.Text.Trim());


            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Material.BLL.Apply bll = new SKT.LeanMES.Material.BLL.Apply();
                        bll.CancelMerge(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage("取消合并成功！");
                    }
                    catch (Exception err)
                    {
                        WebHelper.ShowMessage(err.Message.ToString());
                    }

                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    //xiang.yan 2024-4-23 cells取值改为根据列名获取
                    //4改为columnIndex_Statue
                    if (e.Row.Cells[columnIndex_Statue].Text == "1")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已备料";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "2")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已交接";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "3")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "已退料";
                    }
                    else if (e.Row.Cells[columnIndex_Statue].Text == "4")
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "备料中";
                    }
                    else
                    {
                        e.Row.Cells[columnIndex_Statue].Text = "待备料";
                    }
                }
                catch { }
            }
        }
    }
}