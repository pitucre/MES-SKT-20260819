using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Equipment.BLL;
using SKT.LeanMES.Equipment.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Equipment
{
    public partial class EquipmentInspectionTemplateEdit : BasePage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxEquipmentInspectionItem));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(EquipmentInspectionTemplateEdit));
            var bll = new EquipmentInspectionTemplate();

            BindType();

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

        public void BindType()
        {
            EquipmentInspectionType bll = new EquipmentInspectionType();
            SearchSettings search = new SearchSettings();
            List<EquipmentInspectionTypeInfo> lists = new List<EquipmentInspectionTypeInfo>();
            lists.Add(new EquipmentInspectionTypeInfo() { InspectionTypeId = -1, InspectionTypeName = "请选择" });
            List<EquipmentInspectionTypeInfo> list = bll.GetAll(0, int.MaxValue, "", search);
            lists.AddRange(list);
            ddlInspectionType.DataSource = lists;
            ddlInspectionType.DataTextField = "InspectionTypeName";
            ddlInspectionType.DataValueField = "InspectionTypeId";
            ddlInspectionType.DataBind();
        }

        [AjaxMethod]
        public EquipmentInspectionTypeInfo GetInspectionTypeInf(int id)
        {

            try
            {
                var bll = new EquipmentInspectionType();
                return bll.GetInfo(id);
            }
            catch (Exception)
            {
                return null;

            }
        }

        protected EquipmentInspectionTemplateInfo PageData
        {
            set
            {
                //hdnSelectItemIds.Value = value.InspectionItemIdList;
                txtHideInspectionTemplateId.Value = value.InspectionTemplateId.ToString();
                txtInspectionTemplateName.Text = value.InspectionTemplateName;
                txtHideCreater.Value = value.Creater;
                txtHideCreateTime.Value = value.CreateTime.ToString();
                txtDescription.Text = value.Description;
                ddlStatus.SelectedIndex = value.Status ? 0 : 1;
                ddlInspectionType.SelectedValue = value.InspectionTypeId + "";
                var entity = GetInspectionTypeInf(value.InspectionTypeId);
                this.hdInspectionTypeId.Value = entity.SystemType.ToString();
                txtVersion.Text = value.Version;
                //txtInspectionItemList.Text = value.InspectionItemIdList;
            }
        }
    }
}