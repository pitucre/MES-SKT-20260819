using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
//using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Quality.Model;

namespace SKT.LeanMES.Quality.BLL
{
    public class AQLRuleType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） AQLRuleType 信息。
        /// </summary>
        /// <param name="entity">AQLRuleType 实体对象。</param>
        public Int32 Edit(AQLRuleTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@AqlRuleTypeId", SqlDbType.Int),
                new SqlParameter("@AqlRuleTypeName", SqlDbType.NVarChar, 20),
                new SqlParameter("@AqlRuleTypeList", SqlDbType.NVarChar, 100),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreaterBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.AqlRuleTypeId;
            parms[1].Value = entity.AqlRuleTypeName;
            parms[2].Value = entity.AqlRuleTypeList;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.CreaterBy;
            parms[5].Value = entity.CreateDate;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.ModifyDate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRuleTypeEdit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 AQLRuleTypeId 字符串删除 AQLRuleType 信息。
        /// </summary>
        /// <param name="idString">AQLRuleTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRuleTypeDelete", parms);
        }

        /// <summary>
        /// 根据 AQLRuleTypeId 获取实体信息。
        /// </summary>
        /// <param name="aQLRuleTypeId">AQLRuleTypeId。</param>
        /// <returns>AQLRuleType 实体对象。</returns>
        public AQLRuleTypeInfo GetInfo(Int32 aQLRuleTypeId)
        {
            AQLRuleTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = aQLRuleTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRuleTypeGetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new AQLRuleTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>AQLRuleType 实体对象。</returns>
        public AQLRuleTypeInfo GetInfo(String fieldValue)
        {
            AQLRuleTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Quality_AQLRuleTypeGetInfo", parms))
            {
                if (rdr.Read())
                {
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 AQLRuleType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="aQLRuleTypeCount">aQLRuleType 总数。</param>
        /// <returns>AQLRuleType 列表。</returns>
        public List<AQLRuleTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<AQLRuleTypeInfo> list = new List<AQLRuleTypeInfo>();
            AQLRuleTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Quality_AQLRuleType", "AQLRuleTypeID",
                "[AqlRuleTypeId], [AqlRuleTypeName], '', [Remark], [CreaterBy], [CreateDate], [ModifyBy], [ModifyDate]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new AQLRuleTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));

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