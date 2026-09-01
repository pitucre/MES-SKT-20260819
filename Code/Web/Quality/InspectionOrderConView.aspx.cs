using SKT.LeanMES.Quality.BLL;
using SKT.LeanMES.Quality.Model;
using SKT.LeanMES.Web.AjaxServices;
using System;

namespace SKT.LeanMES.Web.Quality
{
    public partial class InspectionOrderConView : BasePage
    {
        public int Id = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxInspection));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxQC));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxMaterialIQC));
            
            if (Request["Id"] != null)
            {
                Id = Convert.ToInt32(Request["Id"]);

                InspectionOrder bll = new InspectionOrder();
                InspectionOrderInfo info = bll.GetInfo(Id);
                InspectionTypeInfo TypeInfo = new InspectionTypeInfo();
               
                if (info != null)
                {
                    this.IOrder.Value = info.InspectionOrderNo;
                    this.lblInspectionNo.Text = info.InspectionOrderNo;
                    this.lblCreatetime.Text = info.CreateDateTime.ToString();
                    this.spanTypeName.InnerText = info.InspectionSelectType;
                    //this.lblOrderNo.Text = info.SourceTarget;
                    //this.lblOrderQty.Text = info.OrderQty.ToString();
                    this.lblItemName.Text = info.ItemName;
                    this.lblLineName.Text = info.LineName;
                    //this.lblStation.Text = info.InspectionTemplateName;
                    //this.lblClass.Text = info.Class;
                    this.lblSendMan.Text = info.SendMan;
                    //this.lblSampleQty.Text = info.SampleQty.ToString();
                   // this.lblProjectAffirmRemark.Text = info.ProjectAffirmRemark;
                    this.lblIPQC.Text = info.CreateBy;
                    this.txtGroupRmark.Text = info.GroupAffirmRemark;
                    this.txtProjectRmark.Text = info.ProjectAffirmRemark;
                    this.txtAuditRmark.Text = info.AuditRemark;
                    string groupstatus = info.GroupAffirmStatus.ToString();
                    string GroupBy = "";
                    if (groupstatus == "0")
                    {
                        this.lblGroupAffirm.Text = "通过";
                        GroupBy = info.GroupAffirmBy;
                    }
                    else if (groupstatus == "1") {
                        this.lblGroupAffirm.Text = "不通过";
                        GroupBy = info.GroupAffirmBy;
                    }
                    else
                    {
                        this.lblGroupAffirm.Text = "";
                        GroupBy = "";
                    }
                    this.lblGroupAffirmBy.Text = GroupBy;

                    string projectStatus = info.ProjectAffirmStatus.ToString();
                    string projectBy = "";
                    if (projectStatus == "0")
                    {
                        this.lblProjectAffirm.Text = "通过";
                        projectBy = info.ProjectAffirmBy;
                    }
                    else if (projectStatus == "1")
                    {
                        this.lblProjectAffirm.Text = "不通过";
                        projectBy = info.ProjectAffirmBy;
                    }
                    else
                    {
                        this.lblProjectAffirm.Text = "";
                        projectBy = "";
                    }
                    this.lblProjectAffirmBy.Text = projectBy;
                   
                    string auditText = info.AuditResult;
                    string auditBy = "";
                    if (auditText == "2")
                    {
                        this.lblAuditResult.Text = "通过";
                        auditBy = info.AuditBy;
                    }
                    else if (auditText == "3")
                    {
                        this.lblAuditResult.Text = "不通过";
                         auditBy = info.AuditBy;
                    }
                    else {
                        this.lblAuditResult.Text = "";
                        auditBy ="";
                    }
                    this.lblAuditBy.Text = auditBy;
                    this.lblJYDate.Text = info.JYDate.ToString();
                    this.lblSJDate.Text = info.SYDate.ToString();
                    this.lblResult.Text = info.Result == 1 ? "OK" : info.Result == 0 ? "NG" : "";

                    this.lblMoudle.Text = info.MoudleCode.ToString();
                    this.lblDryingMaterialTemperature.Text = info.DryingMaterialTemperature.ToString();
                    this.lblHotRunnerTemperature.Text = info.HotRunnerTemperature.ToString();
                    this.lblBarrelTemperature1.Text = info.BarrelTemperature1.ToString();
                    this.lblBarrelTemperature2.Text = info.BarrelTemperature2.ToString();
                    this.lblBarrelTemperature3.Text = info.BarrelTemperature3.ToString();
                    this.lblBarrelTemperature4.Text = info.BarrelTemperature4.ToString();
                    this.lblBarrelTemperature5.Text = info.BarrelTemperature5.ToString();
                    this.lblMoldTemperatureDynamic.Text = info.MoldTemperatureDynamic.ToString();
                    this.lblMoldTemperatureStatic.Text = info.MoldTemperatureStatic.ToString();
                    this.lblMaterialItemCode.Text = info.MaterialItemCode.ToString();
                    this.lblMaterialItemName.Text = info.MaterialItemName.ToString();
                    this.lblMaterialItemSpc.Text=info.MaterialItemSpec.ToString();
                    this.lblMaterialItemLot.Text = info.MaterialItemLot.ToString();
                    TypeInfo = new InspectionType().GetInfo(info.InspectionTypeId);
                    if (info != null)
                    {
                        this.IQCType.Value = TypeInfo.SystemType.ToString();
                    }
               }
            }
        }
    }
}