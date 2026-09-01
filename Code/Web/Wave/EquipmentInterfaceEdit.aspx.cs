using SKT.LeanMES.Wave.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Wave
{
    public partial class EquipmentInterfaceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInterfaceManagement));
            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];

                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    var entity = (new AjaxInterfaceManagement()).GetInterfaceManagementById(Convert.ToInt32(idString));
                    if (entity != null)
                    {
                        this.PageData = entity;
                    }

                }
            }
        }
        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private InterfaceManagementListInfo PageData
        {
            set
            {
                this.hdnFileType.Value = value.FileType;
                this.hdnDeviceType.Value = value.DeviceType;
                this.hdnBrandType.Value = value.BrandType;
                this.hdnSplict.Value = value.Split;
                this.txtOKStr.Text = value.OKStr;
                this.txtNGStr.Text = value.NGStr;
            }
        }
    }
}