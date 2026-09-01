using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class PrintSplitMaterial : BasePage
    {
        private int columnIndex_ItemDesc = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                columnIndex_ItemDesc = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "ItemDesc")) + 1;
                bindDropMaterialStatus();
            }
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPrint));

            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;

            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialUnitId";
            this.Master.DefaultSortExpression = "CreateDateTime DESC";


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.AddCondition("SerialNumber", this.txtSerialNumber.Value.Trim());
            searchSettings.AddCondition("ItemName", this.txtItemName.Value.Trim());
            searchSettings.AddCondition("VendorCode", this.txtVendor.Value.Trim());
            searchSettings.AddCondition("CreateBy", this.txtCreateBy.Value.Trim());

            string staus = this.ddlMaterialStatus.SelectedValue;
            string txtDateFrom = this.txtDateFrom.Value.Trim();
            string txtDateTo = this.txtDateTo.Value.Trim();
            string dateFrom = "";
            string dateTo = "";
            dateFrom = txtDateFrom;
            dateTo = txtDateTo;
            this.txtDateFrom.Value = dateFrom;
            this.txtDateTo.Value = dateTo;
            if (staus != "-2" && !string.IsNullOrEmpty(staus))
            {
                searchSettings.ExtensionCondition += "  [Status] =" + Convert.ToInt32(staus) + "";
            }

            else if (txtDateFrom != "" )
            {
                searchSettings.ExtensionCondition += "( CreateDateTime >= '" + Convert.ToDateTime(dateFrom).AddDays(1) + "')";
            }
            else if (txtDateTo != "")
            {
                searchSettings.ExtensionCondition += "(CreateDateTime <= '" + Convert.ToDateTime(dateTo).AddDays(1) + "')";
            }
            else if (txtDateFrom != "" && txtDateTo != "")
            {
                //判断日期
                searchSettings.ExtensionCondition += " CreateDateTime between '" + Convert.ToDateTime(dateFrom).AddDays(1) + "' and '" + Convert.ToDateTime(dateTo).AddDays(1) + "' ";

            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
        }

        public void bindDropMaterialStatus()
        {

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            List<SKT.LeanMES.Material.Model.MaterialUnitInfo> materialUnit = new SKT.LeanMES.Material.BLL.MaterialUnit().GetMaterialAllStatus(0, -1, "", searchSettings);
            ddlMaterialStatus.DataSource = materialUnit;
            ddlMaterialStatus.DataTextField = "MaterialStatus";
            ddlMaterialStatus.DataValueField = "StatusId";
            ddlMaterialStatus.DataBind();
            this.ddlMaterialStatus.Items.Insert(0, new ListItem(Resources.lang.Choose, "-2"));
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //3改为columnIndex_ItemDesc
                string itemDesc = e.Row.Cells[columnIndex_ItemDesc].Text;
                itemDesc = itemDesc.Split(':')[0];
                e.Row.Cells[columnIndex_ItemDesc].Text = itemDesc;
            }
        }
    }
}