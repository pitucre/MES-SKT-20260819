using System;
using System.Collections.Generic;
using System.Data.SqlClient;

using AjaxPro;
using AJAXdataHelper;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 用于无需面向对象操作数据时的轻量级数据库操作助手
    /// 此文件非必要，无需再修改
    /// </summary>
    public class PageSQLService
    {
        [AjaxMethod]
        public List<string> ExecuteNonQuery(String sqlString_OR_storeProcdureName, ParamInfo[] paramsArray)
        {
            List<string> list = null;
            try
            {
                list =  this.ExecuteNonQuery(sqlString_OR_storeProcdureName, paramsArray, SQLHelper.MESConnString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        [AjaxMethod]
        public List<EntityInfo> Search(String tableNameString, String primaryKey, String getFieldString, String searcheConditions, String sortExpression)
        {
            List<EntityInfo> list = null;
            try
            {
                list = new AjaxHelper().Search(tableNameString, primaryKey, getFieldString, searcheConditions, sortExpression,  SQLHelper.MESConnString);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException(ex);
            }
            return list;
        }

        private List<string> ExecuteNonQuery(String sqlString_OR_storeProcdureName, ParamInfo[] paramsArray, string conn)
        {
            List<string> list = null;
            try
            {
                list = new AjaxHelper().ExecuteNonQuery(sqlString_OR_storeProcdureName, paramsArray,  SQLHelper.MESConnString);
            }
            catch (SqlException exception)
            {
                HandleSqlException(exception);
                throw;
            }
            return list;
        }

        private static void HandleSqlException(SqlException ex)
        {
            SqlError error = ex.Errors[0];
            foreach (SqlError error2 in ex.Errors)
            {
                if (error2.Class == 12)
                {
                    error = error2;
                    break;
                }
            }
            if ((error.Number == 2) || (error.Number == -1073741769))
            {
                throw new DALException("DBConnectFailed");
            }
            if (error.Class != 12)
            {
                throw new DALException(string.Empty, "DBAccessError", ExceptionLevel.Error, null, ex);
            }
            string messageResourceClass = string.Empty;
            string message = error.Message;
            object[] args = null;
            int index = message.IndexOf("?");
            if (index > 0)
            {
                args = message.Substring(index + 1).Split(new char[] { '&' });
                message = message.Substring(0, index);
            }
            index = message.IndexOf(".");
            if (index > 0)
            {
                messageResourceClass = message.Substring(0, index);
                message = message.Substring(index + 1);
            }
            throw new DALException(messageResourceClass, message, ExceptionLevel.Error, args, ex);
        }
        
    }
}