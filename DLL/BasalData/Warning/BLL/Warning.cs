using System;
using System.Collections.Generic;
using SKT.LeanMES.Warning.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warning.BLL
{
    public class Warning
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Warning 信息。
        /// </summary>
        /// <param name="entity">Warning 实体对象。</param>
        public Int32 Edit(WarningInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@WarningId", SqlDbType.Int),
                new SqlParameter("@WarningName", SqlDbType.NVarChar, 50),
                new SqlParameter("@WarningType", SqlDbType.Int),
                new SqlParameter("@WarningDesc", SqlDbType.NVarChar, 50),

                new SqlParameter("@WarningLevel", SqlDbType.Int),
                new SqlParameter("@CycleType", SqlDbType.Int),
                new SqlParameter("@CycleTime", SqlDbType.Int),
                new SqlParameter("@PreWarning", SqlDbType.Int),
                new SqlParameter("@ExecProcedures", SqlDbType.VarChar, 50),

                new SqlParameter("@MessageType", SqlDbType.Int),
                new SqlParameter("@RecipientLevel1", SqlDbType.NVarChar, 200),
                new SqlParameter("@ReceiveContent1", SqlDbType.NVarChar, 100),
                new SqlParameter("@RecipientLevel2", SqlDbType.NVarChar, 200),
                new SqlParameter("@ReceiveContent2", SqlDbType.NVarChar, 100),
                new SqlParameter("@RecipientLevel3", SqlDbType.NVarChar, 200),
                new SqlParameter("@ReceiveContent3", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),

                new SqlParameter("@NcNum", SqlDbType.Int),
                new SqlParameter("@Ratio", SqlDbType.Int),
                new SqlParameter("@LinId", SqlDbType.Int),
                new SqlParameter("@IntervalTime1", SqlDbType.Int),
                new SqlParameter("@IntervalTime2", SqlDbType.Int),
                new SqlParameter("@Solution1", SqlDbType.NVarChar, 100),
                new SqlParameter("@Solve1", SqlDbType.Int),
                new SqlParameter("@Solution2", SqlDbType.NVarChar, 100),
                new SqlParameter("@Solve2", SqlDbType.Int),
                new SqlParameter("@Solution3", SqlDbType.NVarChar, 100),
                new SqlParameter("@Solve3", SqlDbType.Int),
                new SqlParameter("@RatioNum", SqlDbType.Int),
                new SqlParameter("@WarningVal", SqlDbType.Decimal)
            };

            parms[0].Value = entity.WarningId;
            parms[1].Value = entity.WarningName;
            parms[2].Value = entity.WarningType;
            parms[3].Value = entity.WarningDesc;

            parms[4].Value = 1;
            parms[5].Value = 0;
            parms[6].Value = 1;
            parms[7].Value = 0;
            parms[8].Value = "";

            parms[9].Value = entity.MessageType;
            parms[10].Value = entity.RecipientLevel1;
            parms[11].Value = entity.ReceiveContent1;
            parms[12].Value = entity.RecipientLevel2;
            parms[13].Value = entity.ReceiveContent2;
            parms[14].Value = entity.RecipientLevel3;
            parms[15].Value = entity.ReceiveContent3;
            parms[16].Value = entity.CreateBy;
            parms[17].Value = entity.ModifyBy;
            parms[18].Value = entity.Remark;

            parms[19].Value = entity.NcNum;
            parms[20].Value = entity.Ratio;
            parms[21].Value = entity.LineId;
            parms[22].Value = entity.IntervalTime1;
            parms[23].Value = entity.IntervalTime2;
            parms[24].Value = entity.Solution1;
            parms[25].Value = entity.Solve1;
            parms[26].Value = entity.Solution2;
            parms[27].Value = entity.Solve2;
            parms[28].Value = entity.Solution3;
            parms[29].Value = entity.Solve3;
            parms[30].Value = entity.RatioNum;
            parms[31].Value = entity.WarningVal;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Warning_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarningId 字符串删除 Warning 信息。
        /// </summary>
        /// <param name="idString">WarningId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "SYS_Warning_Delete", parms);
        }

        /// <summary>
        /// 根据 WarningId 获取实体信息。
        /// </summary>
        /// <param name="warningId">WarningId。</param>
        /// <returns>Warning 实体对象。</returns>
        public WarningInfo GetInfo(Int32 warningId)
        {
            WarningInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warningId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Warning_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(3), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11),
                        rdr.GetInt32(12), rdr.GetString(13), rdr.IsDBNull(15) ? null : rdr.GetString(15),
                        rdr.GetString(16), rdr.IsDBNull(18) ? null : rdr.GetString(18), rdr.GetString(19),
                        rdr.IsDBNull(21) ? null : rdr.GetString(21), rdr.GetString(22), rdr.GetDateTime(23),
                        rdr.GetString(24), rdr.GetDateTime(25), rdr.GetString(26), rdr.GetInt32(27), rdr.GetInt32(28),
                        rdr.GetInt32(29), rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetString(32), rdr.GetInt32(33),
                        rdr.GetString(34), rdr.GetInt32(35), rdr.GetString(36), rdr.GetInt32(37));
                    entity.WarningGroup = rdr.GetInt32(2);
                    entity.WarningTypeName = rdr.GetString(4);
                    entity.RecipientLevelNames1 = rdr.GetString(14);
                    entity.RecipientLevelNames2 = rdr.GetString(17);
                    entity.RecipientLevelNames3 = rdr.GetString(20);
                    entity.LineName = rdr.GetString(38);
                    entity.RatioNum = rdr.GetInt32(39);
                    entity.WarningVal = rdr.GetDecimal(40);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Warning 实体对象。</returns>
        public WarningInfo GetInfo(String fieldValue)
        {
            WarningInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "SYS_Warning_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarningInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(3), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11),
                        rdr.GetInt32(12), rdr.GetString(13), rdr.IsDBNull(15) ? null : rdr.GetString(15),
                        rdr.GetString(16), rdr.IsDBNull(18) ? null : rdr.GetString(18), rdr.GetString(19),
                        rdr.IsDBNull(21) ? null : rdr.GetString(21), rdr.GetString(22), rdr.GetDateTime(23),
                        rdr.GetString(24), rdr.GetDateTime(25), rdr.GetString(26), rdr.GetInt32(27), rdr.GetInt32(28),
                        rdr.GetInt32(29), rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetString(32), rdr.GetInt32(33),
                        rdr.GetString(34), rdr.GetInt32(35), rdr.GetString(36), rdr.GetInt32(37));
                    entity.WarningGroup = rdr.GetInt32(2);
                    entity.WarningTypeName = rdr.GetString(4);
                    entity.RecipientLevelNames1 = rdr.GetString(14);
                    entity.RecipientLevelNames2 = rdr.GetString(17);
                    entity.RecipientLevelNames3 = rdr.GetString(20);
                    entity.LineName = rdr.GetString(38);
                    entity.RatioNum = rdr.GetInt32(39);
                    entity.WarningVal = rdr.GetDecimal(40);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Warning 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warningCount">warning 总数。</param>
        /// <returns>Warning 列表。</returns>
        public List<WarningInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarningInfo> list = new List<WarningInfo>();
            WarningInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwWarningList",
                                   "WarningId",
                                   @"[WarningId], [WarningName], [WarningGroup], [WarningType], [WarningTypeName],
                                     [WarningTypeValue], [WarningDesc], [WarningLevel], [CycleType], [CycleTime], 
                                     [PreWarning], [ExecProcedures], [MessageType], [RecipientLevel1], [RecipientLevelNames1], 
                                     [ReceiveContent1], [RecipientLevel2], [RecipientLevelNames2], [ReceiveContent2], 
                                     [RecipientLevel3], [RecipientLevelNames3], [ReceiveContent3], [CreateBy], 
                                     [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark], NcNum, 
                                     [Ratio], LinId, IntervalTime1, IntervalTime2,Solution1,Solve1,Solution2,Solve2,Solution3,Solve3,LineName,RatioNum,WarningVal", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarningInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(3), rdr.GetString(6),
                        rdr.GetInt32(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11),
                        rdr.GetInt32(12), rdr.GetString(13), rdr.IsDBNull(15) ? null : rdr.GetString(15),
                        rdr.GetString(16), rdr.IsDBNull(18) ? null : rdr.GetString(18), rdr.GetString(19),
                        rdr.IsDBNull(21) ? null : rdr.GetString(21), rdr.GetString(22), rdr.GetDateTime(23),
                        rdr.GetString(24), rdr.GetDateTime(25), rdr.GetString(26), rdr.GetInt32(27), rdr.GetInt32(28),
                        rdr.GetInt32(29), rdr.GetInt32(30), rdr.GetInt32(31), rdr.GetString(32), rdr.GetInt32(33),
                        rdr.GetString(34), rdr.GetInt32(35), rdr.GetString(36), rdr.GetInt32(37));
                    entity.WarningGroup = rdr.GetInt32(2);
                    entity.WarningTypeName = rdr.GetString(4);
                    entity.RecipientLevelNames1 = rdr.GetString(14);
                    entity.RecipientLevelNames2 = rdr.GetString(17);
                    entity.RecipientLevelNames3 = rdr.GetString(20);
                    entity.LineName = rdr.GetString(38);
                    entity.RatioNum = rdr.GetInt32(39);
                    entity.WarningVal = rdr.GetDecimal(40);
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
