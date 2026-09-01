using System;
using System.Collections.Generic;
using System.Text;
using SKT.LeanMES.Quality.Model;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class OBAAudit
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AUDIT 信息。
        /// </summary>
        /// <param name="entity">AUDIT 实体对象。</param>
        public void Edit(OBAAuditInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AuditRuleId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LotSize", SqlDbType.Int),
                new SqlParameter("@SamplePercent", SqlDbType.Float),
                new SqlParameter("@SampleSize", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar,20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar,20)
            };

            parms[0].Value = entity.AuditRuleId;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.LotSize;
            parms[3].Value = entity.SamplePercent;
            parms[4].Value = entity.SampleSize;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AuditRuleEdit", parms);
        }

        /// <summary>
        /// 根据 AUDITId 字符串删除 AUDIT 信息。
        /// </summary>
        /// <param name="idString">AUDITId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AuditRuleDelete", parms);
        }

        /// <summary>
        /// 根据 AUDITId 获取实体信息。
        /// </summary>
        /// <param name="aUDITId">AUDITId。</param>
        /// <returns>AUDIT 实体对象。</returns>
        public OBAAuditInfo GetInfo(Int32 aUDITId)
        {
            OBAAuditInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = aUDITId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AuditRuleGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new OBAAuditInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDouble(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                    entity.ItemName = rdr.GetString(9);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AUDIT 实体对象。</returns>
        public OBAAuditInfo GetInfo(String fieldValue)
        {
            OBAAuditInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "ITEM_AUDITGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AUDIT 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aUDITCount">aUDIT 总数。</param>
        /// <returns>AUDIT 列表。</returns>
        public List<OBAAuditInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<OBAAuditInfo> list = new List<OBAAuditInfo>();
            OBAAuditInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwAuditRule", "AuditRuleId",
                "[AuditRuleId], [ItemId], [LotSize], [SamplePercent], [SampleSize], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [ItemName],[ItemCode]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new OBAAuditInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetDouble(3), rdr.GetInt32(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8));
                    entity.ItemName = rdr.GetString(9);
                    entity.ItemCode = rdr.GetString(10);
                    entity.SamplePercentStr = (rdr.GetDouble(3) * 100).ToString() + "%";
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