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
    /// 周转工具内装载成员的记录
    /// </summary>
    public class TurnoverMember
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TurnoverMember 信息。
        /// </summary>
        /// <param name="entity">TurnoverMember 实体对象。</param>
        public void Edit(TurnoverMemberInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverMember", SqlDbType.BigInt),
                new SqlParameter("@TurnoverDataId", SqlDbType.Int),
                new SqlParameter("@UID", SqlDbType.BigInt),
                new SqlParameter("@TurnoverStatusId", SqlDbType.Int),
                new SqlParameter("@OpeId", SqlDbType.Int),
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.TurnoverMemberId;
            parms[1].Value = entity.TurnoverDataId;
            parms[2].Value = entity.UID;
            parms[3].Value = entity.TurnoverStatusId;
            parms[4].Value = entity.OpeId;
            parms[5].Value = entity.ResId;
            parms[6].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverMember_Edit", parms);
        }

        /// <summary>
        /// 根据 TurnoverMemberId 字符串删除 TurnoverMember 信息。
        /// </summary>
        /// <param name="idString">TurnoverMemberId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverMember_Delete", parms);
        }

        /// <summary>
        /// 根据 TurnoverMemberId 获取实体TurnoverMember信息。
        /// </summary>
        /// <param name="TurnoverMemberId">TurnoverMemberId。</param>
        /// <returns>TurnoverMember 实体对象。</returns>
        public TurnoverMemberInfo GetInfo(Int32 turnoverMemberId)
        {
            TurnoverMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = turnoverMemberId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TurnoverMemberInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetString(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体TurnoverMember信息
        /// </summary>
        /// <param name="fieldValue">字段值</param>
        /// <returns>TurnoverMember 实体对象</returns>
        public TurnoverMemberInfo GetInfo(String fieldValue)
        {
            TurnoverMemberInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverMember_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 TurnoverMember 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="TurnoverMemberCount">TurnoverMember 总数。</param>
        /// <returns>TurnoverMember 列表。</returns>
        public List<TurnoverMemberInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TurnoverMemberInfo> list = new List<TurnoverMemberInfo>();
            TurnoverMemberInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_TurnoverMember", "TurnoverMemberId",
                "[TurnoverMemberId], [TurnoverDataId], [UID], [TurnoverStatusId], [OpeId], [ResId], [CreateDateTime], [CreateBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverMemberInfo(rdr.GetInt64(0), rdr.GetInt32(1), rdr.GetInt64(2), rdr.GetInt32(3), rdr.GetInt32(4), 
                        rdr.GetInt32(5), rdr.GetDateTime(6), rdr.GetString(7));

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