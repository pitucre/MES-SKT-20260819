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
    public partial class FloorInfoEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxDIPPackaging));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new FloorInfo()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FloorInfoInfo PageData
        {
            set
            {
                this.txtCode.Text = value.Code;
                this.txtName.Text = value.Name;
                this.txtRemark.Text = value.Remark;
            }
        }
    }
}