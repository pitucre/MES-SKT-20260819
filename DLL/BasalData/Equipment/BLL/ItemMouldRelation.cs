using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Equipment.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class ItemMouldRelation
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） EquipmentItemRelation 信息。
        /// </summary>
        /// <param name="entity">EquipmentItemRelation 实体对象。</param>
        public Int32 Edit(ItemMouldRelationInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemMouldRelationId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int, 4),
                new SqlParameter("@MouldId", SqlDbType.Int, 4),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Remark", SqlDbType.VarChar, 200)
            };

            parms[0].Value = entity.ItemMouldRelationId;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.MouldId;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemMouldRelation_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 新增产品与模具名称关系
        /// </summary>
        /// <param name="itemId">产品ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="mouldString">设备ID</param>
        ///  <param name="type">操作类型 0=正常操作</param>
        /// <returns></returns>
        public string SaveMouldInItem(int itemId, string mouldString, string createBy,int type)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.VarChar,50),
                new SqlParameter("@MouldString", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50),
                new SqlParameter("@Type", SqlDbType.Int, 4),
                new SqlParameter("@Message", SqlDbType.VarChar, 50),
            };

            parms[0].Value = itemId;
            parms[1].Value = mouldString;
            parms[2].Value = createBy;
            parms[3].Value = type;
            parms[4].Direction = ParameterDirection.Output;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Mould_EditInItem", parms);

            return parms[4].Value.ToString();
        }

        /// <summary>
        /// 删除模具产品关系
        /// </summary>
        /// <param name="itemId">产品ID</param>
        /// <param name="createBy">用户名</param>
        /// <param name="mouldString">设备ID</param>
        public void RemoveMouldOutItem(int itemId, string mouldString, string createBy)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int,4),
                new SqlParameter("@MouldString", SqlDbType.VarChar, 200),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 50)
            };

            parms[0].Value = itemId;
            parms[1].Value = mouldString;
            parms[2].Value = createBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Mould_ItemDelete", parms);
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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemMouldRelation_Delete", parms);
        }

        /// <summary>
        /// 根据 equipmentMouldRelationId 获取实体信息。
        /// </summary>
        /// <param name="equipmentMouldRelationId">equipmentMouldRelationId。</param>
        /// <returns>EquipmentItemRelation 实体对象。</returns>
        public ItemMouldRelationInfo GetInfo(Int32 equipmentMouldRelationId)
        {
            ItemMouldRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = equipmentMouldRelationId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemMouldRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemMouldRelationInfo();
                    entity.ItemMouldRelationId = Convert.ToInt32(rdr["ItemMouldRelationId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
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
        public ItemMouldRelationInfo GetInfo(String fieldValue)
        {
            ItemMouldRelationInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_ItemMouldRelation_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new ItemMouldRelationInfo();
                    entity.ItemMouldRelationId = Convert.ToInt32(rdr["ItemMouldRelationId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
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
        public List<ItemMouldRelationInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemMouldRelationInfo> list = new List<ItemMouldRelationInfo>();
            ItemMouldRelationInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwItemMouldRelation", "ItemMouldRelationId",
                @"ItemMouldRelationId ,
           MouldId,
           ItemId,
            CreateBy,
           CreateDateTime,
           ItemCode,
           ItemName,
            BomName,
           IsDelete,
           Remark", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new ItemMouldRelationInfo();
                    entity.ItemMouldRelationId = Convert.ToInt32(rdr["ItemMouldRelationId"]);
                    entity.MouldId = Convert.ToInt32(rdr["MouldId"]);
                    entity.BomName = Convert.ToString(rdr["BomName"]);
                
                    entity.ItemId = Convert.ToInt32(rdr["ItemId"]);
                    entity.ItemName = Convert.ToString(rdr["ItemName"]);
                    entity.ItemCode = Convert.ToString(rdr["ItemCode"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    entity.CreateDateTime = Convert.ToDateTime(rdr["CreateDateTime"]);
                    entity.IsDelete = Convert.ToInt32(rdr["IsDelete"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
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