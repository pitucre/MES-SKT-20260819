using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Report
{
	public partial class ReportTypeEdit : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxReport)); 
            string reportTypeId = Request.QueryString["ID"];
            if (reportTypeId != "-1")
            {
                SKT.LeanMES.Report.BLL.Report bll = new LeanMES.Report.BLL.Report();
                SKT.LeanMES.Report.Model.ReportInfo model = bll.GetReportTypeInfo(reportTypeId);
                if (model != null)
                {
                    this.txtReportTypeNameCN.Text = model.RTModuleCNValue.ToString();
                    this.txtReportTypeNameEN.Text = model.RTModuleENValue.ToString();
                    this.txtSequence.Text = model.RTDescription.ToString();
                }
            }
		}
	}
}