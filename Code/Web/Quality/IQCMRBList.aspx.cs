using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Quality
{
    public partial class IQCMRBList : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxServices.AjaxMaterialIQC));

            Master.SetSearchSettings = true;
            Master.PageGridView = GridView1;
            GridView1.DataSourceID = ObjectDataSource1.ID;
            Master.PageObjectDataSource = ObjectDataSource1;
            Master.RecordIDField = "InspectionId";
            Master.DefaultSortExpression = "MRBStatus ASC ,InspectionId DESC ";
            //Master.DefaultSortDirection = SortDirection.Descending;
            Common.Model.SearchSettings searchSettings = new Common.Model.SearchSettings();
            searchSettings.ExtensionCondition = " 1 = 1 ";

            string mrbNo = this.txtMRBNo.Text.Trim();//MRB单号
            string mrbStatus = this.selMRBStatus.Value;//MRB状态
            string processTimeStart = this.txtPorcessDateFrom.Value.Trim();//处理时间-起始
            string processTimeEnd = this.txtPorcessDateTo.Value.Trim();//处理时间-截止
            string iqcNo = this.txtIQCNo.Text.Trim();//IQC单号
            string verifyTimeStart = this.txtVerifyDateFrom.Value.Trim();//审核时间-起始
            string verifyTimeEnd = this.txtVerifyDateTo.Value.Trim();//审核时间-截止
            DateTime dtProcessStart;
            DateTime dtProcessEnd;
            DateTime dtVerifyStart;
            DateTime dtVerifyEnd;
            //MRB单号
            if (mrbNo.Length > 0)
            {
                searchSettings.AddCondition("MRBNo", mrbNo);
            }
            //MRB状态
            if (!string.IsNullOrEmpty(mrbStatus))
            {
                searchSettings.ExtensionCondition += " AND MRBStatus = "+ mrbStatus;
            }
            //处理时间
            if (processTimeStart.Length > 0 && DateTime.TryParse(processTimeStart, out dtProcessStart))
            {
                searchSettings.ExtensionCondition += " AND AttendDateTime >= '" + dtProcessStart.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            }
            if (processTimeEnd.Length > 0 && DateTime.TryParse(processTimeEnd, out dtProcessEnd))
            {
                searchSettings.ExtensionCondition += " AND AttendDateTime < '" + dtProcessEnd.AddDays(1).ToString("yyyy-MM-dd HH:mm:ss") + "'";
            }
            //IQC单号
            if (iqcNo.Length > 0)
            {
                searchSettings.AddCondition("InspectionNo", iqcNo);
            }
            //审核时间
            if (verifyTimeStart.Length > 0 && DateTime.TryParse(verifyTimeStart, out dtVerifyStart))
            {
                searchSettings.ExtensionCondition += " AND MRBVerifyTime >= '" + dtVerifyStart.ToString("yyyy-MM-dd HH:mm:ss") + "'";
            }
            if (verifyTimeEnd.Length > 0 && DateTime.TryParse(verifyTimeEnd, out dtVerifyEnd))
            {
                searchSettings.ExtensionCondition += " AND MRBVerifyTime < '" + dtVerifyEnd.AddDays(1).ToString("yyyy-MM-dd HH:mm:ss") + "'";
            }

            Master.SearchSettings = searchSettings;
            GridView1.PageIndex = 0;

            if (this.IsPostBack)
            {
                try
                {
                    //导出
                    if (this.hdnOperate.Value.ToLower() == "exportexcel")
                    {
                        DataSet ds = new SKT.LeanMES.DBservice.BLL.DbService().GetTbViewListDs("vwIQCMRBList", "ORDER BY InspectionId DESC", searchSettings, "InspectionId", Request.Form["hdnIdString"]);
                        var tempFiledNames = new string[] { "QualifiedQty", "FledQty" };
                        CommonMethod.ExportToSpreadsheet(ds, "IQC判定结果-" + DateTime.Now.ToString("yyyyMMddhhmmss"), this.GridView1, tempFiledNames);
                    }
                }
                catch (Exception ex)
                {
                    WebHelper.HandleException(ex);
                }
            }
        }
    }
}