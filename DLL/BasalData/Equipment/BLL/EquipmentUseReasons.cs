using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentUseReasons
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentUseReasons 信息。
        /// </summary>
        /// <param name="entity">EquipmentUseReasons 实体对象。</param>
        public Int32 Edit(EquipmentUseReasonsInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentUseReasonsId", SqlDbType.Int),
                new SqlParameter("@Content", SqlDbType.VarChar, 100),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Type", SqlDbType.VarChar, 50),
            };

            parms[0].Value = entity.EquipmentUseReasonsId;
            parms[1].Value = entity.Content;
            parms[2].Value = entity.Remark;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.Type;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentUseReasons_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 EquipmentUseReasonsId 字符串删除 EquipmentUseReasons 信息。
        /// </summary>
        /// <param name="idString">EquipmentUseReasonsId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentUseReasons_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentUseReasonsId 获取实体信息。
        /// </summary>
        /// <param name="equipmentUseReasonsId">EquipmentUseReasonsId。</param>
        /// <returns>EquipmentUseReasons 实体对象。</returns>
        public EquipmentUseReasonsInfo GetInfo(Int32 equipmentUseReasonsId)
        {
            EquipmentUseReasonsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentUseReasonsId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentUseReasons_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentUseReasonsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentUseReasons 实体对象。</returns>
        public EquipmentUseReasonsInfo GetInfo(String fieldValue)
        {
            EquipmentUseReasonsInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentUseReasons_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentUseReasonsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetInt32(5));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentUseReasons 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentUseReasonsCount">equipmentUseReasons 总数。</param>
        /// <returns>EquipmentUseReasons 列表。</returns>
        public List<EquipmentUseReasonsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentUseReasonsInfo> list = new List<EquipmentUseReasonsInfo>();
            EquipmentUseReasonsInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwBasal_EquipmentUseReasons", "EquipmentUseReasonsId",
                "[EquipmentUseReasonsId], [Content], [Remark], [CreateBy], [CreateDateTime],Type,ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentUseReasonsInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4), rdr.GetInt32(5));
                    entity.TypeName = rdr.GetInt32(5) == 1 ? "领用" : "归还";
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {

                        entity.ModifyBy = rdr["ModifyBy"].ToString();
                        entity.ModifyTime =Convert.ToDateTime( rdr["ModifyTime"]);
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