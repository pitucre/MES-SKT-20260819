using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.SPC.BLL;
using SKT.LeanMES.SPC.Model;

namespace SKT.LeanMES.Web.SPC
{
    public partial class SPCWarnEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxSPC));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SPCWarn()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private SPCWarnInfo PageData
        {
            set
            {
                this.lblTaskName.Text = value.TaskName;
                this.lblSPCWarnMsg.Text = value.SPCWarnMsg;
                this.lblWarnTime.Text =  value.WarnTime.ToString();
                this.txtReson.Text = value.Reson;
                this.txtDealDesc.Text = value.DealDesc;
                this.txtDealBy.Text = value.DealBy;                
            }
        }
    }
}