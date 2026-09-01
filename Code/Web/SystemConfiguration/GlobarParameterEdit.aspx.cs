using System;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class GlobarParameterEdit : BasePage
    {
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private GlobarParametersInfo PageData
        {
            set
            {
                txtHideID.Value = Convert.ToString(value.ID);
                txtParaType.Text = Convert.ToString(value.ParaType);
                txtParaName.Text = value.ParaName;
                txtParaValue.Text = value.ParaValue;
                txtParaDescription.Text = value.Paraription;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServiceGlobarParameter));

           

            if (!IsPostBack)
            {
                var idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    PageData = (new LeanMES.CommonDataSource.BLL.GlobarParameter()).GetInfo(Convert.ToInt32(idString));
                    this.txtParaType.Enabled = false;
                    this.txtParaName.Enabled = false;
                    this.txtParaDescription.Enabled = false;
                }
               
            }
           
        }
    }
}