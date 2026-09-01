using System;
using SKT.LeanMES.CommonDataSource.BLL;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.Web.SystemConfiguration
{
    public partial class WriteBackConfigureEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.AjaxCommon.DBService));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = new ERPWriteBackConfig().GetInfo(new ERPWriteBackConfigInfo() { WriteBackConfigId = Convert.ToInt32(idString) });
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private ERPWriteBackConfigInfo PageData
        {
            set
            {
                this.WriteBackCode.Text = value.WriteBackCode;
                this.WriteBackName.Text = value.WriteBackName;
                this.WriteBackFlag.SelectedValue = Convert.ToString(value.WriteBackFlag);
                this.Remark.Text = value.Remark;
            }
        }
    }
}