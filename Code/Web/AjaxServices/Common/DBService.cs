using System;
using System.Collections.Generic;
using AjaxPro;
using AJAXdataHelper;
using SKT.LeanMES.Web;
using System.Data;
using SKT.Common.Model;
using SKT.LeanMES.DBservice.BLL;
using System.Text;
using SKT.LeanMES.Web.AjaxServices.CommonTemplate;
using System.Data.SqlClient;
using SKT.LeanMES.Supplier.Model;

namespace SKT.AjaxCommon
{
    /// <summary>
    /// 用于无需面向对象操作数据时的轻量级数据库操作助手
    /// 此文件非必要，无需再修改
    /// </summary>
    public class DBService
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 前端调用执行
        /// </summary>
        /// <param name="sqlString_OR_storeProcdureName">SQL语句或存储过程</param>
        /// <param name="paramsArray">参数,存储过程参数数组，如果执行的是SQL语句，则直接传入空数组[]即可</param>
        /// <returns>返回受影响的行数</returns>
        [AjaxMethod]
        public List<string> ExecuteNonQuery(String sqlString_OR_storeProcdureName, ParamInfo[] paramsArray)
        {
            List<string> list = new List<string>();

            list = new AjaxHelper().ExecuteNonQuery(sqlString_OR_storeProcdureName, paramsArray, SKT.Common.DAL.Marshal.SQLHelper.MESConnString);

            return list;

        }

        /// <summary>
        /// 前端调用查询
        /// </summary>
        /// <param name="tableNameString">表名或视图</param>
        /// <param name="primaryKey">主键</param>
        /// <param name="getFieldString">需要返回的列</param>
        /// <param name="searcheConditions">查询条件，如果没有则为""</param>
        /// <param name="sortExpression">排序条件，如果没有则为""</param>
        /// <returns>返回对象数组，如[obj1,obj2,obj3...]</returns>
        [AjaxMethod]
        public List<EntityInfo> Search(String tableNameString, String primaryKey, String getFieldString, String searcheConditions, String sortExpression)
        {
            List<EntityInfo> list = new List<EntityInfo>();

            list = new AjaxHelper().Search(tableNameString, primaryKey, getFieldString, searcheConditions, sortExpression, SKT.Common.DAL.Marshal.SQLHelper.MESConnString);

            return list;
        }

        /// <summary>
        /// 分页获取列表数据
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="strTb">表名或者视图</param>
        /// <param name="strKey">主键</param>
        /// <returns>AgingBasic 列表。</returns>
        [AjaxMethod]
        public DataSet GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings, String strTb, String strKey)
        {
            try
            {
                return (new DbService()).GetAll2(startRow, maxRows, sortExpression, searchSettings, strTb, ref recordCount);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, true);
            }
            return null;
        }

        /// <summary>
        /// 获取行数
        /// </summary>
        /// <param name="searchSettings"></param>
        /// <param name="strTb"></param>
        /// <param name="strKey"></param>
        /// <returns></returns>
        public Int32 GetCount(SearchSettings searchSettings, String strTb, String strKey)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 执行存储过程进行编辑储存等动作 --通过临时表传列表数据给存储过程
        /// 注：(使用此方法写的存储过程，内部不需写事务， 最外层已启用事务，执行失败时自动回滚)
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">Json参数字串
        /// Json字串 属性TempColumns 是包含要存储如临时表的列表, 该栏位字串格式为 Columns1,Columns2,Columns3 ...
        /// 生成的临时表 #TempTable， #TempTable1， #TempTable2...
        /// </param>
        /// <returns>Json字串</returns>
        [AjaxMethod]
        public string ExcuteSpcByTemp(string strSpc, string strJson, DataSet ds = null)
        {
            try
            {
                return (new DbService()).ExcuteSpcByTemp(strSpc, strJson, null);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return "{}";
        }

        /// <summary>
        /// 前端JS调用存储过程
        /// </summary>
        /// <param name="strSpName">存储过程</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>strJson</returns>
        [AjaxMethod]
        public string UIExecuteSpc(String strSpcName, string strJson)
        {
            try
            {
                //解密存储过程名称
                strSpcName = Encoding.Default.GetString(Convert.FromBase64String(AjaxHelper.DecryptDES(strSpcName, "_SKtMeS$")));
                return (new DbService()).ExecSpc(strSpcName, strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return "{}";
        }

        /// <summary>
        /// 调用存储过程
        /// </summary>
        /// <param name="strSpName">存储过程</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns>strJson</returns>
        [AjaxMethod]
        public string ExecuteSpc(String strSpcName, string strJson,string type="0")
        {
            try
            {
                //by liwen 20200724 二开支持GUID
                if (type == "1")
                {
                    return ComMethodTemplate.EditBack(strJson, strSpcName);
                }
                else
                {
                    return (new DbService()).ExecSpc(strSpcName, strJson);
                }
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return "{}";
        }

        [AjaxMethod]
        public Object GetEntity(String strSpcName, string strJson) {
            return  ComMethodTemplate.GetEntity(strJson, strSpcName);
        }

        /// <summary>
        /// 根据存储过程获取列表数据--返回Json字串--格式为｛data:[{},{}];data1:[{},{}]....｝
        /// -- add by Fengyuan.Fu on 2017/07/13
        /// </summary>
        /// <param name="strSpc">储存过程名称</param>
        /// <param name="strJson">参数Json字串</param>
        /// <returns></returns>
        [AjaxMethod]
        public string SearchList(string strSpc, string strJson)
        {
            try
            {
                return (new DbService()).GetList(strSpc, strJson);
            }
            catch (Exception ex)
            {
                WebHelper.HandleException("", ex, false);
            }
            return "{}";
        }
    }
}