using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class FeederGroupEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceFeeder));

            Int32 FeederGroupID = Convert.ToInt32(Request.QueryString["ID"]);


            if (FeederGroupID != -1)
            {
                SKT.LeanMES.SMT.BLL.FeederGroup bllFeederGroup = new SKT.LeanMES.SMT.BLL.FeederGroup();
                SKT.LeanMES.SMT.Model.FeederGroupInfo model = null;
                model = bllFeederGroup.GetInfo(FeederGroupID);
                if (model != null)
                {
                    this.PageData = model;

                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private FeederGroupInfo PageData
        {
            set
            {
                this.txtModelName.Text = Convert.ToString(value.ModelName);
                this.txtModelID.Value = Convert.ToString(value.MachineModelID);
                this.txtMinSize.Text = Convert.ToString(value.MinSize);
                this.txtMaxSize.Text = Convert.ToString(value.MaxSize);
            }
        }
    }
}