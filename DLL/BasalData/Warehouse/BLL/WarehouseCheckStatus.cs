using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warehouse.BLL
{
    public class WarehouseCheckStatus
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseCheckStatus 信息。
        /// </summary>
        /// <param name="entity">WarehouseCheckStatus 实体对象。</param>
        public Int32 Edit(WarehouseCheckStatusInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@ErpCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@WarehouseCheckStatusId", SqlDbType.NVarChar, 50),
                new SqlParameter("@WarehouseCheckStatusName", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.NVarChar, 50),
                new SqlParameter("@ModifyBy", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.ErpCode;
            parms[2].Value = entity.WarehouseCheckStatusId;
            parms[3].Value = entity.WarehouseCheckStatusName;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckStatus_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseCheckStatusId 字符串删除 WarehouseCheckStatus 信息。
        /// </summary>
        /// <param name="idString">WarehouseCheckStatusId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckStatus_Delete", parms);
        }

        /// <summary>
        /// 根据 WarehouseCheckStatusId 获取实体信息。
        /// </summary>
        /// <param name="warehouseCheckStatusId">WarehouseCheckStatusId。</param>
        /// <returns>WarehouseCheckStatus 实体对象。</returns>
        public WarehouseCheckStatusInfo GetInfo(Int32 warehouseCheckStatusId)
        {
            WarehouseCheckStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warehouseCheckStatusId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
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
        /// <returns>WarehouseCheckStatus 实体对象。</returns>
        public WarehouseCheckStatusInfo GetInfo(String fieldValue)
        {
            WarehouseCheckStatusInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCheckStatus_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCheckStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
                        rdr.GetDateTime(5), rdr.GetString(6), rdr.GetDateTime(7));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseCheckStatus 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCheckStatusCount">warehouseCheckStatus 总数。</param>
        /// <returns>WarehouseCheckStatus 列表。</returns>
        public List<WarehouseCheckStatusInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCheckStatusInfo> list = new List<WarehouseCheckStatusInfo>();
            WarehouseCheckStatusInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Basal_WarehouseCheckStatus", "WarehouseCheckStatusId",
                "[Id], [ErpCode], [WarehouseCheckStatusId], [WarehouseCheckStatusName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCheckStatusInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4),
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