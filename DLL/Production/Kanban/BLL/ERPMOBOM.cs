using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Kanban.Model;

namespace SKT.LeanMES.Kanban.BLL
{
  public class ERPMOBOM
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
        public List<ERPMOBOMInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            try
            {
                List<ERPMOBOMInfo> list = new List<ERPMOBOMInfo>();
                ERPMOBOMInfo entity = null;

                SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "[vwERPMOBOM]", "[MOBomId]",
                    "[MOBomId], [MDeptCode],[MDeptName],[InvCode], [InvName], [WhCode], [WhName], [VouchCode], [VouchName], [Qty], [RequisitionIssQty], [IssQty], [CompScrap], [State], [State_CN],[MoCode],[CreateDateTime]", searchSettings, sortExpression);

                using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
                {
                    while (rdr.Read())
                    {
                        entity = new ERPMOBOMInfo();
                        entity.MOBomId = rdr.GetInt32(0);
                        entity.MDeptCode = rdr.GetString(1);
                        entity.MDeptName = rdr.GetString(2);
                        entity.InvCode = rdr.GetString(3);
                        entity.InvName = rdr.GetString(4);
                        entity.WhCode = rdr.GetString(5);
                        entity.WhName = rdr.GetString(6);
                        entity.VouchCode = rdr.GetString(7);
                        entity.VouchName = rdr.GetString(8);
                        entity.Qty = rdr.GetDecimal(9);
                        entity.RequisitionIssQty = rdr.GetDecimal(10);
                        entity.IssQty = rdr.GetDecimal(11);
                        entity.CompScrap = rdr.GetDecimal(12);
                        entity.State_cn = rdr.GetString(14);
                        entity.MoCode = rdr.GetString(15);
                        entity.CreateDate = rdr.GetDateTime(16);
                        list.Add(entity);
                    }
                    rdr.Close();
                }
                recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
                return list;
            }catch(Exception ex)
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
        public DataTable GetInfo()
        {
            SqlParameter[] parms = new SqlParameter[]{
            };
            DataTable dt = new DataTable();
            return dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "[ERP_MOBOMKanban_GetInfo]", parms);
        }
    }
}
