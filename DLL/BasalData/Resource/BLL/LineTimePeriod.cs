using System;
using System.Collections.Generic;
using System.Text;
using SKT.LeanMES.Resource.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Resource.BLL
{

    public class LineTimePeriod
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） LineTimePeriod 信息。
        /// </summary>
        /// <param name="entity">LineTimePeriod 实体对象。</param>
        public Int32 Edit(LineTimePeriodInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TimePeriodId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StartDatetime", SqlDbType.DateTime),
                new SqlParameter("@EndDatetime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.TimePeriodId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.StartDatetime;
            parms[3].Value = entity.EndDatetime;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LineTimePeriod_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 LineTimePeriodId 字符串删除 LineTimePeriod 信息。
        /// </summary>
        /// <param name="idString">LineTimePeriodId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_LineTimePeriod_Delete", parms);
        }

        /// <summary>
        /// 根据 LineTimePeriodId 获取实体信息。
        /// </summary>
        /// <param name="lineTimePeriodId">LineTimePeriodId。</param>
        /// <returns>LineTimePeriod 实体对象。</returns>
        public LineTimePeriodInfo GetInfo(Int32 lineTimePeriodId)
        {
            LineTimePeriodInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = lineTimePeriodId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LineTimePeriod_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineTimePeriodInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>LineTimePeriod 实体对象。</returns>
        public LineTimePeriodInfo GetInfo(String fieldValue)
        {
            LineTimePeriodInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_LineTimePeriod_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new LineTimePeriodInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 LineTimePeriod 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="lineTimePeriodCount">lineTimePeriod 总数。</param>
        /// <returns>LineTimePeriod 列表。</returns>
        public List<LineTimePeriodInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<LineTimePeriodInfo> list = new List<LineTimePeriodInfo>();
            LineTimePeriodInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_LineTimePeriod", "TimePeriodId",
                "[TimePeriodId], [LineId], [StartDatetime], [EndDatetime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new LineTimePeriodInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8));

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