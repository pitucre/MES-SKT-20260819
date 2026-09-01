using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class InterfaceManagementView : BasePage
    {
        private int columnIndex_Rows = -1;
        private int columnIndex_Segment = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_Rows = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Rows")) + 1;
            columnIndex_Segment = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "Segment")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            int InterfaceManagementId = Convert.ToInt32(Request.QueryString["ID"]);
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ID";
            this.Master.DefaultSortExpression = "ID";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = "InterfaceManagementId =" + InterfaceManagementId + "";
            this.Master.SearchSettings = searchSettings;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        string id = Request.Form["hdnIdString"].ToString();
                        SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, "DELETE FROM Prod_InterfaceManagementDef WHERE ID IN (" + id + ")", null);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {

                        throw;
                    }


                }
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //1改为columnIndex_Rows
                //2改为columnIndex_Segment
                if (e.Row.Cells[columnIndex_Rows].Text == "-1")
                {
                    e.Row.Cells[columnIndex_Rows].Text = "*";
                }
                e.Row.Cells[columnIndex_Segment].Text = "第" + e.Row.Cells[columnIndex_Segment].Text + "段";
            }
        }
    }
}