using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class EquipmentItemRelation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentItemRelation 信息。
        /// </summary>
        /// <param name="entity">EquipmentItemRelation 实体对象。</param>
        public Int32 Edit(EquipmentItemRelationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EquipmentItemRelationId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 50),
                new SqlParameter("@EqCode", SqlDbType.VarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = entity.EquipmentItemRelationId;
            parms[1].Value = entity.ItemCode;
            parms[2].Value = entity.EqCode;
            parms[3].Value = entity.CreateBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentItemRelation_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 新增机种与设备关系
        /// </summary>
        /// <param name="eqCode">备件ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="itemString">设备ID</param>
        /// <returns></returns>
        public string SaveItemInEquiment(string  eqCode, string itemString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EqCode", SqlDbType.VarChar,50),
                new SqlParameter("@ItemString", SqlDbType.VarChar, 4000),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = eqCode;
            parms[1].Value = itemString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Item_EditInEquipment", parms);

            return parms[0].Value.ToString();
        }

        /// <summary>
        /// 删除备件设备关系
        /// </summary>
        /// <param name="eqCode">设备</param>
        /// <param name="createBy">用户名</param>
        /// <param name="itemString">机种</param>
        public void RemoveItemOutEquiment(string eqCode, string itemString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@EqCode", SqlDbType.VarChar,50),
                new SqlParameter("@ItemString", SqlDbType.VarChar, 4000),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = eqCode;
            parms[1].Value = itemString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Item_EquipmentDelete", parms);
        }


        /// <summary>
        /// 根据 EquipmentItemRelationId 字符串删除 EquipmentItemRelation 信息。
        /// </summary>
        /// <param name="idString">EquipmentItemRelationId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentItemRelation_Delete", parms);
        }

        /// <summary>
        /// 根据 EquipmentItemRelationId 获取实体信息。
        /// </summary>
        /// <param name="equipmentItemRelationId">EquipmentItemRelationId。</param>
        /// <returns>EquipmentItemRelation 实体对象。</returns>
        public EquipmentItemRelationInfo GetInfo(Int32 equipmentItemRelationId)
        {
            EquipmentItemRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentItemRelationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentItemRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentItemRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                    entity.ItemSpec = rdr.GetString(5);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>EquipmentItemRelation 实体对象。</returns>
        public EquipmentItemRelationInfo GetInfo(String fieldValue)
        {
            EquipmentItemRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_EquipmentItemRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new EquipmentItemRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                    entity.ItemSpec = rdr.GetString(5);
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取 EquipmentItemRelation 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="equipmentItemRelationCount">equipmentItemRelation 总数。</param>
        /// <returns>EquipmentItemRelation 列表。</returns>
        public List<EquipmentItemRelationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipmentItemRelationInfo> list = new List<EquipmentItemRelationInfo>();
            EquipmentItemRelationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwEquipmentItemRelation", "EquipmentItemRelationId",
                "[EquipmentItemRelationId], [ItemCode], [EqCode], [CreateBy], [CreateDateTime],[ItemSpec],ModifyBy,ModifyTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipmentItemRelationInfo(rdr.GetInt32(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetDateTime(4));
                    entity.ItemSpec = rdr.GetString(5);
                    if (!rdr.IsDBNull(rdr.GetOrdinal("ModifyTime"))) {
                        entity.ModifyBy = Convert.ToString(rdr["ModifyBy"]);
                        entity.ModifyTime = Convert.ToDateTime(rdr["ModifyTime"]);
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