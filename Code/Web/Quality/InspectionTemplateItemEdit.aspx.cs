using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Quality.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionTemplateItemEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQuality));

            var id = Convert.ToInt32(Request.QueryString["ID"]);
            InspectionTemplateItem bll = new InspectionTemplateItem();
            ddlLotAudit.DataSource = bll.GetLotList();
            ddlLotAudit.DataTextField = "LotName";
            ddlLotAudit.DataValueField = "LotAudit";
            ddlLotAudit.DataBind();
            BindAqlSample();
            if (id > 0)
            {

                InspectionTemplateItemInfo info = bll.GetInfo(id);
                if (info != null)
                {
                    PageData = info;
                }

            }
        }


        protected InspectionTemplateItemInfo PageData
        {
            set
            {
                this.txtInspectionTemplateName.Text = value.InspectionTemplateName;
                this.hfInspectionTemplateId.Value = value.InspectionTemplateId + "";
                this.txtItemCode.Text = value.ItemCode;
                this.hfItemId.Value = value.ItemId == null ? string.Empty : value.ItemId.ToString();
                this.txtAQLName.Text = value.AQLRuleNameTypeName;
                this.hfAQLId.Value = value.AQLRuleId + "";
                this.txtVendorCode.Value = value.VendorName == "" ? value.VendorCode : "[" + value.VendorCode + "]" + value.VendorName;
                this.hdnVendorCode.Value = value.VendorCode;
                CommonMethod.setDropDownListSelectedValue(ddlLotAudit, value.LotAudit, CommonMethod.ValueTypeEnum.Value);
                this.ddlAQLSampleName.SelectedValue = value.AQLSampleId.ToString();
                //给单选按钮赋值
                var itemChecked = string.IsNullOrEmpty(value.ItemCode) ? false : true;
                this.rdoItem.Checked = itemChecked;
                this.rdoType.Checked = !this.rdoItem.Checked;

                this.txtCategoryOne.Text = value.CategoryOneName;
                this.txtCategoryTwo.Text = value.CategoryTwoName;
                this.txtCategoryThree.Text = value.CategoryThreeName;

                this.HiddentxtCategoryOne.Value = value.CategoryOne;
                this.HiddentxtCategoryTwo.Value = value.CategoryTwo;
                this.HiddentxtCategoryThree.Value = value.CategoryThree;
            }
        }

        protected void BindAqlSample()
        {
            var list = (new AQLSample()).GetAll(0, -1, "", new Common.Model.SearchSettings());
            ddlAQLSampleName.DataSource = list;
            ddlAQLSampleName.DataValueField = "AQLSampleId";
            ddlAQLSampleName.DataTextField = "AQLSampleName";
            ddlAQLSampleName.DataBind();
            ddlAQLSampleName.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));

        }
    }
}