using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.Controls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.Common.Model;
using SKT.LeanMES.Order.BLL;
using SKT.LeanMES.Web;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Product
{
    public partial class ShopOrderChangeCompare : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxShopOrder));

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {

                MO_Change ubll = new MO_Change();
                MO_ChangeInfo umodel = ubll.GetInfo(Convert.ToInt32(Id));
                if (umodel != null)
                {
                    this.PageDataNew = umodel;

                    ShopOrder bll = new ShopOrder();
                    ShopOrderInfo model = bll.GetInfo((int)umodel.MoId);
                    if (model != null)
                    {
                        this.PageDataOld = model;
                    }
                }


            }
        }

        /// <summary>
        /// 设置页面上的数据。 原内容
        /// </summary>
        private ShopOrderInfo PageDataOld
        {
            set
            {
                lblOldCreateDate.InnerText = value.CreateDateTime.ToString();
                lblOldOrderNO.InnerText = value.OrderNO.ToString();
                lblOldBusType.InnerText = GetOrderType(value.OrderType.ToString());
                lblOldInvCode.InnerText = value.ItemCode.ToString();
                lblOldInvName.InnerText = value.ItemName.ToString();
                //lblOldUnit.InnerText = value.ComUnitCode.ToString();
                //lblOldDepartNO.InnerText = value.MDeptCode.ToString();
                //lblOldDepartName.InnerText = value.MDeptName.ToString();
                lblOldQty.InnerText = value.Qty_to_Build.ToString();
                //lblOldInStoargeQty.InnerText = value.PlanQty.ToString();
                lblOldPlanDate.InnerText = value.Planned_Start_Time.ToString();
                lblOldPlanEndDate.InnerText = value.Planned_Completed_Date.ToString();
                //lblOldMemo.InnerText = value.Remark.ToString();
                lblOldMoStatus.InnerText = GetStatus(value.Status.ToString());
            }
        }

        /// <summary>
        /// 设置页面上的数据。 新内容
        /// </summary>
        private MO_ChangeInfo PageDataNew
        {
            set
            {
                lblNewCreateDate.InnerText = value.MDate.ToString();
                lblNewOrderNO.InnerText = value.MoCode.ToString();
                lblNewBusType.InnerText = GetOrderType(value.BusType.ToString());
                lblNewInvCode.InnerText = value.InvCode.ToString();
                lblNewInvName.InnerText = value.InvName.ToString();
                //lblNewUnit.InnerText = value.ComUnitCode.ToString();
                //lblNewDepartNO.InnerText = value.MDeptCode.ToString();
                //lblNewDepartName.InnerText = value.MDeptName.ToString();
                lblNewQty.InnerText = value.Qty.ToString();
                //lblNewInStoargeQty.InnerText = value.Qty.ToString();
                lblNewPlanDate.InnerText = value.PlanBeginDate.ToString();
                lblNewPlanEndDate.InnerText = value.PlanEndTime.ToString();
                //lblNewMemo.InnerText = value.Memo.ToString();
                lblNewMoStatus.InnerText = GetStatus(value.MOStatus.ToString());
            }
        }

        /// <summary>
        /// 获取工单的状态描述
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        private string GetStatus(string s)
        {
            string result = "";
            switch (s)
            {
                case "1": result = Resources.lang.Normal;
                    break;
                case "2": result = Resources.lang.Hold;
                    break;
                case "3": result = Resources.lang.Completed;
                    break;
                case "4": result = Resources.lang.Closed;
                    break;
                default: result = "";
                    break;
            }

            return result;
        }

        /// <summary>
        /// 获取工单的类型描述
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        private string GetOrderType(string t)
        {
            string result = "";
            switch (t)
            {
                case "1": result = "正常";
                    break;
                case "2": result = "RMA";
                    break;
                case "3": result = "返工";
                    break;
                case "4": result = "委外加工";
                    break;
                case "5": result = "受托加工";
                    break;
                case "6": result = "重复生产";
                    break;
                default: result = "";
                    break;
            }
            return result;
        }
    }
}