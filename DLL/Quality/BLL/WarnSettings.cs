using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Quality.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class WarnSettings
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarnSettings 信息。
        /// </summary>
        /// <param name="entity">WarnSettings 实体对象。</param>
        public Int32 Edit(WarnSettingsInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarnSettingsId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@WarnType", SqlDbType.TinyInt),
                new SqlParameter("@WarnLevel", SqlDbType.TinyInt),
                new SqlParameter("@Yield", SqlDbType.Decimal),
                new SqlParameter("@ReciveUsers", SqlDbType.NVarChar, 500),
                new SqlParameter("@Contents", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.WarnSettingsId;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.LineId;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.WarnType;
            parms[5].Value = entity.WarnLevel;
            parms[6].Value = entity.Yield;
            parms[7].Value = entity.ReciveUsers;
            parms[8].Value = entity.Contents;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_WarnSettings_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarnSettingsId 字符串删除 WarnSettings 信息。
        /// </summary>
        /// <param name="idString">WarnSettingsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_WarnSettings_Delete", parms);
        }

        /// <summary>
        /// 根据 WarnSettingsId 获取实体信息。
        /// </summary>
        /// <param name="warnSettingsId">WarnSettingsId。</param>
        /// <returns>WarnSettings 实体对象。</returns>
        public WarnSettingsInfo GetInfo(Int32 warnSettingsId)
        {
            WarnSettingsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warnSettingsId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_WarnSettings_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarnSettingsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetByte(4), 
                        rdr.GetByte(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ItemName = rdr.GetString(14);
                    entity.StationName = rdr.GetString(15);
                    entity.ReciveUsersId = rdr.GetString(16);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>WarnSettings 实体对象。</returns>
        public WarnSettingsInfo GetInfo(String fieldValue)
        {
            WarnSettingsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_WarnSettings_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarnSettingsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetByte(4), 
                        rdr.GetByte(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ItemName = rdr.GetString(14);
                    entity.StationName = rdr.GetString(15);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarnSettings 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warnSettingsCount">warnSettings 总数。</param>
        /// <returns>WarnSettings 列表。</returns>
        public List<WarnSettingsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarnSettingsInfo> list = new List<WarnSettingsInfo>();
            WarnSettingsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwWarnSettings", "WarnSettingsId",
                "[WarnSettingsId], [ItemId], [LineId], [StationId], [WarnType], [WarnLevel], [Yield], [ReciveUsers], [Contents], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy],[LineName],[ItemName],[Station]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarnSettingsInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetByte(4), 
                        rdr.GetByte(5), rdr.GetDecimal(6), rdr.GetString(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ItemName = rdr.GetString(14);
                    entity.StationName = rdr.GetString(15);
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