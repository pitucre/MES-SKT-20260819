using System;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.SerialNumber.BLL;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionTemplateItemEdit : BasePage
    {
        protected EquipmentInspectionTemplateItemInfo PageData
        {
            set
            {
                txtInspectionTemplateName.Text = value.InspectionTemplateName.ToString();
                HiddenInspectionTemplateId.Value = value.InspectionTemplateId.ToString();
                if (value.EquipmentInspectionType == "EquipmentCode")
                {
                    rdoItem.Checked = true;
                }
                if (value.EquipmentInspectionType == "EquipmentType")
                {
                    rdoType.Checked = true;
                }
                txtEquipmentName.Text = value.EquipmentCode;
                txtEquipmentType.Text = value.EquipmentTypeName;
                HiddenEquipmentTypeID.Value = value.EquipmentTypeID.ToString();
                ddlMaintainWay.SelectedValue = value.MaintainWay.ToString();
                ddlCycleType.SelectedValue = value.CycleType.ToString();
                txtPrewarning.Text = value.Prewarning.ToString();
                txtCycleTime.Text = value.CycleTime.ToString();
                txtOperionUserName.Text = value.OperionUserName;
                HiddenOperionUser.Value = value.OperionUser;
                txtExceptionReportingName.Text = value.ExceptionReportingName;
                HiddenExceptionReportingId.Value = value.ExceptionReportingId.ToString();
                txtLastTime.Text = value.LastTime.ToString();
                txtMaintainTime.Text = value.MaintainTime.ToString();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentInspectionItem));
            var bll = new EquipmentInspectionTemplateItem();
            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                ;
                if (id > 0)
                {
                    PageData = bll.GetInfo(id);
                }
            }
        }


    }
}