using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class WarehouseCheckType
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseCheckType 信息。
        /// </summary>
        /// <param name="entity">WarehouseCheckType 实体对象。</param>
        public Int32 Edit(WarehouseCheckTypeInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ErpCode", SqlDbType.Int),
                new SqlParameter("@WarehouseCheckTypeId", SqlDbType.Int),
                new SqlParameter("@WarehouseCheckTypeName", SqlDbType.NVarChar, 50),
                new SqlParameter("@Describe", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@Reserved1", SqlDbType.NVarChar, 50),
                new SqlParameter("@Reserved2", SqlDbType.NVarChar, 50),
                new SqlParameter("@Reserved3", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ErpCode;
           // parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.WarehouseCheckTypeId;
            parms[2].Value = entity.WarehouseCheckTypeName;
            parms[3].Value = entity.Describe;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;
            parms[6].Value = entity.Reserved1;
            parms[7].Value = entity.Reserved2;
            parms[8].Value = entity.Reserved3;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckType_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseCheckTypeId 字符串删除 WarehouseCheckType 信息。
        /// </summary>
        /// <param name="idString">WarehouseCheckTypeId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckType_Delete", parms);
        }

        /// <summary>
        /// 根据 WarehouseCheckTypeId 获取实体信息。
        /// </summary>
        /// <param name="warehouseCheckTypeId">WarehouseCheckTypeId。</param>
        /// <returns>WarehouseCheckType 实体对象。</returns>
        public WarehouseCheckTypeInfo GetInfo(Int32 warehouseCheckTypeId)
        {
            WarehouseCheckTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warehouseCheckTypeId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckTypeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
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
        /// <returns>WarehouseCheckType 实体对象。</returns>
        public WarehouseCheckTypeInfo GetInfo(String fieldValue)
        {
            WarehouseCheckTypeInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckType_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckTypeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
                        rdr.GetString(10));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseCheckType 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCheckTypeCount">warehouseCheckType 总数。</param>
        /// <returns>WarehouseCheckType 列表。</returns>
        public List<WarehouseCheckTypeInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckTypeInfo> list = new List<WarehouseCheckTypeInfo>();
            WarehouseCheckTypeInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_WarehouseCheckType", "WarehouseCheckTypeId",////Basal_WarehouseCheckType
                "[ErpCode], [WarehouseCheckTypeId], [WarehouseCheckTypeName], [Describe], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime], [Reserved1], [Reserved2], [Reserved3]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCheckTypeInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), 
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetString(9), 
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