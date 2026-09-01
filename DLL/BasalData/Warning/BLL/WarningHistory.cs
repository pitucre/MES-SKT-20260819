using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.Warning.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warning.BLL
{
    public class WarningHistory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarningHistory 信息。
        /// </summary>
        /// <param name="entity">WarningHistory 实体对象。</param>
        public void SaveOneSolve(int warninghistoryId, string txtOneSolve, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarHistoryId", SqlDbType.Int),
                new SqlParameter("@OneSolve", SqlDbType.NVarChar, 200),
                new SqlParameter("@CloseBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = warninghistoryId;
            parms[1].Value = txtOneSolve;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveWarningOneSolve", parms);
        }

        public void SaveTwoSolve(int warninghistoryId, string txtTwoSolve, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarHistoryId", SqlDbType.Int),
                new SqlParameter("@TwoSolve", SqlDbType.NVarChar, 200),
                new SqlParameter("@CloseBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = warninghistoryId;
            parms[1].Value = txtTwoSolve;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveWarningTwoSolve", parms);
        }

        public void SaveThreeSolve(int warninghistoryId, string txtThreeSolve, string userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarHistoryId", SqlDbType.Int),
                new SqlParameter("@ThreeSolve", SqlDbType.NVarChar, 200),
                new SqlParameter("@CloseBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = warninghistoryId;
            parms[1].Value = txtThreeSolve;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspSaveWarningThreeSolve", parms);
        }

        /// <summary>
        /// 根据 WarningHistoryId 字符串删除 WarningHistory 信息。
        /// </summary>
        /// <param name="idString">WarningHistoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_WarningHistory_Delete", parms);
        }

        /// <summary>
        /// 根据 WarningHistoryId 获取实体信息。
        /// </summary>
        /// <param name="warningHistoryId">WarningHistoryId。</param>
        /// <returns>WarningHistory 实体对象。</returns>
        public WarningHistoryInfo GetInfo(Int32 warningHistoryId)
        {
            WarningHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warningHistoryId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_WarningHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarningHistory 实体对象。</returns>
        public WarningHistoryInfo GetInfo(String fieldValue)
        {
            WarningHistoryInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_WarningHistory_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarningHistory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warningHistoryCount">warningHistory 总数。</param>
        /// <returns>WarningHistory 列表。</returns>
        public List<WarningHistoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarningHistoryInfo> list = new List<WarningHistoryInfo>();
            WarningHistoryInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSYS_WarningHistory", "WarHistoryId",////SYS_WarningHistory
                "[WarHistoryId], [OrderNo], [LineName], [WarningName], [WarningType], [Ratio], [NcNum], [WeekType], [OneSolve], [TowSolve], [ThreeSolve], [Status], [CloseBy], [CloseDateTime], [CreateDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarningHistoryInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetInt32(5), rdr.GetInt32(6), rdr.GetString(7), rdr.GetString(8), rdr.GetString(9),
                        rdr.GetString(10), rdr.GetInt32(11), rdr.GetString(12), rdr.GetDateTime(13), rdr.GetDateTime(14));

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
