using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SKT.Common.DAL.Marshal;
using ExcelHelper = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper;
using System.Configuration;

namespace SKT.LeanMES.Web.Report
{
    public partial class ReportPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxReport));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.Controls.PageSQLService));

            if (this.IsPostBack)
            {
                string procName = Request.Form["hdnOperation"];
                string param = Request.Form["hdnPararms"];              //获取参数
                string paramValue = Request.Form["hdnPararmValue"];     //获取参数值
                string filename = Request.Form["hdnFileName"];
                string fileContent = Request.Form["hdnFileContent"];    //文件内容（json格式）

                if (!string.IsNullOrEmpty(fileContent))  //支持Json格式文件内容
                {
                    ExportToExcelFromJson(filename, fileContent);
                }
                else if (!string.IsNullOrEmpty(procName))
                {
                    if (procName == "TABLE")
                    {
                        ExportTable(param, paramValue, filename);
                    }
                    else
                    {
                        ExportToExcel(param, paramValue, procName, filename);       //PROC
                    }
                }
            }
            else
            {
                if (hdnLimitExportRowCount != null)
                {
                    //获取配置的报表导出最大行数（默认10万）
                    var paramLimitExportRowCount = (new LeanMES.CommonDataSource.BLL.GlobarParameter()).GetInfo("Report_LimitExportRowCount");
                    if (paramLimitExportRowCount != null)
                    {
                        hdnLimitExportRowCount.Value = paramLimitExportRowCount.ParaValue;
                    }
                    else
                    {
                        hdnLimitExportRowCount.Value = "100000";
                    }
                }
            }
        }

        protected String InitPage()
        {
            string pageContent = "";
            if (Request.QueryString["name"] != null)
            {
                pageContent = new SKT.LeanMES.Report.BLL.Template().GetContentInfo(Request.QueryString["name"].ToString());
            }
            return Microsoft.JScript.GlobalObject.decodeURI(pageContent);
        }

        public void ExportTable(string strTable ,string conditions ,string filename)
        {
            int limitRowCount = Convert.ToInt32(hdnLimitExportRowCount.Value);
            string strSql = "SELECT * FROM " + strTable + " WHIT(NOLOCK) WHERE 1=1";
            if (conditions != "")
            {
                strSql += conditions;
            }
            strSql = string.Format("SELECT TOP {0} * FROM ({1}) A", limitRowCount, strSql);
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strSql, null);
            ExcelHelper.XSSExportToExcel(filename + DateTime.Now.ToString("yyyyMMdd") + ".xlsx", dt);
        }

        public void ExportToExcel(string parmsStr, string parmsValueStr, string procName, string filename)
        {
            try
            {
                SKT.LeanMES.Report.BLL.Report bll = new LeanMES.Report.BLL.Report();
                DataTable dt = bll.GetDataTableToExcel(parmsStr, parmsValueStr, procName);
                ExcelHelper.XSSExportToExcel(filename + DateTime.Now.ToString("yyyyMMdd") + ".xlsx", dt);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
        public void ExportToExcelFromJson(string fileName, string fileContent)
        {
            try
            {
                DataTable dt = CommonHelper.BLL.ComMethod.JsonToDataTable(fileContent);
                ExcelHelper.XSSExportToExcel(fileName + DateTime.Now.ToString("yyyyMMdd") + ".xlsx", dt);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
    }
}