using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SteelItem.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.SteelItem.BLL
{
    public class SteelItem
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SteelItem 信息。
        /// </summary>
        /// <param name="entity">SteelItem 实体对象。</param>
        public Int32 Edit(SteelItemInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SteelItemId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@Layout", SqlDbType.NVarChar,20)
            };

            parms[0].Value = entity.SteelItemId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.EquipmentId;
            parms[3].Value = entity.EquipmentId;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SteelItem_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SteelItemId 字符串删除 SteelItem 信息。
        /// </summary>
        /// <param name="idString">SteelItemId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_SteelItem_Delete", parms);
        }

        /// <summary>
        /// 根据 SteelItemId 获取实体信息。
        /// </summary>
        /// <param name="steelItemId">SteelItemId。</param>
        /// <returns>SteelItem 实体对象。</returns>
        public SteelItemInfo GetInfo(Int32 steelItemId)
        {
            SteelItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = steelItemId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelItem_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SteelItem 实体对象。</returns>
        public SteelItemInfo GetInfo(String fieldValue)
        {
            SteelItemInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50), 
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = fieldValue;
            parms[1].Value = false;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_SteelItem_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SteelItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                }
                rdr.Close();
            }

            return entity;
        }
        /// <summary>
        /// 插入产品与钢网信息 (一个产品对多个钢网的情况)
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="itemId"></param>
        /// <returns></returns>
        public Int32 InsertItemSteelInfo(Int32 ItemId, Int32 EquipmentId, String Layout, String OptionType)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@EquipmentId", SqlDbType.Int),
                new SqlParameter("@Layout", SqlDbType.NVarChar,20),
                new SqlParameter("@Type", SqlDbType.NVarChar,50)
            };
            parms[0].Value = ItemId;
            parms[1].Value = EquipmentId;
            parms[2].Value = Layout;
            parms[3].Value = OptionType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspInsertItemSteelInfo", parms);

            return (Int32)parms[1].Value;
        }
        /// <summary>
        /// 移除产品与钢网关系
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="hdfId"></param>
        /// <param name="temp"></param>
        /// <param name="creater"></param>
        /// <param name="createrid"></param>
        /// <returns></returns>
        public void DeleteItemSteelInfo(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.NVarChar,50)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveItemSteel", parms);            
        }
        /// <summary>
        /// 移除产品与工具关系
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="hdfId"></param>
        /// <param name="temp"></param>
        /// <param name="creater"></param>
        /// <param name="createrid"></param>
        /// <returns></returns>
        public void DeleteItemSpareInfo(String idString)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.NVarChar,50)
            };
            parms[0].Value = idString;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspRemoveItemSpare", parms);
        }
        /// <summary>
        /// 分页获取 SteelItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// 
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="steelItemCount">steelItem 总数。</param>
        /// <returns>SteelItem 列表。</returns>
        public List<SteelItemInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelItemInfo> list = new List<SteelItemInfo>();
            SteelItemInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetItemSteelList", "SteelItemId",
                "[SteelItemId], [ItemId], [EquipmentId],[Layout],[ItemCode],[ItemName],[EquipmentCode],[EquipmentName],[ItemSpec]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                    entity.ItemCode = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    entity.EquipmentCode = rdr.GetString(6);
                    entity.EquipmentName = rdr.GetString(7);
                    entity.ItemSpec = rdr.GetString(8);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }
        /// <summary>
        /// 分页获取 SteelItem 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// 
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="steelItemCount">steelItem 总数。</param>
        /// <returns>SteelItem 列表。</returns>
        public List<SteelItemInfo> GetAll_Spare(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SteelItemInfo> list = new List<SteelItemInfo>();
            SteelItemInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwGetItemSpareList", "SteelItemId",
                "[SteelItemId], [ItemId], [EquipmentId],[Layout],[ItemCode],[ItemName],[EquipmentCode],[EquipmentName],[ItemSpec]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SteelItemInfo(rdr.GetInt32(0), rdr.GetInt32(1), rdr.GetInt32(2), rdr.GetString(3));
                    entity.ItemCode = rdr.GetString(4);
                    entity.ItemName = rdr.GetString(5);
                    entity.EquipmentCode = rdr.GetString(6);
                    entity.EquipmentName = rdr.GetString(7);
                    entity.ItemSpec = rdr.GetString(8);
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