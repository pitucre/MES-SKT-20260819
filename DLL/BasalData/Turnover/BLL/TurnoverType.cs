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
    /// 周转工具类型
    /// </summary>
    public class TurnoverType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） TurnoverType 信息。
        /// </summary>
        /// <param name="entity">TurnoverType 实体对象。</param>
        public void Edit(TurnoverTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@TurnoverTypeId", SqlDbType.Int),
                new SqlParameter("@TurnoverTypeCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@TurnoverTypeName", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.TurnoverTypeId;
            parms[1].Value = entity.TurnoverTypeCode;
            parms[2].Value = entity.TurnoverTypeName;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverType_Edit", parms);
        }

        /// <summary>
        /// 根据 TurnoverTypeId 字符串删除 TurnoverType 信息。
        /// </summary>
        /// <param name="idString">TurnoverTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverType_Delete", parms);
        }

        /// <summary>
        /// 根据 TurnoverTypeId 获取实体信息。
        /// </summary>
        /// <param name="TurnoverTypeId">TurnoverTypeId。</param>
        /// <returns>TurnoverType 实体对象。</returns>
        public TurnoverTypeInfo GetInfo(Int32 cONTAINER_TYPEId)
        {
            TurnoverTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = cONTAINER_TYPEId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new TurnoverTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体TurnoverType信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>TurnoverType 实体对象。</returns>
        public TurnoverTypeInfo GetInfo(String fieldValue)
        {
            TurnoverTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_TurnoverType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 TurnoverType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="TurnoverTypeCount">TurnoverType 总数。</param>
        /// <returns>TurnoverType 列表。</returns>
        public List<TurnoverTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<TurnoverTypeInfo> list = new List<TurnoverTypeInfo>();
            TurnoverTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_TurnoverType", "TurnoverTypeId",////Basal_TurnoverType
                "[TurnoverTypeId], [TurnoverTypeCode], [TurnoverTypeName], [CreateDateTime], [CreateBy], [ModifyDateTime], [ModifyBy]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new TurnoverTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetDateTime(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6));

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