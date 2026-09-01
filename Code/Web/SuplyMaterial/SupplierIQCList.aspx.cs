using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace SKT.LeanMES.Web.SuplyMaterial
{
    public partial class SupplierIQCList : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionId";
            Master.DefaultSortExpression = "InspectionId";
            Master.DefaultSortDirection = SortDirection.Descending;

            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " Statue!=0 ";
            searchSettings.AddCondition("VendorCode", txtSuplierCode.Text.Trim());
            if (this.selManageResult.Value != "-1")
            {
                searchSettings.AddCondition("ManageResult", this.selManageResult.Value);
            }
            //检验结果
            string inspectionResult = this.selInspectionResult.Value;
            if (inspectionResult != "")
            {
                if (string.Equals(inspectionResult, "1"))
                {
                    //合格
                    searchSettings.AddCondition("InspectionResult", inspectionResult);
                }
                else
                {
                    //不合格
                    searchSettings.ExtensionCondition += " AND InspectionResult IN (0,2) ";
                }
            }
            searchSettings.AddCondition("DeliverNo", txtDeliNo.Text.Trim());
            searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            searchSettings.ExtensionCondition+=" and POCode like '%"+txtpOCode.Text.Trim()+"%' ";
            searchSettings.AddCondition("LoweredUserName", txtLoweredUserName.Text.Trim());
            if (AccountController.GetCurrentUser().UserType != -1)
            {
                this.txtSuplierCode.Visible = false;
                //如果是供应商角色，只能查看自己的记录
                // searchSettings.AddCondition("SupplierId", AccountController.GetCurrentUser().UserType.ToString());

                searchSettings.ExtensionCondition += " and  SupplierId=" + AccountController.GetCurrentUser().UserType.ToString() + "";
       
            }

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;
            this.Master.TableOrView = "vwSupplierMaterialIQCList";
            if (IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwSupplierMaterialIQCList", "ORDER BY InspectionId desc", searchSettings, "InspectionId", Request["hdnIdString"]);
                        var tempFiledNames = new string[] { "InspectionQty", "ReceiveQty", "NoQty" };
                        CommonMethod.ExportToSpreadsheet(ds, "IQC判定结果列表" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames,null, new List<string>() { "VendorCode" });
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException("", ex, true);
                }
            }
        }
    }
}