using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.BLL;
using SKT.LeanMES.Material.Model;

namespace SKT.LeanMES.Web.MaterialConfig
{
    public partial class PrepareToOtherConfig : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new PrepareToOther()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private PrepareToOtherInfo PageData
        {
            set
            {
                this.txtPrepareTo.Text = value.PrepareDesc;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}