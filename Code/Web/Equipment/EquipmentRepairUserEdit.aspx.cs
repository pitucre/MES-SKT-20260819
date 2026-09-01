using SKT.LeanMES.Equipment.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentRepairUserEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEquipment));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxAccount));            

            if (!this.IsPostBack)
            {
                String idString = Request.QueryString["ID"];
                if (idString != null && Convert.ToInt32(idString) > 0)
                {
                    this.PageData = new SKT.LeanMES.Equipment.BLL.EquipmentRepairUser().GetInfo(new EquipmentRepairUserInfo { EquipmentRepairUserId = Convert.ToInt32(idString) });
                }
                else
                {
                    this.hdnEquipmentRepairUserId.Value = "-1";
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
                this.hdnEquipmentRepairUserId.Value = value.EquipmentRepairUserId.ToString();
                this.hidUserId.Value = value.UserId.ToString();
                this.txtUserName.Text = value.UserName.ToString();
                this.lblCName.Text = value.CName.ToString();
                this.txtEmail.Text = value.Email.ToString();
                this.txtPhone.Text = value.Phone;
                this.hdnDepartId.Value = value.DepartId.ToString();
                this.txtDepartName.Text = value.DepartName.ToString();
               // this.ddlWorkshift.Value = value.WorkShift.ToString();
            }
        }
    }
}