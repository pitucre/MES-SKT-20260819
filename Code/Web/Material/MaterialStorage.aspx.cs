using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class MaterialStorage : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
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

            if (!String.IsNullOrEmpty(this.txtSOCode.Value.Trim()))
            {
                searchSettings.AddCondition("SOCode", this.txtSOCode.Value.Trim());
            }

            string where = "";
            string receiptTimeEnd = txtReceiptTimeEnd.Text;
            if (receiptTimeEnd != "")
            {
                receiptTimeEnd = Convert.ToDateTime(receiptTimeEnd).AddDays(1).ToString();
            }
            if (txtReceiptTimeStart.Text != "" && receiptTimeEnd != "")
            {
                where += "   ModifyDateTime BETWEEN '" + txtReceiptTimeStart.Text + "' AND  '" + receiptTimeEnd + "'  ";
            }
            else if (txtReceiptTimeStart.Text != "")
            {
                where += "   ModifyDateTime >= '" + txtReceiptTimeStart.Text + "'";
            }
            else if (receiptTimeEnd != "")
            {
                where += "   ModifyDateTime <= '" + receiptTimeEnd + "'";
            }

            searchSettings.ExtensionCondition = where;

            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //设定视图、表名
            this.Master.TableOrView = "vwMaterialStorage";
        }
    }
}