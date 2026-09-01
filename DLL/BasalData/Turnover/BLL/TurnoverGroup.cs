using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Turnover.Model;

namespace SKT.LeanMES.Turnover.BLL
{
    /// <summary>
    /// 周转工具分组
    /// </summary>
    public class TurnoverGroup
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） TurnoverGroup 信息。
        /// </summary>
        /// <param name="entity">TurnoverGroup 实体对象。</param>
        public void Edit(TurnoverGroupInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverGroupId", SqlDbType.Int),
                new SqlParameter("@TurnoverGroupName", SqlDbType.NVarChar, 50),
                new SqlParameter("@TurnoverTypeId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@MinQty", SqlDbType.Int),
                new SqlParameter("@MaxQty", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.TurnoverGroupId;
            parms[1].Value = entity.TurnoverGroupName;
            parms[2].Value = entity.TurnoverTypeId;
            parms[3].Value = entity.ItemId;
            parms[4].Value = entity.MinQty;
            parms[5].Value = entity.MaxQty;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverGroup_Edit", parms);
        }

        /// <summary>
        /// 根据 TurnoverGroupId 字符串删除 TurnoverGroup 信息。
        /// </summary>
        /// <param name="idString">TurnoverGroupId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverGroup_Delete", parms);
        }

        /// <summary>
        /// 根据 TurnoverGroupId 获取实体信息。
        /// </summary>
        /// <param name="TurnoverGroupId">TurnoverGroupId。</param>
        /// <returns>TurnoverGroup 实体对象。</returns>
        public TurnoverGroupInfo GetInfo(Int32 turnoverGroupId)
        {
            TurnoverGroupInfo entity = new TurnoverGroupInfo();

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = turnoverGroupId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TurnoverGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11), rdr.GetInt32(12));
                    entity.ItemCode = rdr["ItemCode"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取TurnoverGroup实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TurnoverGroup 实体对象。</returns>
        public TurnoverGroupInfo GetInfo(String fieldValue)
        {
            TurnoverGroupInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverGroup_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 TurnoverGroup 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="TurnoverGroupCount">TurnoverGroup 总数。</param>
        /// <returns>TurnoverGroup 列表。</returns>
        public List<TurnoverGroupInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TurnoverGroupInfo> list = new List<TurnoverGroupInfo>();
            TurnoverGroupInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwTurnoverGroupInfo", "TurnoverGroupId",
                "[TurnoverGroupId], [TurnoverGroupName], [TurnoverTypeId], [ItemId], [MinQty], [MaxQty], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy], [TurnoverTypeName], [ItemName],[ItemCode]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverGroupInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetInt32(2), rdr.GetInt32(3), rdr.GetInt32(4),
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetDateTime(8), rdr.GetString(9), rdr.GetString(10), rdr.GetString(11));
                    entity.ItemCode = rdr["ItemCode"].ToString();
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