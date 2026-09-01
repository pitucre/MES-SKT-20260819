using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class ItemCategory
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ItemCategory 信息。
        /// </summary>
        /// <param name="entity">ItemCategory 实体对象。</param>
        public Int32 Edit(ItemCategoryInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ItemCategoryId", SqlDbType.Int),
                new SqlParameter("@ParentId", SqlDbType.Int),
                new SqlParameter("@CategoryName", SqlDbType.NVarChar, 50),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CategoryCode", SqlDbType.VarChar, 20),
                new SqlParameter("@IsLoadMateril", SqlDbType.Int),
            };

            parms[0].Value = entity.ItemCategoryId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ParentId;
            parms[2].Value = entity.CategoryName;
            parms[3].Value = entity.CreateBy;
            parms[4].Value = entity.ModifyBy;
            parms[5].Value = entity.CategoryCode;
            parms[6].Value = entity.IsLoadMateril;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemCategory_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ItemCategoryId 字符串删除 ItemCategory 信息。
        /// </summary>
        /// <param name="idString">ItemCategoryId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_ItemCategory_Delete", parms);
        }

        /// <summary>
        /// 根据 ItemCategoryId 获取实体信息。
        /// </summary>
        /// <param name="itemCategoryId">ItemCategoryId。</param>
        /// <returns>ItemCategory 实体对象。</returns>
        public ItemCategoryInfo GetInfo(Int32 itemCategoryId)
        {
            return ComMethod.GetInfo<ItemCategoryInfo>(itemCategoryId, "Basal_ItemCategory_GetInfo");             
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ItemCategory 实体对象。</returns>
        public ItemCategoryInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<ItemCategoryInfo>(fieldValue, "Basal_ItemCategory_GetInfo");    
        }

        /// <summary>
        /// 分页获取 ItemCategory 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="itemCategoryCount">itemCategory 总数。</param>
        /// <returns>ItemCategory 列表。</returns>
        public List<ItemCategoryInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemCategoryInfo> list = new List<ItemCategoryInfo>();
            //表名或者视图
            string strTb = "Basal_ItemCategory";
            //主键
            string strKey = "ItemCategoryId";
            //查询栏位字串
            string strColumns = @"[ItemCategoryId], [ParentId], [CategoryName], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],,ISNULL(IsLoadMateril,0) IsLoadMateril ";

            return ComMethod.GetComList<ItemCategoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public List<ItemCategoryInfo> GetCategoryAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ItemCategoryInfo> list = new List<ItemCategoryInfo>();
            //表名或者视图
            string strTb = "vwGetCategoryTree";
            //主键
            string strKey = "ItemCategoryId";
            //查询栏位字串
            string strColumns = @"[ItemCategoryId], [ParentId], [CategoryName],[ParentName]";

            return ComMethod.GetComList<ItemCategoryInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 获取类别树信息
        /// </summary>
        /// <returns></returns>
        public List<ItemCategoryInfo> GetCategoryTree()
        {
            
            string sql = "select * from vwGetCategoryTree";
            List<ItemCategoryInfo> list = new List<ItemCategoryInfo>();
            using(SqlDataReader rdr = SQLHelper.ExecuteReaderSqlText(SQLHelper.MESConnString,sql,null))
            {
                list = ComMethod.ToListEntity<ItemCategoryInfo>(rdr);
            }
            return list;
        }

        /// <summary>
        /// 获取类别信息
        /// </summary>
        /// <returns></returns>
        public List<ItemCategoryInfo> GetItemCategory(int parentId)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ParentId", SqlDbType.Int)                
            };
            parms[0].Value = parentId;
            string sql = "select * from Basal_ItemCategory where ParentId=@ParentId";
            return  ComMethod.GetListBySql<ItemCategoryInfo>(sql, parms);           
        }
    }
}