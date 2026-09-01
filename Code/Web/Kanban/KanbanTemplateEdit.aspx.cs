using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanTemplateEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban));

            if (!IsPostBack)
            {
                hfRptTypeJson.Value = new PubItems.BLL.PubItems().GetRptType("LeanMES_Kanban");
                int reportId = Convert.ToInt32(Request.QueryString["ID"]);
                if (reportId != -1)
                {   
                    SKT.LeanMES.Kanban.Model.MasterInfo model = new LeanMES.Kanban.BLL.Master().GetInfo(reportId);
                    if (model != null)
                    {
                        this.txtReportCNName.Text = model.ReportCNName;
                        this.hdnReportName.Value = model.TemplateName;
                        this.txtReportENName.Text = model.ReportENName;
                        this.hdnIcon.Value = model.ReportIcon;
                        this.txtSequence.Text = model.ReportSequence.ToString();
                        this.hfSelectedType.Value = model.ReportType;
                        this.txtTmplDesc.Text = model.RTDescription;
                        //从-1开始，因此需要+1
                        selTypeL.SelectedIndex = model.TitleLType +1;
                        selTypeM.SelectedIndex = model.TitleMType +1;
                        selTypeR.SelectedIndex = model.TitleRType +1;
                        txtTitleLeft.Value = model.TitleLValue;
                        txtTitleRight.Value = model.TitleRValue;
                        txtTitleMid.Value = model.TitleMValue;
                        txtTitleLAttr.Value = model.TitleLCss;
                        txtTitleMAttr.Value = model.TitleMCss;
                        txtTitleRAttr.Value = model.TitleRCss;
                        txtFoot.Text = model.FootHtml;

                        //hfDesignJson.Value = model.DesignJson ?? "";
                        if (model.ReportIcon != "")
                        {
                            ClientScript.RegisterStartupScript(this.GetType(), "setReportIcon", "$(\"#reportIcon\").html(\"<img src='../Content/Theme/Metro/Images/Icon/" + model.ReportIcon + "'/>\");", true);
                        }
                    }

                }
            }
        }
    }
}