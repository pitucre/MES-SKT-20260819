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
    public class EquipMaintKanban
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取设备保养看板记录
        /// </summary>
        /// <returns></returns>
        public DataTable GetInfo()
        {
            SqlParameter[] parms = new SqlParameter[]{
            };
            DataTable dt = new DataTable();

            return dt = SQLHelper.ExecuteDataTableStoredProcedure(SQLHelper.MESConnString, "prod_EquipMaintKanban_GetInfo", parms);

        }
        /// <summary>
        /// 分页获取 Equipment 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eQUIPMENTCount">Equipment 总数。</param>
        /// <returns>Equipment 列表。</returns>
        public List<EquipMaintKanbanInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<EquipMaintKanbanInfo> list = new List<EquipMaintKanbanInfo>();
            EquipMaintKanbanInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows,
                "vwEquipMaintKanban", "MaintenancePlanId", "[MaintenancePlanId],[EquipmentCode],[Status],[FinisheDateTime],[LastMaintTime],[MaintainPerson],[MaintainContents],[EquipmentName]", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new EquipMaintKanbanInfo();
                    entity.MaintenancePlanId = rdr.GetInt32(0);
                    entity.EquipmentCode = rdr.GetString(1);
                    entity.StatusName = rdr.GetString(2);
                    entity.FinisheDateTime = rdr.GetDateTime(3);
                    entity.LastMaintTime = rdr.GetString(4);
                    entity.MaintainPerson = rdr.GetString(5);
                    entity.MaintainContents = rdr.GetString(6);
                    entity.EquipmentName = rdr.GetString(7);
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
