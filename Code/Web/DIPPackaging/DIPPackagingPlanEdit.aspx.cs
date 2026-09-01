using SKT.LeanMES.Container.BLL;
using SKT.LeanMES.Container.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.DIPPackaging
{
    public partial class DIPPackagingPlanEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDIPPackaging));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new DIPPackagingPlan()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private DIPPackagingPlanInfo PageData
        {
            set
            {
                this.txtFid.Value = Convert.ToString(value.Fid);
                this.txtFName.Text = value.FName;
                this.txtItemName.Text = value.ItemName;
                this.txtLineId.Value = Convert.ToString(value.LineId);
                this.txtOrderId.Value = Convert.ToString(value.OrderId);
                this.txtOrderNO.Text = value.OrderNO;
                this.txtOrderOrder.Text= value.OrderNO;
                this.txtItemId.Value = Convert.ToString(value.ItemId);
                this.txtItemCode.Text = value.ItemCode;
                this.txtItemDes.Text = value.ItemDes;
                this.txtPlanQty.Text = Convert.ToString(value.PlanQty);
                this.txtPlanDatiTime.Text = value.PlanDatiTime.ToString("yyyy-MM-dd");
                this.txtRemark.Text = value.Remark;
                this.txtLineName.Text = value.LineName;
            }
        }
    }
}