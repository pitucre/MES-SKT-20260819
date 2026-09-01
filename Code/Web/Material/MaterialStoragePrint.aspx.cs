using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialStoragePrint : BasePage
    {
        private int columnIndex_PrintDateTime = -1;
        private int columnIndex_RePrintDateTime = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            columnIndex_PrintDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "PrintDateTime")) + 1;
            columnIndex_RePrintDateTime = GridView1.Columns.IndexOf(GridView1.Columns.OfType<BoundField>().First(col => col.DataField == "RePrintDateTime")) + 1;

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "MaterialStorageId";
            this.Master.DefaultSortExpression = "MaterialStorageId desc"; //也可不赋值


            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.AddCondition("DeliverNo", txtDeliverNo.Value);
            searchSettings.AddCondition("POCode", txtPONO.Value);
            searchSettings.AddCondition("MaterialStorageNo", txtInStockNo.Value);
            searchSettings.AddCondition("InspectionNo", txtInspectionNo.Value); 
            searchSettings.AddCondition("ItemCode", txtItemCode.Value);
            searchSettings.AddCondition("SuplierCode", txtVendorCode.Value);
            searchSettings.AddCondition("CreateBy", txtInStockBy.Value);

            string where = "(1=1)";
            if (chkPrint.Checked)
            {
                searchSettings.AddCondition("PrintTimes", "0");
                where += " AND POType in (1,2)  ";
            }
        
            string receiptTimeEnd = txtReceiptTimeEnd.Text;
            if (receiptTimeEnd != "")
            {
                receiptTimeEnd = Convert.ToDateTime(receiptTimeEnd).AddDays(1).ToString();
            }
            if (txtReceiptTimeStart.Text != "" && receiptTimeEnd != "")
            {
                where += "  AND ModifyDateTime BETWEEN '" + txtReceiptTimeStart.Text + "' AND  '" + receiptTimeEnd + "'  ";
            }
            else if (txtReceiptTimeStart.Text != "")
            {
                where += " AND  ModifyDateTime >= '" + txtReceiptTimeStart.Text + "'";
            }
            else if (receiptTimeEnd != "")
            {
                where += " AND  ModifyDateTime <= '" + receiptTimeEnd + "'";
            }
            //检验结果
            string inspectionResult = this.selInspectionResult.Value;
            if (!string.IsNullOrEmpty(inspectionResult))
            {
                if (string.Equals(inspectionResult, "1"))
                {
                    //合格
                    searchSettings.AddCondition("InspectionResult", inspectionResult);
                }
                else
                {
                    //不合格
                    where += " AND InspectionResult IN (0,2) ";
                }
            }
            //处理结果
            string iqcResult = this.selIQCResult.Value;
            if (!string.IsNullOrEmpty(iqcResult))
            {
                searchSettings.AddCondition("ManageResult", iqcResult);
            }


            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwMaterialStorage";


            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwMaterialStorage", "ORDER BY MaterialStorageId DESC", searchSettings, "MaterialStorageId", this.hdnIdString.Value);
                        var tempFiledNames = new string[] { "InspectionQty", "QualifiedQty", "StorageQty" };
                        CommonMethod.ExportToSpreadsheet(ds, "物料入库打印列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }

        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowIndex != -1)
            {
                int id = e.Row.RowIndex + 1;

                //xiang.yan 2024-4-23 cells取值改为根据列名获取
                //24改为columnIndex_PrintDateTime
                //26改为columnIndex_RePrintDateTime

                if (Convert.ToDateTime(e.Row.Cells[columnIndex_PrintDateTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_PrintDateTime].Text = "";
                }
                if (Convert.ToDateTime(e.Row.Cells[columnIndex_RePrintDateTime].Text).ToString("yyyy-MM-dd") == "9999-12-31")
                {
                    e.Row.Cells[columnIndex_RePrintDateTime].Text = "";
                }
              
            }
        }
    }
}