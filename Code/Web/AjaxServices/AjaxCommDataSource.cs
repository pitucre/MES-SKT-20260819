using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AjaxPro;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonDataSource.BLL;

namespace SKT.LeanMES.Web.AjaxServices
{
    public class AjaxCommDataSource
    {
        /// <summary>
        /// 用户数据源编辑检查
        /// </summary>
        /// <returns>0,-1（受影响行数）</returns>
        [AjaxMethod]
        public int CheckSqlText(string dbType, string sqlText)
        {
            try
            {
                var bll = new SKT.LeanMES.CommonDataSource.BLL.DataSource();
                return bll.CheckSql(dbType, sqlText);
                //return 1;
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
                return 0;
            }
        }

        /// <summary>
        /// 用户数据源编辑检查
        /// </summary>
        /// <returns>0,1</returns>
        [AjaxMethod]
        public void SaveEdit(CommonDataSourceInfo entity)
        {
            try
            {
                var bll = new SKT.LeanMES.CommonDataSource.BLL.DataSource();
                bll.Edit(entity);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
        }

        /// <summary>
        /// 获取数据源信息
        /// </summary> 
        [AjaxMethod]
        public string GetJsonInfo(string procName)
        {
            string str = "";
            try
            {
                str = (new DataSource()).GetJsonInfo(procName);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return str;
        }
    }
}