using System;
using System.Web.UI.WebControls;
using SKT.LeanMES.Sparepart.BLL;
using System.Data;
using System.Web;

namespace SKT.LeanMES.Web.ESOP
{
    public partial class ESOPAuditList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxEsop));
            this.Master.PageGridView = this.GridView1;
            this.Master.PageObjectDataSource = this.ObjectDataSource1;
            this.Master.RecordIDField = "ESOPId";
            this.Master.DefaultSortExpression = " AuditNo Desc ";

            SKT.Common.Model.SearchSettings searchSettings = new SKT.Common.Model.SearchSettings();

            searchSettings.ExtensionCondition = " 1=1 ";
            if (txtAuditNo.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and AuditNo like '%" + txtAuditNo.Text.Trim() + "%' ";
            }
            if (txtESOPName.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and ESOPName like '%" + txtESOPName.Text.Trim() + "%' ";
            }
            if (txtESOPStationName.Text.Trim() != "")
            {
                searchSettings.ExtensionCondition += " and StationName like '%" + txtESOPStationName.Text.Trim() + "%' ";
            }
            if (ddlIsEnableName.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " and IsEnableName='" + ddlIsEnableName.SelectedValue + "' ";
            }
            if (ddlAuditStates.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " and AuditStates ='" + ddlAuditStates.SelectedValue + "' ";
            }
            if (ddlApprovalStates.SelectedValue != "-1")
            {
                searchSettings.ExtensionCondition += " and IsEnableApproval ='" + ddlApprovalStates.SelectedValue + "' ";
            }
            this.Master.SearchSettings = searchSettings;
            this.GridView1.PageIndex = 0;
            
        }

        
        protected void GridView1_OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }
        }
    }
}