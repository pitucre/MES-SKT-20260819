using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Kanban.Model;

namespace SKT.LeanMES.Kanban.BLL
{
  public  class ProdEfficiencyKanban
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页备料信息
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ProdEfficiencyKanbanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            try
            {
                List<ProdEfficiencyKanbanInfo> list = new List<ProdEfficiencyKanbanInfo>();
                ProdEfficiencyKanbanInfo entity = null;

                SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[vwProdEfficiencyKanban]", "[LineId]",
                    "[LineId], [LineName],[ItemID],[ItemCode],[ItemName], [PutNum], [YieldNum], [ProductRate]", searchSettings, sortExpression);

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
                {
                    while (rdr.Read())
                    {
                        entity = new ProdEfficiencyKanbanInfo();
                        entity.LineId = rdr.GetInt32(0);
                        entity.LineName = rdr.GetString(1);
                        entity.ItemId = rdr.GetInt32(2);
                        entity.ItemCode = rdr.GetString(3);
                        entity.ItemName = rdr.GetString(4);
                        entity.PutNum = rdr.GetInt32(5);
                        entity.YieldNum = rdr.GetInt32(6);
                        entity.ProductRate = rdr.GetString(7);
                        list.Add(entity);
                    }
                    rdr.Close();
                }
                recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
                return list;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

        /// <summary>
        /// 获取看板记录
        /// </summary>
        /// <returns></returns>
        public DataTable GetInfo(string line)
        {
            if (line == null)
                 line="";
            DataTable dt = new DataTable();
            SqlParameter[] parms = new SqlParameter[]{
             new SqlParameter("@lineName", SqlDbType.VarChar,30)
            };
            parms[0].Value = line;
            return dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "[uspProdEfficiencyKanban]", parms);
        }
    }
}
