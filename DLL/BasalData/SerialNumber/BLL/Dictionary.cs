using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class Dictionary
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 根据 DictionaryDataID 获取实体信息。
        /// </summary>
        /// <param name="DictionaryDataID">DictionaryDataID。</param>
        /// <returns>Dictionary 实体对象。</returns>
        public DictionaryInfo GetInfo(Int32 dictionaryId)
        {
            DictionaryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = dictionaryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Dictionary_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DictionaryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据fieldValue 返回List集合
        /// </summary>
        /// <param name="dictionaryId"></param>
        /// <returns></returns>
        public List<DictionaryInfo> GetListInfo(string fieldValue)
        {
            List<DictionaryInfo> dicList = new List<DictionaryInfo>();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Dictionary_GetInfo", parms))
            {
                while (rdr.Read())
                {
                    dicList.Add(new DictionaryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9)));
                }
                rdr.Close();
            }

            return dicList;
        }


        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Dictionary 实体对象。</returns>
        public DictionaryInfo GetInfo(String fieldValue)
        {
            DictionaryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Dictionary_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new DictionaryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Dictionary 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="dictionaryCount">dictionary 总数。</param>
        /// <returns>Dictionary 列表。</returns>
        public List<DictionaryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<DictionaryInfo> list = new List<DictionaryInfo>();

            //表名或者视图
            string strTb = "vwDictionary";
            //主键
            string strKey = "DictionaryDataID";
            //查询栏位字串
            string strColumns = @"[DictionaryDataID], [Name], [DicProperty], [Description], [Value], [Remark], [CreateDateTime], [CreateBy]";
             
            list = ComMethod.GetComList<DictionaryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        #region 保存刷新时间
        /// <summary>
        /// 保存刷新时间
        /// </summary>
        /// <param name="TimeType"></param>
        /// <param name="TimeVaule"></param>
        public void SaveRefreshTime(string TimeType, string TimeVaule)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TimeType", SqlDbType.VarChar, 50),
                new SqlParameter("@TimeVaule", SqlDbType.VarChar, 50)
            };
            parms[0].Value = TimeType;
            parms[1].Value = TimeVaule;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveRefreshTime", parms);
        }
        #endregion

        /// <summary>
        /// Add By QiQuan.Zhong 2016-01-19
        /// </summary>
        /// <param name="whereStr">Where条件</param>
        /// <returns></returns>
        public List<DictionaryInfo> GetAllByProperty(string whereStr)
        {
            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = whereStr;
            return GetAll(0, int.MaxValue, "DictionaryDataID", searchSettings);
        }

    }
}