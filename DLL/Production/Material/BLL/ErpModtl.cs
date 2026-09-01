using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Material.Model;
namespace SKT.LeanMES.Material.BLL
{
    public class ErpModtl
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 分页获取 工单Bom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="partNoCount">partNo 总数。</param>
        /// <returns>PartNo 列表。</returns>
        public List<ErpModtlInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ErpModtlInfo> list = new List<ErpModtlInfo>();
            ErpModtlInfo entity = null;
            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwErpmodtl", "Id",
                "Id,MOCode", searchSettings, sortExpression);
            using (DataTable dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                for (int i = 0; i < dt.Rows.Count;i++ )
                {
                    entity = new ErpModtlInfo();
                    //entity.Id = Convert.ToInt32(dt.Rows[i]["ID"]);
                    entity.MOCode = dt.Rows[i]["MOCode"].ToString();
                    list.Add(entity);
                }
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
