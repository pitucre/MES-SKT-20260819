using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentType 信息。
        /// </summary>
        /// <param name="entity">EquipmentType 实体对象。</param>GetAllTree
        public void Edit(EquipmentTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentTypeId", SqlDbType.Int),
                new SqlParameter("@EquipmentTypeCode", SqlDbType.VarChar, 20),
                new SqlParameter("@EquipmentTypeName", SqlDbType.NVarChar, 20),
                new SqlParameter("@PID", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@IsLoading", SqlDbType.Int),
                new SqlParameter("@IsOffLine", SqlDbType.Int),
                new SqlParameter("@IsScanPos", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.EquipmentTypeId;
            parms[1].Value = entity.EquipmentTypeCode;
            parms[2].Value = entity.EquipmentTypeName;
            parms[3].Value = entity.PID;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.IsLoading;
            parms[7].Value = entity.IsOffLine;
            parms[8].Value = entity.IsScanPos;
            parms[9].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentType_Edit", parms);

        }

        /// <summary>
        /// 根据 EquipmentTypeId 字符串删除 EquipmentType 信息。
        /// </summary>
        /// <param name="idString">EquipmentTypeId 字符串。</param>
        /// <returns></returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentType_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentTypeId 获取实体信息。
        /// </summary>
        /// <param name="EquipmentTypeId">EquipmentType。</param>
        /// <returns>EquipmentType 实体对象。</returns>
        public EquipmentTypeInfo GetInfo(Int32 equipmentTypeId)
        {
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetBoolean(12), rdr.GetBoolean(13), rdr.GetBoolean(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取EquipmentType实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentType 实体对象。</returns>
        public EquipmentTypeInfo GetInfo(String fieldValue)
        {
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetBoolean(12), rdr.GetBoolean(13), rdr.GetBoolean(14));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tYPECount">EquipmentType 总数。</param>
        /// <returns>EquipmentType 列表。</returns>
        public List<EquipmentTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentTypeInfo> list = new List<EquipmentTypeInfo>();
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_EquipmentType", "EquipmentTypeId",
                @"[EquipmentTypeId], [EquipmentTypeCode], [EquipmentTypeName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],
                [PID],[Level],[IsSystem],[ParentTypeName],[IsLoading] ,[IsOffLine], [IsScanPos]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetBoolean(12), rdr.GetBoolean(13), rdr.GetBoolean(14));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        /// 分页获取 EquipmentType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="tYPECount">EquipmentType 总数。</param>
        /// <returns>EquipmentType 列表。</returns>
        public List<EquipmentTypeInfo> GetTypeAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentTypeInfo> list = new List<EquipmentTypeInfo>();
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_EquipmentTypeAll", "EquipmentTypeId",
                @"[EquipmentTypeId], [EquipmentTypeCode], [EquipmentTypeName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],
                [PID],[Level],[IsSystem],[ParentTypeName],[IsLoading] ,[IsOffLine], [IsScanPos]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetBoolean(12), rdr.GetBoolean(13), rdr.GetBoolean(14));
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        public List<EquipmentTypeInfo> GetAllTree(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentTypeInfo> list = new List<EquipmentTypeInfo>();
            EquipmentTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vw_EquipmentTypeTree", "EquipmentTypeId",
                @"[EquipmentTypeId], [EquipmentTypeCode], [EquipmentTypeName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Remark],
                [PID],[Level],[IsSystem],[ParentTypeName],[IsLoading] ,[IsOffLine], [IsScanPos],[isParent]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentTypeInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4),
                        rdr.GetString(5), rdr.GetDateTime(6), rdr.GetString(7), rdr.GetInt32(8), rdr.GetInt32(9), rdr.GetInt32(10), rdr.GetString(11), rdr.GetBoolean(12), rdr.GetBoolean(13), rdr.GetBoolean(14));
                    entity.isParent = rdr.GetBoolean(15);

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