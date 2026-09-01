using SKT.Common.Model;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.CommonHelper.BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CommonDataSource.BLL
{
    public class ERPWriteBackLog
    {
        private int recordCount = 0;

        /// <summary>
        /// 根据 ERP_WriteBackLog 获取实体信息。
        /// </summary>
        /// <param name="WriteBackLogId">WriteBackLogId。</param>
        /// <returns>ERPWriteBackLog 实体对象。</returns>
        public ERPWriteBackLogInfo GetInfo(ERPWriteBackLogInfo entity)
        {
            var sql = "SELECT vw.WriteBackLogId,vw.WriteBackCode,vw.MD5,vw.ERPResult,vw.ERPNo,vw.ERPMsg,vw.ERPDes,vw.MESMsg,vw.MESBillNo,vw.WriteBackData,vw.WriteBackDataJSON,vw.ReceiveData,vw.CreateBy,vw.CreateDateTime,vw.ERPResultName,vw.WriteBackName FROM dbo.vwGetERPWriteBackLog vw WHERE vw.WriteBackLogId = @WriteBackLogId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@WriteBackLogId", SqlDbType.Int) { Value = entity.WriteBackLogId },
            };
            return ComMethod.GetBySql<ERPWriteBackLogInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 ERP_WriteBackLog 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>ERPWriteBackLog 列表。</returns>
        public List<ERPWriteBackLogInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "dbo.vwGetERPWriteBackLog";
            //查询栏位字串
            string strColumns = @"WriteBackLogId,WriteBackCode,MD5,ERPResult,ERPNo,ERPMsg,ERPDes,MESMsg,MESBillNo,WriteBackData,WriteBackDataJSON,ReceiveData,CreateBy,CreateDateTime,ERPResultName,WriteBackName";
            return ComMethod.GetComList<ERPWriteBackLogInfo>(ref recordCount, startRow, maxRows, strTb, string.Empty, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
