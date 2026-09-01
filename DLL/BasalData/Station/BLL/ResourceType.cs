using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class ResourceType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ResourceType 信息。
        /// </summary>
        /// <param name="entity">ResourceType 实体对象。</param>
        public Int32 Edit(ResourceTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResourceTypeId", SqlDbType.Int),
                new SqlParameter("@ResTypeName", SqlDbType.NVarChar, 20),
                new SqlParameter("@ResTypeDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ResourceTypeId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ResTypeName;
            parms[2].Value = entity.ResTypeDesc;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ResourceTypeId 字符串删除 ResourceType 信息。
        /// </summary>
        /// <param name="idString">ResourceTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceType_Delete", parms);
        }

        /// <summary>
        /// 根据 ResourceTypeId 获取实体信息。
        /// </summary>
        /// <param name="resourceTypeId">ResourceTypeId。</param>
        /// <returns>ResourceType 实体对象。</returns>
        public ResourceTypeInfo GetInfo(Int32 resourceTypeId)
        {
            ResourceTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = resourceTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ResourceType 实体对象。</returns>
        public ResourceTypeInfo GetInfo(String fieldValue)
        {
            ResourceTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 ResourceType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="resourceTypeCount">resourceType 总数。</param>
        /// <returns>ResourceType 列表。</returns>
        public List<ResourceTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ResourceTypeInfo> list = new List<ResourceTypeInfo>();
            ResourceTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_ResourceType", "ResourceTypeId",
                "[ResourceTypeId], [ResTypeName], [ResTypeDesc], [CreateBy], [ModifyBy], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetString(5));

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