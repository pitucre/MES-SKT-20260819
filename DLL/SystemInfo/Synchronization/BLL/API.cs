using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Synchronization.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Synchronization.BLL
{
    public class API
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） API 信息。
        /// </summary>
        /// <param name="entity">API 实体对象。</param>
        public Int32 Edit(APIInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int),
                new SqlParameter("@BusinessName", SqlDbType.NVarChar, 200),
                new SqlParameter("@FuncName", SqlDbType.NVarChar, 200),
                new SqlParameter("@SapParam", SqlDbType.NVarChar, 2000),
                new SqlParameter("@SapParamDesc", SqlDbType.NVarChar, 2000),
                new SqlParameter("@SapFields", SqlDbType.NVarChar, 2000),
                new SqlParameter("@TargetTabName", SqlDbType.NVarChar, 200),
                new SqlParameter("@TargetTabFields", SqlDbType.NVarChar, 2000),
                new SqlParameter("@SapTabName", SqlDbType.NVarChar,200),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200)
            };

            parms[0].Value = entity.ID;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.BusinessName;
            parms[2].Value = entity.FuncName;
            parms[3].Value = entity.SapParam;
            parms[4].Value = entity.SapParamDesc;
            parms[5].Value = entity.SapFields;
            parms[6].Value = entity.TargetTabName;
            parms[7].Value = entity.TargetTabFields;
            parms[8].Value = entity.SapTabName;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SAP_API_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 APIId 字符串删除 API 信息。
        /// </summary>
        /// <param name="idString">APIId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SAP_API_Delete", parms);
        }

        /// <summary>
        /// 根据 APIId 获取实体信息。
        /// </summary>
        /// <param name="aPIId">APIId。</param>
        /// <returns>API 实体对象。</returns>
        public APIInfo GetInfo(Int32 aPIId)
        {
            APIInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ID", SqlDbType.Int)
            };

            parms[0].Value = aPIId;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SAP_API_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new APIInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                          rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

       

        /// <summary>
        /// 分页获取 API 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aPICount">aPI 总数。</param>
        /// <returns>API 列表。</returns>
        public List<APIInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<APIInfo> list = new List<APIInfo>();
            APIInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SAP_API", "ID",
                "[ID], [BusinessName], [FuncName], [SapParam], [SapParamDesc], [SapTabName], [SapFields], [TargetTabName], [TargetTabFields], [AutoHZ], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new APIInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetString(8), rdr.GetInt32(9), rdr.GetString(10));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        public List<ExeclogInfo> GetAllLog(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ExeclogInfo> list = new List<ExeclogInfo>();
            ExeclogInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "SAP_Execlog", "ID",
                "[ID], [FuncName], [ParamName], [ParamValue], [SapCode], [SapMsg], [MesMsg], [ExecUser], [CreateDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ExeclogInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(6), rdr.GetString(7), rdr.GetDateTime(8));

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