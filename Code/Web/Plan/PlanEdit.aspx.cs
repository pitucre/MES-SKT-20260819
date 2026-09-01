using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Plan.Model;
using AjaxPro;
using SKT.LeanMES.Order.Model;

namespace SKT.LeanMES.Web.Plan
{
    public partial class PlanEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxPlan));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                SKT.LeanMES.Order.BLL.ShopOrder orderBll = new Order.BLL.ShopOrder();
                
                var orderInfo = orderBll.GetInfoByOrderId(Convert.ToInt32(idString));
               
                if (orderInfo != null)
                {
                    this.PageData = orderInfo;
                }                

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.Plan.Model.PlanInfo planInfo = (new SKT.LeanMES.Plan.BLL.Plan()).GetInfo(Convert.ToInt32(idString)); 
                }
            }
        }



        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ShopOrderInfo PageData
        {
            set
            {
                this.lbOrderNumber.Text = value.OrderNO;
                this.lbFQty.Text = value.Qty_to_Build.ToString("F0").ToString();
                this.lbFName.Text = value.ItemName;
                //this.lbFBiller.Text = value.FBiller;
                //this.lbFConveyer.Text = value.FConveyer;
                this.lbFPlanCommitDate.Text = value.Planned_Start_Time > Convert.ToDateTime("9000-1-1") ? "" : value.Planned_Start_Time.ToString("yyyy-MM-dd HH:mm:ss");
                this.lbFPlanFinishDate.Text = value.Planned_Completed_Date > Convert.ToDateTime("9000-1-1") ? "" : value.Planned_Completed_Date.ToString("yyyy-MM-dd HH:mm:ss");
                //this.lbFCommitDate.Text = value.FCommitDate.ToString("yyyy-MM-dd HH:mm:ss");
                //this.lbFWorkShop.Text = value.FWorkShop;
                this.lblItemCode.Text = value.ItemCode;
                this.lblPlaneQty.Text = value.PanelQty.ToString();
                this.lblRouterName.Text = value.RouterName;
                this.hdnItemId.Value = value.ItemId.ToString();
               // this.lbFQtyPlan.Text = (value.Qty_to_Build - value.FQty).ToString("F0").ToString();
            }
        }
    }
}