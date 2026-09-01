using SKT.Common.DAL.Marshal;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ExcelHelper = SKT.LeanMES.Web.AppCode.Utility.ExcelHelper;

namespace SKT.LeanMES.Web.CustomMenu
{
    public partial class CustomMenuPage : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommon.DBService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxReport));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.Controls.PageSQLService));
            AjaxPro.Utility.RegisterTypeForAjax(typeof(SKT.LeanMES.Web.AjaxServices.AjaxSDP));
            
            if (this.IsPostBack)
            {
                string procName = Request.Form["hdnOperation"];
                string param = Request.Form["hdnPararms"];              //获取参数
                string paramValue = Request.Form["hdnPararmValue"];     //获取参数值
                string filename = Request.Form["hdnFileName"];
                string hdnTableName = Request.Form["hdnTableName"];
                if (string.IsNullOrEmpty(param)) {
                    param = hdnTableName;
                }
                if (procName != "")
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
        }
        protected String InitPage()
        {
            string pageContent = "";
            if (Request.QueryString["PaName"] != null)
            {
                pageContent = new LeanMES.CustomMenu.BLL.CustomMenu().GetContentInfo(Request.QueryString["PaName"].ToString());
            }
            return Microsoft.JScript.GlobalObject.decodeURI(pageContent);
        }

        public void ExportTable(string strTable ,string conditions ,string filename)
        {
            string strSql = "SELECT * FROM " + strTable + " WHIT(NOLOCK) WHERE 1=1";
            if (conditions != "")
            {
                strSql += conditions;
            }
            DataTable dt = SQLHelper.ExcuteDataTableSqlText(SQLHelper.MESConnString, strSql, null);
            ExcelHelper.ExportToExcel(dt, filename + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");

        }

        public void ExportToExcel(string parmsStr, string parmsValueStr, string procName, string filename)
        {
            try
            {
                SKT.LeanMES.Report.BLL.Report bll = new LeanMES.Report.BLL.Report();
                DataTable dt = bll.GetDataTableToExcel(parmsStr, parmsValueStr, procName);
                ExcelHelper.ExportToExcel(dt, filename + DateTime.Now.ToString("yyyyMMdd") + ".xls", "UTF-8");
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
        }
    }
}