using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class SerialNumberSeed
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SerialNumberSeed 信息。
        /// </summary>
        /// <param name="entity">SerialNumberSeed 实体对象。</param>
        public Int32 Edit(SerialNumberSeedInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SerialNumberSeedId", SqlDbType.Int),
                new SqlParameter("@SerialNumberID", SqlDbType.Int),
                new SqlParameter("@Sequence_Base", SqlDbType.BigInt),
                new SqlParameter("@Number_Sequence", SqlDbType.NVarChar, 50),
                new SqlParameter("@Max_Seq", SqlDbType.BigInt),
                new SqlParameter("@Sequence_Length", SqlDbType.BigInt),
                new SqlParameter("@Current_Sequence", SqlDbType.BigInt),
                new SqlParameter("@Min_Sequence", SqlDbType.BigInt),
                new SqlParameter("@IncrementBy", SqlDbType.BigInt),
                new SqlParameter("@Warning", SqlDbType.BigInt),
                new SqlParameter("@Reset", SqlDbType.VarChar, 1),
                new SqlParameter("@ResetDate", SqlDbType.DateTime),
                new SqlParameter("@LastUpdate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.SerialNumberSeedId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.SerialNumberID;
            parms[2].Value = entity.Sequence_Base;
            parms[3].Value = entity.Number_Sequence;
            parms[4].Value = entity.Max_Seq;
            parms[5].Value = entity.Sequence_Length;
            parms[6].Value = entity.Current_Sequence;
            parms[7].Value = entity.Min_Sequence;
            parms[8].Value = entity.IncrementBy;
            parms[9].Value = entity.Warning;
            parms[10].Value = entity.Reset;
            parms[11].Value = entity.ResetDate;
            parms[12].Value = entity.LastUpdate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberSeed_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SerialNumberSeedId 字符串删除 SerialNumberSeed 信息。
        /// </summary>
        /// <param name="idString">SerialNumberSeedId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberSeed_Delete", parms);
        }

        /// <summary>
        /// 根据 SerialNumberSeedId 获取实体信息。
        /// </summary>
        /// <param name="serialNumberSeedId">SerialNumberSeedId。</param>
        /// <returns>SerialNumberSeed 实体对象。</returns>
        public SerialNumberSeedInfo GetInfo(Int32 serialNumberSeedId)
        {
            SerialNumberSeedInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = serialNumberSeedId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberSeed_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SerialNumberSeedInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetInt64(4), 
                        rdr.GetInt64(5), rdr.GetInt64(6), rdr.GetInt64(7), rdr.GetInt64(8), rdr.GetInt64(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetDateTime(12));
                    entity.ResetStr = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SerialNumberSeed 实体对象。</returns>
        public SerialNumberSeedInfo GetInfo(String fieldValue)
        {
            SerialNumberSeedInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SerialNumberSeed_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SerialNumberSeedInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetInt64(4), 
                        rdr.GetInt64(5), rdr.GetInt64(6), rdr.GetInt64(7), rdr.GetInt64(8), rdr.GetInt64(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetDateTime(12));
                    entity.ResetStr = rdr.GetString(13);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 SerialNumberSeed 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="serialNumberSeedCount">serialNumberSeed 总数。</param>
        /// <returns>SerialNumberSeed 列表。</returns>
        public List<SerialNumberSeedInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SerialNumberSeedInfo> list = new List<SerialNumberSeedInfo>();
            SerialNumberSeedInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_SerialNumberSeed", "SerialNumberSeedID",
                "[SerialNumberSeedId], [SerialNumberID], [Sequence_Base], [Number_Sequence], [Max_Seq], [Sequence_Length], [Current_Sequence], [Min_Sequence], [IncrementBy], [Warning], [Reset], [ResetDate], [LastUpdate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SerialNumberSeedInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetString(3), rdr.GetInt64(4), 
                        rdr.GetInt64(5), rdr.GetInt64(6), rdr.GetInt64(7), rdr.GetInt64(8), rdr.GetInt64(9),
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetDateTime(12));

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