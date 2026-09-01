using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.Material.Model;
using SKT.LeanMES.Web.AjaxServices;
using SKT.LeanMES.Model;
using SKT.LeanMES.Material.BLL;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCFormAttend : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterial));
            var iqcId = Request.QueryString["InspectionId"];
            if (string.IsNullOrEmpty(iqcId))
            {
                return;
            }
            this.hdnIQCId.Value = iqcId;
            //根据IQC获取相关信息
            var entity = new MaterialIQCInfo
            {
                InspectionId = Convert.ToInt32(iqcId)
            };
            var info = new MaterialIQC().GetEntity(entity);
            if (info == null)
            {
                return;
            }
            this.ltrMRBNo.Text = info.MRBNo;
            this.lblIQCNo.Text = info.InspectionNo;
            this.hdnIQCId.Value = info.InspectionId.ToString();
            this.lblUrgentLevel.Text = info.UrgentName;
            this.lblCheckQty.Text = info.InspectionQty.ToString();
            this.lblItemCode.Text = info.ItemCode;
            this.lblItemName.Text = info.ItemName;
            this.hidIsHaveGRN.Value = info.IsGRN.ToString();
            this.hidMRBStatus.Value = info.MRBStatus.ToString();
            this.desc.Text = info.Auditing.ToString();
            bindDropIQCStatus();
            if (info.MRBStatus == 1)
            {
                this.ddlIQCStatus.SelectedValue = info.ManageResult.ToString();
            }
        }

        public void bindDropIQCStatus()
        {
            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " CheckTypeId >0";
            List<SKT.LeanMES.Model.MaterialIQCInfo> materialUnit = new SKT.LeanMES.Material.BLL.MaterialIQC().GetIQCResultAll(0, -1, "", searchSettings);
            if (materialUnit.Count > 0)
            {
                materialUnit.RemoveAll(p => p.checkTypeId == 1);
                materialUnit.RemoveAll(p => p.checkTypeId == 5);
            }
            ddlIQCStatus.DataSource = materialUnit;
            ddlIQCStatus.DataTextField = "CheckType";
            ddlIQCStatus.DataValueField = "CheckTypeId";
            ddlIQCStatus.DataBind();
            this.ddlIQCStatus.Items.Insert(0, new ListItem(Resources.lang.Choose, "-1"));
        }
    }
}