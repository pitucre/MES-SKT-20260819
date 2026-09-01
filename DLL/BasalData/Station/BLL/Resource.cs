using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Station.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Station.BLL
{
    public class Resource
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Resource 信息。
        /// </summary>
        /// <param name="entity">Resource 实体对象。</param>
        public Int32 Edit(ResourceInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ResName", SqlDbType.NVarChar, 20),
                new SqlParameter("@ResDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@ResStatus", SqlDbType.Int),
                new SqlParameter("@DefaultOpt", SqlDbType.NVarChar, 20),
                new SqlParameter("@ValidStartTime", SqlDbType.DateTime),
                new SqlParameter("@ValidEndTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ResourceId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.ResName;
            parms[3].Value = entity.ResDescription;
            parms[4].Value = entity.ResStatus;
            parms[5].Value = entity.DefaultOpt;
            parms[6].Value = entity.ValidStartTime;
            parms[7].Value = entity.ValidEndTime;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Resource_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ResourceId 字符串删除 Resource 信息。
        /// </summary>
        /// <param name="idString">ResourceId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Resource_Delete", parms);
        }

        /// <summary>
        /// 根据 ResourceId 获取实体信息。
        /// </summary>
        /// <param name="resourceId">ResourceId。</param>
        /// <returns>Resource 实体对象。</returns>
        public ResourceInfo GetInfo(Int32 resourceId)
        {
            ResourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = resourceId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Resource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Resource 实体对象。</returns>
        public ResourceInfo GetInfo(String fieldValue)
        {
            ResourceInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_Resource_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 Resource 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="resourceCount">resource 总数。</param>
        /// <returns>Resource 列表。</returns>
        public List<ResourceInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ResourceInfo> list = new List<ResourceInfo>();
            ResourceInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_Resource", "ResourceId",
                "[ResourceId], [LineId], [ResName], [ResDescription], [ResStatus], [DefaultOpt], [ValidStartTime], [ValidEndTime], [CreateBy], [ModifyBy], [Remark]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10));

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