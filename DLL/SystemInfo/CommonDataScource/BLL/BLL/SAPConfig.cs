using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class SAPConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Config 信息。
        /// </summary>
        /// <param name="entity">Config 实体对象。</param>
        public Int32 Edit(SAPConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@SAPHost", SqlDbType.NVarChar, 50),
                new SqlParameter("@SAPClient", SqlDbType.NVarChar, 50),
                new SqlParameter("@SAPUser", SqlDbType.NVarChar, 50),
                new SqlParameter("@SAPPwd", SqlDbType.NVarChar, 50),
                new SqlParameter("@SAPNumber", SqlDbType.NVarChar, 50),
                new SqlParameter("@SAPLang", SqlDbType.NVarChar, 50),
                new SqlParameter("@MESHost", SqlDbType.NVarChar, 50),
                new SqlParameter("@MESUser", SqlDbType.NVarChar, 50),
                new SqlParameter("@MESPwd", SqlDbType.NVarChar, 50),
                new SqlParameter("@MESDBName", SqlDbType.NVarChar, 50),
                new SqlParameter("@MESTimeout", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SAPHost;
            parms[2].Value = entity.SAPClient;
            parms[3].Value = entity.SAPUser;
            parms[4].Value = entity.SAPPwd;
            parms[5].Value = entity.SAPNumber;
            parms[6].Value = entity.SAPLang;
            parms[7].Value = entity.MESHost;
            parms[8].Value = entity.MESUser;
            parms[9].Value = entity.MESPwd;
            parms[10].Value = entity.MESDBName;
            parms[11].Value = entity.MESTimeout;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SAP_Config_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ConfigId 字符串删除 Config 信息。
        /// </summary>
        /// <param name="idString">ConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SAP_Config_Delete", parms);
        }

        /// <summary>
        /// 根据 ConfigId 获取实体信息。
        /// </summary>
        /// <param name="configId">ConfigId。</param>
        /// <returns>Config 实体对象。</returns>
        public SAPConfigInfo GetInfo(Int32 configId)
        {
            SAPConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = configId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SAP_Config_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SAPConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Config 实体对象。</returns>
        public SAPConfigInfo GetInfo(String fieldValue)
        {
            SAPConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SAP_Config_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SAPConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Config 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="configCount">config 总数。</param>
        /// <returns>Config 列表。</returns>
        public List<SAPConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SAPConfigInfo> list = new List<SAPConfigInfo>();
            SAPConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SAP_Config", "[ID]",
                "[ID], [SAPHost], [SAPClient], [SAPUser], [SAPPwd], [SAPNumber], [SAPLang], [MESHost], [MESUser], [MESPwd], [MESDBName], [MESTimeout]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SAPConfigInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetString(11));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}