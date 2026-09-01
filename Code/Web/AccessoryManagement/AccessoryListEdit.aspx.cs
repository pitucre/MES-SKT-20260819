using System;
using SKT.LeanMES.AccessoryManagement.Model;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryListEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessoryList));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new SKT.LeanMES.AccessoryManagement.BLL.AccessoryList()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AccessoryListInfo PageData
        {
            set
            {
                this.txtAccessoryName.Text = value.AccessoryName;
                hAccessoryId.Value = value.AccessoryCode;
                hAccessoryTypeId.Value = value.AccessoryType;
                this.txtAccessoryType.Text = value.AccessoryTypeName;
                this.txtWLTpye.Text = value.WLType;
                this.txtUnitName.Text = value.UnitName;
                this.txtIsFreeze.Text =value.IsFreeze;
            }
        }
    }
}