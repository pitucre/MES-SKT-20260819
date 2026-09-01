using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Warehouse.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Warehouse.BLL
{
    /// <summary>
    /// 成品出入库配置功能
    /// </summary>
    public class WarehouseCpInConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） WarehouseCpInConfig 信息。
        /// </summary>
        /// <param name="entity">WarehouseCpInConfig 实体对象。</param>
        public Int32 Edit(WarehouseCpInConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Id", SqlDbType.Int),
                new SqlParameter("@ConfigId", SqlDbType.Int),
                new SqlParameter("@ConfigName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ConfigType", SqlDbType.Int),
                new SqlParameter("@ConfigDesc", SqlDbType.NVarChar, 50),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 200),
                new SqlParameter("@UserName", SqlDbType.NVarChar, 20),
            };

            parms[0].Value = entity.Id;
            parms[1].Value = entity.ConfigId;
            parms[2].Value = entity.ConfigName;
            parms[3].Value = entity.ConfigType;
            parms[4].Value = entity.ConfigDesc;
            parms[5].Value = entity.Remark;
            parms[6].Value = entity.UserName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCpInConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 WarehouseCpInConfigId 字符串删除 WarehouseCpInConfig 信息。
        /// </summary>
        /// <param name="idString">WarehouseCpInConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCpInConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 WarehouseCpInConfigId 获取实体信息。
        /// </summary>
        /// <param name="warehouseCpInConfigId">WarehouseCpInConfigId。</param>
        /// <returns>WarehouseCpInConfig 实体对象。</returns>
        public WarehouseCpInConfigInfo GetInfo(Int32 warehouseCpInConfigId)
        {
            WarehouseCpInConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = warehouseCpInConfigId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCpInConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCpInConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
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
        /// <returns>WarehouseCpInConfig 实体对象。</returns>
        public WarehouseCpInConfigInfo GetInfo(String fieldValue)
        {
            WarehouseCpInConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_WarehouseCpInConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new WarehouseCpInConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 WarehouseCpInConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="warehouseCpInConfigCount">warehouseCpInConfig 总数。</param>
        /// <returns>WarehouseCpInConfig 列表。</returns>
        public List<WarehouseCpInConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<WarehouseCpInConfigInfo> list = new List<WarehouseCpInConfigInfo>();
            WarehouseCpInConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_WarehouseCpInConfig", "Id",
                "[Id], [ConfigId], [ConfigName], [ConfigType], [ConfigDesc], [Remark],ISNULL(CreateBy,'') AS CreateBy,ISNULL(CreateDateTime,GETDATE()) AS CreateDateTime,ISNULL(ModifyBy,'') AS ModifyBy,ISNULL(ModifyDateTime,GETDATE()) AS ModifyDateTime", searchSettings, "ConfigId ASC");

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new WarehouseCpInConfigInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetString(2), rdr.GetInt32(3), rdr.GetString(4), 
                        rdr.GetString(5));
                    entity.CreateBy = rdr.GetString(6);
                    entity.CreateDateTime = rdr.GetDateTime(7);
                    entity.ModifyBy = rdr.GetString(8);
                    entity.ModifyDateTime = rdr.GetDateTime(9);
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