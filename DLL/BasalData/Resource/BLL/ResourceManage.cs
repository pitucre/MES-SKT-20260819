using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Resource.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Resource.BLL
{
    public class ResourceManage
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Resource 信息。
        /// </summary>
        /// <param name="entity">Resource 实体对象。</param>
        public void Edit(ResourceManageInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ResourceIdArr", SqlDbType.VarChar),               
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@EfficiencyFactor", SqlDbType.Int),
                new SqlParameter("@FrontTime", SqlDbType.Int),
                new SqlParameter("@PostTime", SqlDbType.Int),
                new SqlParameter("@Capacity", SqlDbType.Int),
                new SqlParameter("@Priority", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@FrontUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@PostUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@CapacityUnit", SqlDbType.NVarChar, 20),
                new SqlParameter("@Face", SqlDbType.NVarChar, 30),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ActiveState", SqlDbType.Bit),
                new SqlParameter("@ResourceId", SqlDbType.Int),
                new SqlParameter("@IsSmt", SqlDbType.Bit),

            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.ResourceIdArr;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.EfficiencyFactor;
            parms[5].Value = entity.FrontTime;
            parms[6].Value = entity.PostTime;
            parms[7].Value = entity.Capacity;
            parms[8].Value = entity.Priority;
            parms[9].Value = entity.CreateBy;
            parms[10].Value = entity.Remark;
            parms[11].Value = entity.FrontUnit;
            parms[12].Value = entity.PostUnit;
            parms[13].Value = entity.CapacityUnit;
            parms[14].Value = entity.Face;
            parms[15].Value = entity.LineId;
            parms[16].Value = entity.ActiveState;
            parms[17].Value = entity.ResourceId;
            parms[18].Value = entity.IsSmt;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceManage_Edit", parms);

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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceManage_Delete", parms);
        }

        /// <summary>
        /// 根据 ResourceId 获取实体信息。
        /// </summary>
        /// <param name="Id">Id。</param>
        /// <returns>Resource 实体对象。</returns>
        public ResourceManageInfo GetInfo(Int32 Id)
        {
            ResourceManageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = Id;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ResourceManage_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceManageInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.EfficiencyFactor = Convert.ToInt32(rdr["EfficiencyFactor"]);
                    entity.Priority = Convert.ToInt32(rdr["Priority"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    entity.FrontTime = Convert.ToInt32(rdr["FrontTime"]);
                    entity.PostTime = Convert.ToInt32(rdr["PostTime"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);

                    //entity.StationId = Convert.ToInt32(rdr["StationId"]);

                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec= Convert.ToString(rdr["ItemSpec"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.Capacity = Convert.ToInt32(rdr["Capacity"]);

                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.Face = Convert.ToString(rdr["Face"]);

                    entity.FrontUnit= Convert.ToString(rdr["FrontUnit"]);
                    entity.PostUnit = Convert.ToString(rdr["PostUnit"]);
                    entity.CapacityUnit = Convert.ToString(rdr["CapacityUnit"]);

                    entity.FrontActual = Convert.ToInt32(rdr["FrontActual"]);
                    entity.PostActual = Convert.ToInt32(rdr["PostActual"]);
                    entity.ActiveState = Convert.ToInt32(rdr["ActiveState"]);
                    entity.IsSmt = Convert.ToInt32(rdr["IsSmt"]);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据产品ID与线别ID获取产能信息
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="lineId"></param>
        /// <param name="tableName"></param>
        /// <returns></returns>
        public ResourceManageInfo GetInfoByItemOrLineId(int itemId,int lineId,string tableName)
        {
            ResourceManageInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@TableName", SqlDbType.VarChar)
            };

            parms[0].Value = itemId;
            parms[1].Value = lineId;
            parms[2].Value = tableName;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetResourceManageInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ResourceManageInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.EfficiencyFactor = Convert.ToInt32(rdr["EfficiencyFactor"]);
                    entity.Priority = Convert.ToInt32(rdr["Priority"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    entity.FrontTime = Convert.ToInt32(rdr["FrontTime"]);
                    entity.PostTime = Convert.ToInt32(rdr["PostTime"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);

                    //entity.StationId = Convert.ToInt32(rdr["StationId"]);

                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.Capacity = Convert.ToInt32(rdr["Capacity"]);

                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.Face = Convert.ToString(rdr["Face"]);

                    entity.FrontUnit = Convert.ToString(rdr["FrontUnit"]);
                    entity.PostUnit = Convert.ToString(rdr["PostUnit"]);
                    entity.CapacityUnit = Convert.ToString(rdr["CapacityUnit"]);

                    entity.FrontActual = Convert.ToInt32(rdr["FrontActual"]);
                    entity.PostActual = Convert.ToInt32(rdr["PostActual"]);

                    entity.ActiveState = Convert.ToInt32(rdr["ActiveState"]);
                    entity.IsSmt = Convert.ToInt32(rdr["IsSmt"]);
                }
                rdr.Close();
            }

            return entity;
        }


        /// <summary>
        /// 分页获取 ResourceManage 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="resourceCount">resource 总数。</param>
        /// <returns>Resource 列表。</returns>
        public List<ResourceManageInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ResourceManageInfo> list = new List<ResourceManageInfo>();
            ResourceManageInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetResourceManageList a", "Id",
                @"Id ,
            a.EfficiencyFactor ,
            a.Priority ,
			a.Capacity,
			a.FrontTime,
			a.PostTime,
            a.Face,
			a.LineId,
			a.LineName,
			a.ResourceId,
			a.ResName,
			a.ItemId,
            a.ItemCode,
			a.ItemName,
            a.ItemSpec,
			a.CreateBy ,
            a.CreateBy2 ,
            a.CreateTime ,
			a.ModifyBy,
			a.ModifyTime,
		    a.Remark,a.FrontUnit,a.PostUnit,a.CapacityUnit,a.FrontActual,
			PostActual ", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ResourceManageInfo();
                    entity.Id = Convert.ToInt32(rdr["Id"]);
                    entity.EfficiencyFactor = Convert.ToInt32(rdr["EfficiencyFactor"]);
                    entity.Priority = Convert.ToInt32(rdr["Priority"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy2"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
                    entity.FrontTime = Convert.ToInt32(rdr["FrontTime"]);
                    entity.PostTime = Convert.ToInt32(rdr["PostTime"]);
                    entity.LineId = Convert.ToInt32(rdr["LineId"]);
                    entity.LineName = Convert.ToString(rdr["LineName"]);

                   //entity.StationId = Convert.ToInt32(rdr["StationId"]);

                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemSpec = Convert.ToString(rdr["ItemSpec"]);
                    entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                    entity.Capacity = Convert.ToInt32(rdr["Capacity"]);

                    entity.ResourceId = Convert.ToInt32(rdr["ResourceId"]);
                    entity.ResName = Convert.ToString(rdr["ResName"]);
                    entity.Face = Convert.ToString(rdr["Face"]);

                    entity.FrontUnit = Convert.ToString(rdr["FrontUnit"]);
                    entity.PostUnit = Convert.ToString(rdr["PostUnit"]);
                    entity.CapacityUnit = Convert.ToString(rdr["CapacityUnit"]);

                    entity.FrontActual = Convert.ToInt32(rdr["FrontActual"]);
                    entity.PostActual = Convert.ToInt32(rdr["PostActual"]);
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