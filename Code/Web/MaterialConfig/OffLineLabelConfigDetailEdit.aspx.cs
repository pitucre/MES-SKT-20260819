using SKT.LeanMES.MaterialConfig.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.MaterialConfig
{
    public partial class OffLineLabelConfigDetailEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialConfig));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    SKT.LeanMES.MaterialConfig.BLL.MaterialSupplierConfig supplierConfig = new LeanMES.MaterialConfig.BLL.MaterialSupplierConfig();
                    MaterialSupplierConfigInfo model = supplierConfig.GetOffLineLabelConfigDetaiInfo(Convert.ToInt32(idString));
                    if (model != null)
                    {
                        this.PageData = model;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private MaterialSupplierConfigInfo PageData
        {
            set
            {
                this.ddlDetailContent.SelectedValue = value.DetailContent;
                this.ddlParagraph.SelectedValue = value.Paragraph.ToString();
            }
        }
    }
}