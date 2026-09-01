using System;
using System.Collections.Generic;
using AjaxPro;
using SKT.Common.Model;
using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTemplateCopy : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(InspectionTemplateEdit));
            var bll = new InspectionTemplate();

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
            InspectionType bll = new InspectionType();
            SearchSettings search = new SearchSettings();
            List<InspectionTypeInfo> lists = new List<InspectionTypeInfo>();
            lists.Add(new InspectionTypeInfo() { InspectionTypeId = -1, InspectionTypeName = "请选择" });
            List<InspectionTypeInfo> list = bll.GetAll(0, int.MaxValue, "", search);
            lists.AddRange(list);
            ddlInspectionType.DataSource = lists;
            ddlInspectionType.DataTextField = "InspectionTypeName";
            ddlInspectionType.DataValueField = "InspectionTypeId";
            ddlInspectionType.DataBind();
        }

        [AjaxMethod]
        public InspectionTypeInfo GetInspectionTypeInf(int id)
        {

            try
            {
                var bll = new InspectionType();
                return bll.GetInfo(id);
            }
            catch (Exception)
            {
                return null;

            }
        }

        protected InspectionTemplateInfo PageData
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