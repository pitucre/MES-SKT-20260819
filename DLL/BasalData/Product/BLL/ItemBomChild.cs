using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.Product.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemBomChild
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ItemBomChild 信息。
        /// </summary>
        /// <param name="entity">ItemBomChild 实体对象。</param>
        public Int32 Edit(ItemBomChildInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemBomChildId", SqlDbType.Int),
                new SqlParameter("@ItemBomId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 100),
                new SqlParameter("@ItemName", SqlDbType.VarChar, 120),
                new SqlParameter("@ItemLevel", SqlDbType.VarChar, 30),
                new SqlParameter("@Qty", SqlDbType.Decimal),
                new SqlParameter("@Units", SqlDbType.VarChar, 10),
                new SqlParameter("@UsePosition", SqlDbType.NVarChar, 1000),
                new SqlParameter("@IsFictitious", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@FeatureCode", SqlDbType.VarChar, 50),
            };

            parms[0].Value = entity.ItemBomChildId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemBomId;
            parms[2].Value = entity.ItemId;
            parms[3].Value = entity.ItemCode;
            parms[4].Value = entity.ItemName;
            parms[5].Value = entity.ItemLevel;
            parms[6].Value = entity.Qty;
            parms[7].Value = entity.Units;
            parms[8].Value = entity.UsePosition;
            parms[9].Value = entity.IsFictitious;
            parms[10].Value = entity.CreateBy;
            parms[11].Value = entity.ModifyBy;
            parms[12].Value = entity.FeatureCode;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemBomChild_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ItemBomChildId 字符串删除 ItemBomChild 信息。
        /// </summary>
        /// <param name="idString">ItemBomChildId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemBomChild_Delete", parms);
        }

        /// <summary>
        /// 根据 ItemBomChildId 获取实体信息。
        /// </summary>
        /// <param name="itemBomChildId">ItemBomChildId。</param>
        /// <returns>ItemBomChild 实体对象。</returns>
        public ItemBomChildInfo GetInfo(Int32 itemBomChildId)
        {
            return ComMethod.GetInfo<ItemBomChildInfo>(itemBomChildId, "Basal_ItemBomChild_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ItemBomChild 实体对象。</returns>
        public ItemBomChildInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<ItemBomChildInfo>(fieldValue, "Basal_ItemBomChild_GetInfo");
        }

        /// <summary>
        /// 分页获取 ItemBomChild 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomChildInfo> list = new List<ItemBomChildInfo>();
            //表名或者视图
            string strTb = "Basal_ItemBomChild a INNER JOIN dbo.Basal_Item b ON a.ItemCode=b.ItemCode ";
            //主键
            string strKey = "ItemBomChildId";
            //查询栏位字串
            string strColumns = @"[ItemBomChildId], a.[ItemBomId], b.[ItemId],  b.[ItemCode],  b.[ItemName], a.[ItemLevel], [Qty],  b.[Units], a.[UsePosition], a.[IsFictitious], a.[InsertDateTime], a.[UpdateDateTime], a.[CreateBy], a.[CreateDateTime],a.FeatureCode";

            return ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 分页获取 ItemBomChild 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetChildInfoAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomChildInfo> list = new List<ItemBomChildInfo>();
            //表名或者视图
            string strTb = "vwItemBomChildInfo";
            //主键
            string strKey = "ItemBomChildId";
            //查询栏位字串
            string strColumns = @"[ItemBomChildId],[ItemBomId],[ItemId],[ItemCode],[ItemName],[ItemLevel],
[Qty],[Units],[UsePosition],[IsFictitious],[InsertDateTime],[UpdateDateTime],[CreateBy],[CreateDateTime]";

            return ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }
        /// <summary>
        /// 分页获取 ItemBomChild 资料(用于根据主品号的产品查询Bom的品号)。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetAllByBomItemId(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomChildInfo> list = new List<ItemBomChildInfo>();
            //表名或者视图
            string strTb = @"vw_BomChildItem";
            //主键
            string strKey = "ItemBomChildId";
            //查询栏位字串
            string strColumns = @"[ItemBomChildId], [ItemBomId], [ItemId],  [ItemCode],  [ItemName], [ItemLevel], [Qty],  [Units]";

            return ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取 ItemBomChild 资料(用于根据主品号的产品查询Bom的品号)。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetAllByBomItemCode(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomChildInfo> list = new List<ItemBomChildInfo>();
            //表名或者视图
            string strTb = @"vw_BomChildByItemCode";
            //主键
            string strKey = "ItemBomChildId";
            //查询栏位字串
            string strColumns = @"[ItemBomChildId], [ItemBomId], [ItemId],  [ItemCode],  [ItemName], [ItemLevel], [Qty],  [Units],  [BomItemCode]";

            return ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }


        /// <summary>
        /// 分页获取 ItemBomChild 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetItemBomList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetItemBomInfo";
            //主键
            string strKey = "ItemBomChildId";
            //查询栏位字串
            string strColumns = @"[ItemBomChildId],[ItemBomId],[ItemId], [ItemCode], [ItemName],[ItemLevel],[Qty], [Units],[UsePosition],[IsFictitious],[InsertDateTime],[UpdateDateTime],[CreateBy],[CreateDateTime]";

            var list = ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }


        /// <summary>
        /// 获取物料BOM列表
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public List<ItemBomChildInfo> GetItemBomListByPosition(ItemBomChildInfo entity)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("SELECT");
            sb.Append(" [ItemBomChildId],[ItemBomId],[ItemId],[ItemCode],[ItemName],[ItemLevel],[Qty], [Units],[UsePosition],[IsFictitious],[InsertDateTime],[UpdateDateTime],[CreateBy],[CreateDateTime]");
            sb.Append(" FROM vwGetItemBomInfo");
            sb.Append(" WHERE UsePosition = @UsePosition");
            SqlParameter[] prams = {
                new SqlParameter("@UsePosition",SqlDbType.VarChar),
            };
            prams[0].Value = entity.UsePosition;
            var list = ComMethod.GetListBySql<ItemBomChildInfo>(sb.ToString(), prams);
            return list;
        }

        /// <summary>
        /// 分页 获取物料BOM上料列表
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetItemBomGRNList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetItemBomGRN";
            //主键
            string strKey = "MaterialUnitID";
            //查询栏位字串
            string strColumns = "MaterialUnitID,SerialNumber,ItemID,ItemName,ItemCode,ItemSpec,Qty,UsePosition";

            var list = ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        /// <summary>
        /// 分页 获取物料BOM上料列表（SMT）
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetItemBomGRNListSMT(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetItemBomGRNSMT";
            //主键
            string strKey = "MaterialUnitID";
            //查询栏位字串
            string strColumns = "MaterialUnitID,SerialNumber,ItemID,ItemName,ItemCode,ItemSpec,Qty,UsePosition,ProdOrderId";

            var list = ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        /// <summary>
        /// 分页 获取物料BOM上料列表（DIP）
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomChildCount">itemBomChild 总数。</param>
        /// <returns>ItemBomChild 列表。</returns>
        public List<ItemBomChildInfo> GetItemBomGRNListDIP(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetItemBomGRNDIP";
            //主键
            string strKey = "MaterialUnitID";
            //查询栏位字串
            string strColumns = "MaterialUnitID,SerialNumber,ItemID,ItemName,ItemCode,ItemSpec,Qty,UsePosition,ProdOrderId";

            var list = ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 物料BOM明细列表导出EXCEL获取数据的方法
        /// </summary>
        /// <param name="ItemBomId">ItemBomId</param>
        /// <returns></returns>
        public DataTable ImportToExcel(int ItemBomId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemBomId", SqlDbType.Int)
            };
            parms[0].Value = ItemBomId;

            return SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "uspBomChildToEXCEL", parms);
        }


    }
}