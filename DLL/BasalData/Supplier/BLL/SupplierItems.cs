using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using SKT.Common.DAL.Marshal;
using System.Data;
using SKT.LeanMES.Supplier.Model;
using SKT.Common.Model;

namespace SKT.LeanMES.Supplier.BLL
{
    public class SupplierItems
    {
         private Int32 recordCount = 0;
        /// <summary>
        /// 把物料添加到供应商中
        /// </summary>
        /// <param name="SupplierId"></param>
        /// <param name="UserIdString"></param>
        /// <param name="UserName"></param>
         public void AssignItemToSuplier(int SupplierId, string ItemIdString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@ItemIdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };
            parms[0].Value = SupplierId;
            parms[1].Value = ItemIdString;
            parms[2].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_AddItemsToSupplier", parms);
        }
        /// <summary>
        /// 从供应商中移除物料
        /// </summary>
        /// <param name="SupplierId"></param>
        /// <param name="UserIdString"></param>
        /// <param name="UserName"></param>
         public void RemoveItemFromSuplierint(int SupplierId, string ItemIdString, string UserName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SupplierId", SqlDbType.Int),
                new SqlParameter("@ItemIdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };
            parms[0].Value = SupplierId;
            parms[1].Value = ItemIdString;
            parms[2].Value = UserName;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_RemoveItemSFromSupplier", parms);
        }
        /// <summary>
        /// 分页获取 供应商和物料 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="Basal_SupplierCount">Basal_Supplier 总数。</param>
        /// <returns>Basal_Supplier 列表。</returns>
        public List<SupplierItemsInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SupplierItemsInfo> list = new List<SupplierItemsInfo>();
            SupplierItemsInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vWSupplierItems", "ItemID",
            "SupplierItemId,ItemID,ItemCode,ItemName", searchSettings, sortExpression);
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SupplierItemsInfo();
                    entity.SupplierItemId = rdr.GetInt32(0);
                    entity.ItemId = rdr.GetInt32(1);
                    entity.ItemCode= rdr.GetString(2);
                    entity.ItemName = rdr.GetString(3);
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
