using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.SerialNumber.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class ResetWay
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ResetWay 信息。
        /// </summary>
        /// <param name="entity">ResetWay 实体对象。</param>
        public Int32 Edit(ResetWayInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResetWayId", SqlDbType.Int),
                new SqlParameter("@ResetWay", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsSystemResetWay", SqlDbType.Bit),
                new SqlParameter("@ResetWayDesc", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),        
                new SqlParameter("@RelationFunc", SqlDbType.VarChar, 50),
            };

            parms[0].Value = entity.ResetWayId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ResetWay;
            parms[2].Value = entity.IsSystemResetWay;
            parms[3].Value = entity.ResetWayDesc;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.RelationFunc;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResetWay_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ResetWayId 字符串删除 ResetWay 信息。
        /// </summary>
        /// <param name="idString">ResetWayId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResetWay_Delete", parms);
        }

        /// <summary>
        /// 根据 ResetWayId 获取实体信息。
        /// </summary>
        /// <param name="resetWayId">ResetWayId。</param>
        /// <returns>ResetWay 实体对象。</returns>
        public ResetWayInfo GetInfo(Int32 resetWayId)
        {
            ResetWayInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = resetWayId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ResetWay_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResetWayInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                    entity.RelationFunc = rdr.GetString(8);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ResetWay 实体对象。</returns>
        public ResetWayInfo GetInfo(String fieldValue)
        {
            ResetWayInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ResetWay_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResetWayInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                    entity.RelationFunc = rdr.GetString(8);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ResetWay 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="resetWayCount">resetWay 总数。</param>
        /// <returns>ResetWay 列表。</returns>
        public List<ResetWayInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ResetWayInfo> list = new List<ResetWayInfo>();
            ResetWayInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_ResetWay", "ResetWayId",////Basal_ResetWay
                "[ResetWayId], [ResetWay], [IsSystemResetWay], [ResetWayDesc], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResetWayInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetBoolean(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));

                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 获取复位相关存储过程/函数信息
        /// </summary>
        /// <returns></returns>
        public List<string> GetResetWayFunc()
        {
            List<string> list = new List<string>();

            string sql = "select * from [vwGetResetWayFunc]";
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString, sql, null))
            {
                while (rdr.Read())
                {
                    list.Add(rdr[0].ToString());
                }
            }

            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
