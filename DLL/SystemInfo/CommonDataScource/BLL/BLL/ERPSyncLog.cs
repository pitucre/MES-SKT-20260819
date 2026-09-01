using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System.Data;
using System.Data.SqlClient;
using SKT.LeanMES.CommonDataSource.Model;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class ERPSyncLog
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 ERP同步日志 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ERPSyncLogInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "SyncLogId,SyncCode,SyncProcName,SyncResult,SyncMsg,BillNo,QueryStartTime,QueryEndTime,InsertRowCount,UpdateRowCount,DeleteRowCount,StartSyncTime,EndSyncTime,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,SyncName,SyncResultName";
            return ComMethod.GetComList<ERPSyncLogInfo>(ref this.recordCount, startRow, maxRows, "vwGetERPSyncLog", string.Empty, columns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
