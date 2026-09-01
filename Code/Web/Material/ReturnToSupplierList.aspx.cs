using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Material
{
    public partial class ReturnToSupplierList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GridView1.DataSourceID = this.ObjectDataSource1.ID;
            this.Master.SetSearchSettings = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ReturnOrder";
            this.Master.DefaultSortExpression = "CreateDateTime DESC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (txtCreater.Text.Trim() != "")
            {
                searchSettings.AddCondition("UpdateBy", txtCreater.Text.Trim());
            }
            if (txtReturnToWarehouseNO.Text.Trim() != "")
            {
                searchSettings.AddCondition("ReturnOrder", txtReturnToWarehouseNO.Text.Trim());
            }

            if (txtItemCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("ItemCode", txtItemCode.Text.Trim());
            }

            if (txtErpSrc.Text.Trim() != "")
            {
                searchSettings.AddCondition("SourceBillNo", txtErpSrc.Text.Trim());
            }
            if (txtVenCode.Text.Trim() != "")
            {
                searchSettings.AddCondition("VendorCode", txtVenCode.Text.Trim());
            }
            /*xiang.yan,2024-4-20 修改时间查询报错。将CreateTime 字段改为CreateDateTime。
             * 并将1=1提取到公共，将searchSettings.ExtensionCondition=改为+= 解决开始时间跟结束时间同时有效*/
            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtReturnDateFr.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " AND CreateDateTime >=CONVERT(DATETIME, '" + txtReturnDateFr.Text.Trim() + "')";
            }
            if (txtReturnDateTo.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " AND CreateDateTime <= CONVERT(DATETIME, '" + txtReturnDateTo.Text.Trim() + "')";
            }
            var status = this.ddlStatus.SelectedValue;
            if (!string.Equals(status, "-1"))
            {
                searchSettings.AddCondition("FinishStatusCode", status);
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;

            //删除
            if (IsPostBack)
            {
                if (Request.Form["hdnOperate"].ToLower() == "delete")
                {
                    SKT.LeanMES.Material.BLL.ReturnToVendor bll = new SKT.LeanMES.Material.BLL.ReturnToVendor();
                    try
                    {
                        bll.WarehouseReturnSupplierDelete(new LeanMES.Material.Model.ReturnToVendorInfo
                        {
                            ReturnOrder = Request.Form["hdnIdString"].ToString(),
                            UpdateBy = AccountController.GetCurrentUser().UserName
                        });
                        WebHelper.ShowMessage(Resources.Messages.DeleteSuccess);
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(AccountController.GetCurrentUser().UserName, ex, true);
                    }
                }
            }

        }
    }
}