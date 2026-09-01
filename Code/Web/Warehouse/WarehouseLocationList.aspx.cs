using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Warehouse.BLL;
using System.Data;
using System.Linq;

namespace SKT.LeanMES.Web.Warehouse
{
    public partial class WarehouseLocationList : BasePage
    {
        private int columnIndex_CProperty = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_CProperty = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "CProperty")) + 1;
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxWarehouse));
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "WarehouseLocationId";
            this.Master.DefaultSortExpression = "WarehouseLocationId DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("cStoreCode", this.txtScode.Text.Trim());
            searchSettings.AddCondition("cStoreName", this.txtSname.Text.Trim());
            searchSettings.AddCondition("cPosCode", this.txtPcode.Text.Trim());
            searchSettings.AddCondition("cPosName", this.txtPname.Text.Trim());
            searchSettings.AddCondition("cBarCode", this.txtCbarcode.Text.Trim());
            searchSettings.AddCondition("CWhCode", this.txtCWhCode.Text.Trim());
            searchSettings.AddCondition("CWhName", this.txtCWhName.Text.Trim());
            searchSettings.AddCondition("ShiftCode", this.txtShiftCode.Text.Trim());
            this.Master.SearchSettings = searchSettings;

            if (IsPostBack)
            {
                //删除
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    string userName = AccountController.GetCurrentUser().UserName;
                    try
                    {
                        SKT.LeanMES.Warehouse.BLL.WarehouseLocation bll = new SKT.LeanMES.Warehouse.BLL.WarehouseLocation();
                        bll.Delete(Request.Form["hdnIdString"].ToString(), userName);
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(userName, ex, true);
                    }
                }
                //导出
                if (Request.Form["hdnOperate"].ToLower() == "exportexcel")
                {
                    DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwWarehouseLocation", "ORDER BY WarehouseLocationId DESC", searchSettings, "WarehouseLocationId","");
                    CommonMethod.ExportToSpreadsheet(ds, "货架货位列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, null);
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-24 cells取值改为根据列名获取
                //4改为columnIndex_CProperty
                e.Row.Cells[columnIndex_CProperty].Text = (Convert.ToString(e.Row.Cells[columnIndex_CProperty].Text.Trim()) == "S") ? "一般性仓库" : "在制品仓库";
                //e.Row.Cells[3].Text = (Convert.ToString(e.Row.Cells[3].Text.Trim()) == "S") ? (String)this.GetGlobalResourceObject("Pages", "wmsInventoryPropertyS") : (String)this.GetGlobalResourceObject("Pages", "wmsInventoryPropertyW");
            }
        }
    }
}