using System;
using SKT.LeanMES.SMT.BLL;
using SKT.LeanMES.SMT.Model;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SMT
{
    public partial class MachineModelFamilyEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceMachineModel));

            if (!this.IsPostBack)
            {
                Int32 ModelFamilyID = Convert.ToInt32(Request.QueryString["ID"]);

                if (ModelFamilyID != -1)
                {
                    SKT.LeanMES.SMT.BLL.MachineModelFamily bllMachineModelFamily = new SKT.LeanMES.SMT.BLL.MachineModelFamily();
                    SKT.LeanMES.SMT.Model.MachineModelFamilyInfo model = null;
                    model = bllMachineModelFamily.GetInfo(ModelFamilyID);
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
        private MachineModelFamilyInfo PageData
        {
            set
            {
                this.txtModelFamilyName.Text = value.ModelFamilyName;
                this.txtDescription.Text = value.Description;
            }
        }
    }
}