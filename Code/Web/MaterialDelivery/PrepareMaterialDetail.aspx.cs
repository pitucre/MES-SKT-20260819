using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.MaterialDelivery.BLL;
using SKT.LeanMES.MaterialDelivery.Model;

namespace SKT.LeanMES.Web.MaterialDelivery
{
    public partial class PrepareMaterialDetail : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialDelivery));

            string IdStr = Request.QueryString["Id"] == null ? "-1" : Request.QueryString["Id"].ToString();
            int Id;

            if (int.TryParse(IdStr, out Id) && Id > 0)
            {
                MaterialPrepare bll = new MaterialPrepare();
                MaterialPrepareInfo model = bll.GetInfo(Convert.ToInt32(Id));
                if (model != null)
                {
                    this.PageData = model;
                }

            }
        }


        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialPrepareInfo PageData
        {
            set
            {
                lblOrderNO.Text = value.ProdOrderNO.ToString();
                lblPrepareNO.Text = value.PrepareNO.ToString();
                lblSection.Text = value.SectionNO.ToString();
                lblProductCode.Text = value.ProductCode.ToString();
                lblRequestQty.Text = value.RequestQty.ToString();
                lblRequestDate.Text = value.RequestDate.ToString();
            }
        }
    }
}