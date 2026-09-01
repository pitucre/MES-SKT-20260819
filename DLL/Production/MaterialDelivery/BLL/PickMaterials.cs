using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.MaterialDelivery.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;

namespace SKT.LeanMES.MaterialDelivery.BLL
{
    public class PickMaterials
    {
        private Int32 recordCount = 0;
        
        /// <summary>
        /// 分页获取 PickMaterials 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="pickMaterialsCount">pickMaterials 总数。</param>
        /// <returns>PickMaterials 列表。</returns>
        public List<PickMaterialsInfo> GetPickDetailList(Int32 pickId)
        {
            List<PickMaterialsInfo> list = new List<PickMaterialsInfo>();
            PickMaterialsInfo entity = null;
            SqlParameter[] parms = new SqlParameter[] { 
                   new   SqlParameter("@pickId",SqlDbType.Int)
            };
            parms[0].Value = pickId;
            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "uspGetPickBodyInfoById", parms))
            {
                while (rdr.Read())
                {
                    entity = new PickMaterialsInfo();
                    entity.PickSubId = rdr.GetInt32(0);
                    entity.PickId = rdr.GetInt32(1);
                    entity.ItemId = rdr.GetInt32(2);
                    entity.Quantity = rdr.GetInt32(3);
                    entity.ItemName = rdr.GetString(4);
                    entity.ItemCode = rdr.GetString(5);
                    list.Add(entity);
                }
                rdr.Close();
            }
            return list;
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}