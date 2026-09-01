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
    public class StationBom
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 ItemBom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomCount">itemBom 总数。</param>
        /// <returns>ItemBom 列表。</returns>
        public List<ItemBomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomInfo> list = new List<ItemBomInfo>();
            //表名或者视图
            string strTb = @"vwGetStationBomList";
            //主键
            string strKey = "ItemBomId";
            //查询栏位字串
            string strColumns = @"[ItemBomId],[OrganizationCode], [BomName],[Version], [IsCurrentVer], [ItemId], [ItemCode], [ItemName], [CreateDate], [Description], [Source], [Site], [State], [CreateBy], [CreateDateTime]";
            
            return ComMethod.GetComList<ItemBomInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 分页获取 ItemBom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemBomCount">itemBom 总数。</param>
        /// <returns>ItemBom 列表。</returns>
        public List<ItemBomChildInfo> GetBomChildAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemBomChildInfo> list = new List<ItemBomChildInfo>();
            //表名或者视图
            string strTb = @"vwGetStationBomDetailList";
            //主键
            string strKey = "ItemBomId";
            //查询栏位字串
            string strColumns = @" [ItemBomId]
                                  ,[ItemLevel]
                                  ,[ItemCode]
                                  ,[ItemName]
                                  ,[Station]
                                  ,[Units]
                                  ,[Qty]
                                  ,[UsePosition]
                                  ,[IsFictitious]";

            return ComMethod.GetComList<ItemBomChildInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
