using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairUserView : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = new SKT.LeanMES.Equipment.BLL.EquipmentRepairUser().GetInfo(new EquipmentRepairUserInfo { EquipmentRepairUserId = Convert.ToInt32(idString) });
                }
            }
        }

        /// <summary>
        /// 设置页面上的数据。
        /// </summary>
        private EquipmentRepairUserInfo PageData
        {
            set
            {
                this.lblUserName.Text = value.UserName.ToString();
                this.lblCName.Text = value.CName.ToString();
                this.lblEmail.Text = value.Email.ToString();
                this.lblPhone.Text = value.Phone;
                this.lblDepartName.Text = value.DepartName.ToString();
                //this.lblWorkshift.Text = value.WorkShiftName.ToString();
            }
        }
    }
}