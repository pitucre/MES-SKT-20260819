using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.ESOP.Model;
using SKT.LeanMES.ESOP.BLL;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPLineEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new ESOPLine()).GetInfo(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ESOPLineInfo PageData
        {
            set
            {
                this.hdnLineId.Value = Convert.ToString(value.LineId);
                this.hdnProdOrderId.Value = Convert.ToString(value.ProdOrderId);
                this.chkIsDefault.Checked = value.IsDefault;
                this.txtLineName.Text = value.LineName;
                this.txtOrderNo.Text = value.OrderNo;
                if (value.IsDefault == true)
                {
                    this.chkIsDefault.Disabled = true;
                }   
            }
        }
    }
}