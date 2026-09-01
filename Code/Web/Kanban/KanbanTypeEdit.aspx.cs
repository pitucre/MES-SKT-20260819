using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Kanban
{
    public partial class KanbanTypeEdit : BasePage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxKanban)); 
            string reportTypeId = Request.QueryString["ID"];
            if (reportTypeId != "-1")
            {
                SKT.LeanMES.Report.BLL.Report bll = new LeanMES.Report.BLL.Report();
                SKT.LeanMES.Report.Model.ReportInfo model = bll.GetReportTypeInfo(reportTypeId);
                if (model != null)
                {
                    txtKanbanTypeNameCN.Text = model.RTModuleCNValue;
                    txtKanbanTypeNameEN.Text = model.RTModuleENValue;
                    txtSequence.Text = model.RTDescription;
                }
            }
		}
	}
}