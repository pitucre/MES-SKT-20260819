using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Resource.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Resource.BLL
{
    public class Resource
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Resource 信息。
        /// </summary>
        /// <param name="entity">Resource 实体对象。</param>
        public void Edit(ResourceInfo entity, string resCertIDString, string resResTypeString, string itemIdString, string verString, string startTime, string endTime,string Face)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ResId", SqlDbType.Int),
                new SqlParameter("@ResName", SqlDbType.NVarChar, 20),
                new SqlParameter("@ResDescription", SqlDbType.NVarChar, 50),
                new SqlParameter("@ResStatus", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ValidStartTime", SqlDbType.DateTime),
                new SqlParameter("@ValidEndTime", SqlDbType.DateTime),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@ResCertIDString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@ResTypeString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@ItemIdString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@VerString", SqlDbType.NVarChar, 1000),
                new SqlParameter("@Face", SqlDbType.VarChar),
                new SqlParameter("@EquipmentCode", SqlDbType.VarChar)
            };

            parms[0].Value = entity.ResourceId;
            parms[1].Value = entity.ResName;
            parms[2].Value = entity.ResDescription;
            parms[3].Value = entity.ResStatus;
            parms[4].Value = entity.LineId;
            parms[5].Value = (startTime == "") ? DateTime.Now : Convert.ToDateTime(startTime);
            parms[6].Value = (endTime == "") ? Convert.ToDateTime("9999-12-31") : Convert.ToDateTime(endTime);
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Remark;
            parms[10].Value = resCertIDString;
            parms[11].Value = resResTypeString;
            parms[12].Value = itemIdString;
            parms[13].Value = verString;
            parms[14].Value = Face;//面别
            parms[15].Value = entity.EquipmentCode;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_Resource_Edit", parms);

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
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ResTypeName = rdr.GetString(14);
                    entity.ResTypeId = rdr.GetInt32(15);
                    entity.Face = rdr.GetString(16);
                    entity.EquipmentCode = rdr.GetString(17);
                    entity.EquipmentName = rdr.GetString(18);
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
                         rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9),
                         rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ResTypeName = rdr.GetString(14);
                    entity.ResTypeId = rdr.GetInt32(15);
                    entity.Face = rdr.GetString(16);
                    entity.EquipmentCode = rdr.GetString(17);
                    entity.EquipmentName = rdr.GetString(18);
                }
                rdr.Close();
            }

            return entity;
        }

        public List<ResourceInfo> GetItemOnHoldByResId(int resId)
        {
            List<ResourceInfo> list = new List<ResourceInfo>();
            ResourceInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " ResId =" + resId.ToString();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "vwResItemMember", 
                "RIOId", "ItemId,Modify_Ver,ItemName", searchSettings, "RIOId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceInfo();
                    entity.ItemId = rdr.GetInt32(0);
                    entity.Modify_Ver = rdr.GetString(1);
                    entity.ItemName = rdr.GetString(2);

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }
        /// <summary>
        /// 根据线别id获取资源信息
        /// </summary>
        /// <param name="flage"></param>
        /// <param name="lineId"></param>
        /// <returns></returns>
        public   List<ResourceInfo> GetResourceByLineId(Int32  flage ,Int32  lineId)
        {
             List<ResourceInfo> list = new List<ResourceInfo>();
             ResourceInfo entity = null;
            SqlParameter[]  parms = new SqlParameter[]{
                 new SqlParameter("@Flage",SqlDbType.Int),
                 new SqlParameter("@LineId",SqlDbType.Int)
            };
            parms[0].Value = flage;
            parms[1].Value = lineId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetResourceByLineId", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceInfo();
                    entity.ResourceId = rdr.GetInt32(0);
                    entity.ResName = rdr.GetString(1);
                    entity.ResTypeName = rdr.GetString(2);
                    entity.ResTypeId = rdr.GetInt32(3);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
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

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwResourceMember", "ResourceId",
                "[ResourceId], [LineId], [ResName], [ResDescription], [ResStatus], [DefaultOpt], [ValidStartTime], [ValidEndTime], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],[LineName],[ResTypeName],[ResourceTypeId],Face,EquipmentCode,EquipmentName", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetInt32(4), 
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetDateTime(9), 
                        rdr.GetString(10), rdr.GetDateTime(11), rdr.GetString(12));
                    entity.LineName = rdr.GetString(13);
                    entity.ResTypeName = rdr.GetString(14);
                    entity.ResTypeId = rdr.GetInt32(15);
                    entity.Face = rdr.GetString(16);
                    entity.EquipmentCode = rdr.GetString(17);
                    entity.EquipmentName = rdr.GetString(18);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 根据工位id获取资源信息
        /// </summary>
        /// <param name="oprId"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public List<ResourceInfo> GetResourcesByOprId(int oprId, string username)
        {
            List<ResourceInfo> list = new List<ResourceInfo>();
            ResourceInfo model = null;

            SqlParameter[] parms = new SqlParameter[] { 
                new SqlParameter("@OpeId",SqlDbType.Int),
                new SqlParameter("@UserName",SqlDbType.VarChar,20)
            };

            parms[0].Value = oprId;
            parms[1].Value = username;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetResourcesByOprId", parms))
            {
                while (rdr.Read())
                {
                    model = new ResourceInfo();
                    model.ResourceId = rdr.GetInt32(0);
                    model.ResName = rdr.GetString(1);

                    list.Add(model);
                }
                rdr.Close();
            }
            return list;
        }

        /// <summary>
        /// 根据工位id获取默认资源
        /// </summary>
        /// <param name="oprId"></param>
        /// <returns></returns>
        public int GetDefResourcesByOprId(int opeId)
        {
            var strSql = " SELECT TOP 1 ISNULL(StationDefaultResId,-1) AS StationDefaultResId " +
                         "FROM BASAL_STATION WHERE StationId = " + opeId;
            var defResId = -1 ;
            using (SqlDataReader dr =SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString,strSql,null)) 
            {
                if (dr.Read())
                {
                    defResId= Convert.ToInt32(dr["StationDefaultResId"]);
                }
                dr.Close();
            }
            return defResId;
        }

        /// <summary>
        /// 返回ESOP资源信息
        /// </summary>
        /// <param name="opeId"></param>
        /// <returns></returns>
        public List<ResourceInfo> GetEsopResourceByOpeId(int opeId)
        {
            List<ResourceInfo> list = new List<ResourceInfo>();
            ResourceInfo entity = null;

            SearchSettings searchSettings = new SearchSettings();
            searchSettings.ExtensionCondition = " StationId =" + opeId.ToString();

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(0, -1, "vwGetEsopResource",
                "ResourceId", "ResourceId,ResName", searchSettings, "ResourceId");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceInfo();
                    entity.ResourceId = rdr.GetInt32(0);
                    entity.ResName = rdr.GetString(1);                  

                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}