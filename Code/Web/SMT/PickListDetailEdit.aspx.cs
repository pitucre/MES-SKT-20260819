using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;

namespace SKT.LeanMES.Web.SMT
{
    public partial class PickListDetailEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxPickList));
            int groudId = Convert.ToInt32(Request.QueryString["ID"]);
            if (groudId > -1)
            {
                PickListDetailInfo model = null;
                SKT.LeanMES.SMT.BLL.PickListDetail bll = new SKT.LeanMES.SMT.BLL.PickListDetail();
                model = bll.GetInfo(groudId);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        private PickListDetailInfo PageData
        {
            set
            {
                this.hdnItemId.Value = value.ItemID.ToString();
                this.txtItemCode.Text = value.ItemCode;
                ddlGroupCode.SelectedValue = value.GroupCode;
                this.txtGroupDesc.Text = value.GroupDesc;
                this.txtRemark.Text = value.Remark;
                this.txtPickListQty.Text = Convert.ToString(value.Qty);
            }
        }
    }
}