using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederTypeView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceFeeder));
            Int32 FeederGroupID = Convert.ToInt32(Request.QueryString["ID"]);
            if (FeederGroupID != -1)
            {
                SKT.LeanMES.SMT.BLL.FeederType bllFeederType = new SKT.LeanMES.SMT.BLL.FeederType();
                SKT.LeanMES.SMT.Model.FeederTypeInfo model = null;
                model = bllFeederType.GetInfo(FeederGroupID);
                if (model != null)
                {
                    this.PageData = model;
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FeederTypeInfo PageData
        {
            set
            {
                this.txtName.Text = value.Name;
                this.txtSize.Text = Convert.ToString(value.Size);
                this.txtPitch.Text = Convert.ToString(value.Pitch);
                this.txtDescription.Text = Convert.ToString(value.Description);
                this.txtAttrition.Text = Convert.ToString(value.Attrition);
            }
        }
    }
}