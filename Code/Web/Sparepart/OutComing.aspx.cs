using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.Model;

namespace SKT.LeanMES.Web.Sparepart
{
    public partial class OutComing : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxSparepart));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                this.txtRequestor.Text = SKT.LeanMES.Web.AccountController.GetCurrentUser().UserName;
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.Sparepart.BLL.Sparepart()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SparepartInfo PageData
        {
            set
            {
                this.txtPart_NO.Text = value.PartNO;
                this.lbPartName.Text = value.PartName;
                this.lbPartNickName.Text = value.PartNickName;
                this.lbPartCategory.Text = value.PartCategory;
                this.lbPartMachine.Text = value.PartMachine;
                this.lbPartLocation.Text = value.PartLocation;
                this.lbPartBrand.Text = value.PartBrand;
                this.lbPartStandard.Text = value.PartStandard;
                this.lbPartParam.Text = value.PartParam;
                this.lbPartSafeQty.Text = Convert.ToString(value.PartSafeQty);
                this.lbPartQty.Text = Convert.ToString(value.PartQty);
            }
        }
    }
}