using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Product.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemABCClass
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） ItemABC 信息。
        /// </summary>
        /// <param name="entity">ItemABC 实体对象。</param>
        public Int32 Edit(ItemABCInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemABCId", SqlDbType.Int),
                new SqlParameter("@ABCClass", SqlDbType.VarChar, 10),
                new SqlParameter("@ABCSuper", SqlDbType.Int),
                new SqlParameter("@ABCVal", SqlDbType.Int),
                new SqlParameter("@ABCPercentVal", SqlDbType.Decimal),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50)
            };

            parms[0].Value = entity.ItemABCId;            
            parms[1].Value = entity.ABCClass;
            parms[2].Value = entity.ABCSuper;
            parms[3].Value = entity.ABCVal;
            parms[4].Value = entity.ABCPercentVal;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.Remark;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemABC_Edit", parms);

            return (Int32)parms[0].Value;
        }


        /// <summary>
        /// 根据 ItemABCId 获取实体信息。
        /// </summary>
        /// <param name="itemABCId">ItemABCId。</param>
        /// <returns>ItemABC 实体对象。</returns>
        public ItemABCInfo GetInfo(Int32 itemABCId)
        {
            return ComMethod.GetInfo<ItemABCInfo>(itemABCId, "Basal_ItemABC_GetInfo");
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
        public List<ItemABCInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemABCInfo> list = new List<ItemABCInfo>();
            //表名或者视图
            string strTb = @"vwBasal_ItemABC";////Basal_ItemABC
            //主键
            string strKey = "ItemABCId";
            //查询栏位字串
            string strColumns = @"ItemABCId ,
                                   ABCClass ,
                                   ABCSuper ,
                                   case ABCSuper when 1 then '数量' when 2 then '百分比' else '数量+百分比' end as ABCSuperDesc,
                                   ABCVal ,
                                   ABCPercentVal ,
                                   CreateBy ,
                                   CreateDateTime ,
                                   ModifyBy ,
                                   ModifyDateTime ,
                                   Remark";

            return ComMethod.GetComList<ItemABCInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
