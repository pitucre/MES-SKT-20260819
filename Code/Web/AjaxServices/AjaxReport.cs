using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SKT.LeanMES.PubItems;
using AjaxPro;
using System.Data;
using System.Data.SqlClient;
using SKT.MES.DAL.Marshal;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxReport
    {
        /// <summary>
        /// 更新或者增加模板列表
        /// </summary>
        /// <param name="entity">模板列表实体类</param>
        /// <returns></returns>
        /// <summary>
        /// 更新或者增加模板列表
        /// </summary>
        /// <param name="entity">模板列表实体类</param>
        /// <returns></returns>
        [AjaxMethod]
        public void EditReportTemplate(SKT.LeanMES.Report.Model.ReportInfo entity)
        {
            try
            {
                new SKT.LeanMES.Report.BLL.Report().Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public String GetResourceString(string resClass, string resKey)
        {
            string str = "";

            HttpCookie cookie = HttpContext.Current.Request.Cookies["lang"];
            string lang = cookie == null ? "zh-cn" : cookie.Value;
            Object resource = HttpContext.GetGlobalResourceObject(resClass, resKey, new System.Globalization.CultureInfo(lang));
            if (resource != null)
            {
                str = resource.ToString();
            }
            return str;
        }

        [AjaxMethod]
        public Boolean IsPermission(int userId, int popedom)
        {
            return SKT.Common.Account.BLL.Users.CheckUserIsWarrantted(userId, popedom);
        }
        [AjaxMethod]
        public void EditReportType(string reportTypeName, string reportTypeNameEN, float seq, string reportTypeId)
        {
            try
            {
                (new SKT.LeanMES.Report.BLL.Report()).EditReportType(reportTypeName, reportTypeNameEN, seq, reportTypeId, AccountController.GetCurrentUser().UserName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        [AjaxMethod]
        public string GetDsTableCol(string Table)
        {
            try
            {
                return (new PubItems.BLL.PubItems()).GetDsTableCol(Table);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return "";
            }
        }


        [AjaxMethod]
        public DataTable GetTopNCCode(DateTime StartTime,DateTime EndTime,int ItemId,int ProdOrderId,int LineId,int OpeId,int TopN)
        {
            DataTable dt = new DataTable();

             try
            {
                dt = (new SKT.LeanMES.Report.BLL.Report()).GetTopNCCode(StartTime, EndTime,ItemId,ProdOrderId,LineId,OpeId,TopN);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                 
            }

            return dt;
        }

        #region 获取IQC工作量分析汇总数据
        /// <summary>
        /// 获取IQC工作量分析汇总数据
        /// </summary>
        /// <param name="Year"></param>
        /// <param name="Month"></param>
        /// <returns></returns>
        [AjaxMethod]
        public string GetIQCWorkload(string Year, string Month)
        {
            string strJson = "";
            try
            {
                strJson = (new SKT.LeanMES.Report.BLL.Report()).GetIQCWorkload(Year, Month);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return strJson;
        }
        #endregion
    }
}