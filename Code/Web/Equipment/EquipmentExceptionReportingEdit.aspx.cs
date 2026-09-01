using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentExceptionReportingEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentInspectionItem));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(EquipmentExceptionReportingEdit));
            var bll = new EquipmentExceptionReporting();

            if (!IsPostBack)
            {
                var id = Convert.ToInt32(Request.QueryString["ID"]);
                this.txtHideInspectionTemplateId.Value = id + "";
                if (id > 0)
                {

                    PageData = bll.GetInfo(id);

                }
            }
        }

        protected EquipmentExceptionReportingInfo PageData
        {
            set
            {
                //hdnSelectItemIds.Value = value.InspectionItemIdList;
                txtHideInspectionTemplateId.Value = value.ExceptionReportingId.ToString();
                txtExceptionReportingCode.Text = value.ExceptionReportingCode;
                txtExceptionReportingName.Text = value.ExceptionReportingName;
                txtHideCreater.Value = value.Creater;
                txtHideCreateTime.Value = value.CreateTime.ToString();
                txtDescription.Text = value.Description;
                ddlStatus.SelectedIndex = value.Status ? 0 : 1;
                txtVersion.Text = value.Version;
                ddlExceptionType.Text = value.ExceptionType;
                //txtInspectionItemList.Text = value.InspectionItemIdList;
            }
        }
    }
}