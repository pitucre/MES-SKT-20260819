using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.Report
{
    public partial class ReportTemplateEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReport));

            if (!IsPostBack)
            {
                this.ddlReport.Items.Insert(0, new ListItem("=选择=", ""));

                int reportId = Convert.ToInt32(Request.QueryString["ID"]);
                if (reportId != -1)
                {
                    SKT.LeanMES.Report.Model.ReportInfo model = new LeanMES.Report.BLL.Report().GetInfo(reportId);
                    if (model != null)
                    {
                        this.txtReportCNName.Text = model.ReportCNName;
                        this.hdnReportName.Value = model.TemplateName;
                        this.txtReportENName.Text = model.ReportENName;
                        this.hdnIcon.Value = model.ReportIcon;
                        this.txtSequence.Text = model.ReportSequence.ToString();
                        this.ddlReport.SelectedValue = model.ReportType;
                        this.txtTmplDesc.Text = model.RTDescription;
                        this.hdnValue.Value = (String.IsNullOrEmpty(model.TemplateContent)) ? "" : model.TemplateContent;
                        hfDesignJson.Value = model.DesignJson ?? "";
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