using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.Model;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Kanban.Model;
using System.Data.SqlClient;
using System.Data;

namespace SKT.LeanMES.Kanban.BLL
{
    public class MaterialPrepareKanban
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑仓库备料看板状态
        /// </summary>
        /// <param name="idString"></param>
        /// <param name="userName"></param>
        /// <param name="statu"></param>
        public void EditPrepareState(String idString, String userName, Int32 statu)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),           
                new SqlParameter("@PrepareState",SqlDbType.Int),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = statu;
            parms[2].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialRequest_EditPreState", parms);
        }
        /// <summary>
        /// 根据 MaintenancePlanId 获取MaintenancePlan实体信息。
        /// </summary>
        /// <param name="maintenancePlanId">MaintenancePlanId。</param>
        /// <returns>MaintenancePlan 实体对象。</returns>
        public DataTable GetInfo()
        {
            SqlParameter[] parms = new SqlParameter[]{
            };
            DataTable dt = new DataTable();

            return dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "Prod_MaterialPreKanban_GetInfo", parms);

        }
        /// <summary>
        /// 分页获取 MaintenancePlan 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mAINTAINANCECount">MaintenancePlan 总数。</param>
        /// <returns>MaintenancePlan 列表。</returns>
        public List<MaterialPrepareKanbanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MaterialPrepareKanbanInfo> list = new List<MaterialPrepareKanbanInfo>();
            MaterialPrepareKanbanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "vwMaterialPreKanban", "Id",
                "[Id],[FormNO],[Prioritys],[ItemName],[Description],[ResponseQty],[Units],[UserDate],[PrepareState],[MaterialRequestId]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new MaterialPrepareKanbanInfo(rdr.GetInt64(0), rdr.GetString(1), rdr.GetString(2), rdr.GetString(3), rdr.GetString(4), rdr.GetDecimal(5), rdr.GetString(6), rdr.GetDateTime(7), rdr.GetString(8), rdr.GetInt32(9));

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
