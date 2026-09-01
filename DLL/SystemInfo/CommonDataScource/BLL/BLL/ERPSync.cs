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
    public class ERPSync
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 分页获取 ERP同步 列表数据
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<ERPSyncInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            string columns = "SyncId,SyncCode,SyncName,IsFullSync,InitCompleteFlag,IncrementalValue,LastSyncResult,LastSyncMsg,LastSyncTime,Remark,EnableFlag,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,FullSyncName,InitCompleteFlagName,LastSyncResultName";
            return ComMethod.GetComList<ERPSyncInfo>(ref this.recordCount, startRow, maxRows, "vwGetERPSync", string.Empty, columns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
