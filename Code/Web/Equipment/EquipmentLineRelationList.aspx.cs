using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentLineRelationList : BasePage
    {
        private int columnIndex_UpdateBy = -1;
        private int columnIndex_UpdateDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_UpdateBy = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UpdateBy")) + 1;
            columnIndex_UpdateDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "UpdateDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipmentLineRelation));

            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "EquipmentLineId";
            this.Master.DefaultSortExpression = "EquipmentLineId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            this.Master.SearchSettings = searchSettings;
            //searchSettings.ExtensionCondition = "  EquipmentLineType like'%" + txtMachineType.Value + "%'";
            searchSettings.AddCondition("EquipmentLineType", txtMachineType.Value);
            searchSettings.AddCondition("EquipmentLineDisplayName", txtName.Value);
            this.GridView1.PageIndex = 0;
            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    try
                    {
                        SKT.LeanMES.Equipment.BLL.EquipmentLineRelation bll = new SKT.LeanMES.Equipment.BLL.EquipmentLineRelation();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), AccountController.GetCurrentUser().UserName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                        //Page.ClientScript.RegisterStartupScript(this.GetType(), "alterdet", "<script> alert('" + ex.Message + "'); </script>");
                    }
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //5改为columnIndex_UpdateBy
                //6改为columnIndex_UpdateDateTime
                if (string.IsNullOrEmpty(e.Row.Cells[columnIndex_UpdateBy].Text) || e.Row.Cells[columnIndex_UpdateBy].Text == "&nbsp;")
                    e.Row.Cells[columnIndex_UpdateDateTime].Text = "";
            }
        }
    }
}