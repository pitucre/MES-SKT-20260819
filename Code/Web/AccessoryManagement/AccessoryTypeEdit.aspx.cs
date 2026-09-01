using System;
using SKT.LeanMES.AccessoryManagement.BLL;
using SKT.LeanMES.AccessoryManagement.Model;

namespace SKT.LeanMES.Web.AccessoryManagement
{
    public partial class AccessoryTypeEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccessory));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = (new AccessoryType()).GetInfo(Convert.ToInt32(idString));
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private AccessoryTypeInfo PageData
        {
            set
            {
                this.txtAccessoryTypeName.Text = value.AccessoryTypeName;
                this.txtThawTime.Text = Convert.ToString(value.ThawTime);
                this.txtLeaveUnusedTime.Text = Convert.ToString(value.LeaveUnusedTime);
                this.txtUseTime.Text = Convert.ToString(value.UseTime);
                this.txtStirTime.Text = Convert.ToString(value.StirTime);
                this.txtStirIdleTime.Text = Convert.ToString(value.StirIdleTime);
                this.txtStirQty.Text = Convert.ToString(value.StirQty);
            }
        }
    }
}