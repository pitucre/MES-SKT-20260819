using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using SKT.LeanMES.Wave.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Wave
{
    public partial class InterfaceTypeModelEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            if (!this.IsPostBack)
            {
                var id = Request.QueryString["ID"];
                if (id != null && !string.IsNullOrEmpty(id) && Convert.ToInt32(id) > -1)
                {
                    var entity = (new AjaxInterfaceManagement()).GetDeviceInterfaceTypeInfo(new DeviceInterfaceTypeInfo { DeviceInterfaceTypeId = Convert.ToInt32(id) });
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据
        /// </summary>
        private DeviceInterfaceTypeInfo PageData
        {
            set
            {
                this.txtDeviceType.Text = value.DeviceType;
                this.txtBrandType.Text = value.Brand;
            }
        }
    }
}