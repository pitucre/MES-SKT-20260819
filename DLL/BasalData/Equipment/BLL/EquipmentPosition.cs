using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentPosition
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentPosition 信息。
        /// </summary>
        /// <param name="entity">EquipmentPosition 实体对象。</param>
        public Int32 Edit(EquipmentPositionInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentPositionId", SqlDbType.Int),
                new SqlParameter("@PositionName", SqlDbType.NVarChar, 100),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.EquipmentPositionId;
            parms[1].Value = entity.PositionName;
            parms[2].Value = entity.Remark;
            parms[3].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentPosition_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentPositionId 字符串删除 EquipmentPosition 信息。
        /// </summary>
        /// <param name="idString">EquipmentPositionId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentPosition_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentPositionId 获取实体信息。
        /// </summary>
        /// <param name="equipmentPositionId">EquipmentPositionId。</param>
        /// <returns>EquipmentPosition 实体对象。</returns>
        public EquipmentPositionInfo GetInfo(Int32 equipmentPositionId)
        {
            EquipmentPositionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentPositionId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentPosition_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentPositionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentPosition 实体对象。</returns>
        public EquipmentPositionInfo GetInfo(String fieldValue)
        {
            EquipmentPositionInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentPosition_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentPositionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentPosition 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentPositionCount">equipmentPosition 总数。</param>
        /// <returns>EquipmentPosition 列表。</returns>
        public List<EquipmentPositionInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentPositionInfo> list = new List<EquipmentPositionInfo>();
            EquipmentPositionInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EquipmentPosition", "EquipmentPositionId",
                "[EquipmentPositionId], [PositionName], [Remark], [CreateBy], [CreateDateTime],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentPositionInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime =Convert.ToDateTime(rdr["ModifyTime"]);
                    }
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