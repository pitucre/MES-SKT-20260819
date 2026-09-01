using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Station.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class StationTestCount
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationTestCount 信息。
        /// </summary>
        /// <param name="entity">StationTestCount 实体对象。</param>
        public Int32 Edit(StationTestCountInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationTestCountId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@Description", SqlDbType.NVarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@PassTimes", SqlDbType.Int),
                new SqlParameter("@FailTimes", SqlDbType.Int)
            };

            parms[0].Value = entity.StationTestCountId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.StationId;
            parms[2].Value = entity.Description;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.ItemId;
            parms[6].Value = entity.MaxPassTimes;
            parms[7].Value = entity.MaxFailTimes;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationTestCount_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 StationTestCountId 字符串删除 StationTestCount 信息。
        /// </summary>
        /// <param name="idString">StationTestCountId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationTestCount_Delete", parms);
        }

        /// <summary>
        /// 根据 StationTestCountId 获取实体信息。
        /// </summary>
        /// <param name="stationTestCountId">StationTestCountId。</param>
        /// <returns>StationTestCount 实体对象。</returns>
        public StationTestCountInfo GetInfo(Int32 stationTestCountId)
        {
            StationTestCountInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = stationTestCountId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationTestCount_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationTestCountInfo();
                    entity.StationTestCountId = rdr.GetInt32(0);
                    entity.StationId = rdr.GetInt32(1);
                    entity.Station = rdr.GetString(2);
                    entity.Description = rdr.GetString(3);
                    entity.ItemId = rdr.GetInt32(4);
                    entity.ItemCode = rdr.GetString(5);
                    entity.MaxPassTimes = rdr.GetInt32(6);
                    entity.MaxFailTimes = rdr.GetInt32(7);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationTestCount 实体对象。</returns>
        public StationTestCountInfo GetInfo(String fieldValue)
        {
            StationTestCountInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_StationTestCount_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new StationTestCountInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(3), rdr.GetString(4),
                        rdr.GetString(5), rdr.GetString(7));
                    entity.Station = rdr.GetString(2);
                    entity.CreateDateTime = rdr.GetDateTime(6);
                    entity.ModifyDateTime = rdr.GetDateTime(8);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 StationTestCount 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationTestCountCount">stationTestCount 总数。</param>
        /// <returns>StationTestCount 列表。</returns>
        public List<StationTestCountInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationTestCountInfo> list = new List<StationTestCountInfo>();
            StationTestCountInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwSearchStationCount", "StationTestCountId",
                "[StationTestCountId], [StationId],[Station],[Description],[CreateBy],[CreateDateTime],[ItemCode],[MaxPassTimes],[MaxFailTimes],[ModifyBy],[ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new StationTestCountInfo();
                    entity.StationTestCountId = rdr.GetInt32(0);
                    entity.StationId = rdr.GetInt32(1);
                    entity.Station =rdr.GetString(2);
                    entity.Description = rdr.GetString(3);
                    entity.CreateBy = rdr.GetString(4);
                    entity.CreateDateTime = rdr.GetDateTime(5);
                    entity.ItemCode = rdr.GetString(6);
                    entity.MaxPassTimes = rdr.GetInt32(7);
                    entity.MaxFailTimes = rdr.GetInt32(8);
                    entity.ModifyBy = rdr.GetString(9);
                    entity.ModifyDateTime = rdr.GetDateTime(10);

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
