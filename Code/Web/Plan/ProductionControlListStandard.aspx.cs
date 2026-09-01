using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.PubItems.BLL;
using SKT.LeanMES.PubItems.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class ProductionControlListStandard : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxPlan));
            txtPlanBegin.ReadOnly = true;
            txtPlanEnd.ReadOnly = true;
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "FInterID";
            this.Master.DefaultSortExpression = "ModifyTime DESC,Planned_Start_Time ASC ,ProductionLineSort ASC"; //也可不赋值

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            if (!this.IsPostBack) { hfStrOrderStatus.Value = ""; }

            if (hfStrOrderStatus.Value != "")
            {
                searchSettings.ExtensionCondition = " [StatusId] IN (" + hfStrOrderStatus.Value.ToString() + ") and TableName !='' ";
            }

            if (this.txtOrderNo.Text.Length > 0)
            {
                searchSettings.AddCondition("FBILLNO", txtOrderNo.Text.Trim().Replace("'", "''"));
            }

            if (txtLine.Text.Length > 0)
            {
                searchSettings.AddCondition("LineName", txtLine.Text.Trim().Replace("'", "''"));
            }
            if (txtPlanBegin.Text.Length > 0)
            {
                searchSettings.AddCondition("CONVERT(varchar(10),Planned_Start_Time,120)", txtPlanBegin.Text);
            }
            if (txtPlanEnd.Text.Length > 0)
            {
                searchSettings.AddCondition("CONVERT(varchar(10),Planned_Completed_Date,120)", txtPlanEnd.Text);
            }
            if (txtItemName.Text.Length > 0)
            {
                searchSettings.AddCondition("ItemCode", txtItemName.Text.Trim().Replace("'", "''"));
            }
            if (txtCreateTimeStart.Text.Length > 0 || txtCreateTimeEnd.Text.Length > 0)
            {
                var startTime = txtCreateTimeStart.Text == "" ? "2000-01-01" : txtCreateTimeStart.Text;
                var endTime = txtCreateTimeEnd.Text == "" ? "9999-12-31" : txtCreateTimeEnd.Text;
                var filterTime = " ModifyTime between '" + startTime + "' and '" + endTime + "'";
                searchSettings.ExtensionCondition = (searchSettings.ExtensionCondition == "") ? filterTime : searchSettings.ExtensionCondition + " and " + filterTime;
            }
            this.Master.SearchSettings = searchSettings;

            //删除
            if (this.IsPostBack)
            {
                if (hdnOperate.Value == "delete")
                {
                    try
                    {
                        string idStr = hdnIdString.Value;
                        SKT.LeanMES.Order.BLL.ShopOrder shopOrderBll = new Order.BLL.ShopOrder();
                        SKT.LeanMES.Order.Model.ShopOrderInfo orderInfo = shopOrderBll.GetInfoByOrderId(Convert.ToInt32(idStr));

                        if (orderInfo != null && orderInfo.LineStatue == 1)
                        {
                            SKT.LeanMES.Plan.BLL.LinePlan linePlanBll = new SKT.LeanMES.Plan.BLL.LinePlan();
                            //删除Prod_LinePlan
                            linePlanBll.Delete(Convert.ToInt32(idStr), AccountController.GetCurrentUser().UserName);

                            //更新Prod_Order工单状态
                            orderInfo.Status = 0;
                            orderInfo.Qty_to_Line = 0;
                            string dateStr = DateTime.MaxValue.ToString();
                            shopOrderBll.Edit(orderInfo, orderInfo.Planned_Start_Time.ToString(), orderInfo.Planned_Completed_Date.ToString(), dateStr, dateStr);
                            hdnOperate.Value = "";
                            WebHelper.ShowMessage(Resources.Messages.CancelSuccess);
                        }
                        else
                        {
                            WebHelper.ShowMessage(Resources.Messages.ProducedCannotOperation);
                        }
                    }
                    catch (Exception ex)
                    {
                        WebHelper.HandleException(String.Empty, ex, true);
                        hdnOperate.Value = "";
                        hdnIdString.Value = "";
                    }
                }
            }
            else
            {
                //生成工单状态checkbox
                SKT.Common.Model.SearchSettings searchSettingsB = new SKT.Common.Model.SearchSettings();
                searchSettingsB.ExtensionCondition = " StatusFlag >0";
                hfCheckBox.Value = (new PubItems.BLL.PubItems()).GetOrderPlanStatus("StatusID", searchSettingsB);
            }

        }


    }
}