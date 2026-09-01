using SKT.Common.DAL.Marshal;
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
    public class ERPWriteBackConfig
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 编辑（添加或更新） ERP_WriteBackConfig 信息。
        /// </summary>
        /// <param name="entity">ERP_WriteBackConfig 实体对象。</param>
        public Int32 Edit(ERPWriteBackConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@WriteBackConfigId", SqlDbType.Int) { Value = entity.WriteBackConfigId },
                new SqlParameter("@WriteBackCode", SqlDbType.VarChar, 50) { Value = entity.WriteBackCode },
                new SqlParameter("@WriteBackFlag", SqlDbType.Int) { Value = entity.WriteBackFlag },
                new SqlParameter("@Remark", SqlDbType.NVarChar, 500) { Value = entity.Remark },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
            };
            return SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspERPWriteBackConfigEdit", parms);
        }

        /// <summary>
        /// 根据 WriteBackConfigureId 获取实体信息。
        /// </summary>
        /// <param name="writeBackConfigureId">WriteBackConfigureId。</param>
        /// <returns>ERP_WriteBackConfig 实体对象。</returns>
        public ERPWriteBackConfigInfo GetInfo(ERPWriteBackConfigInfo entity)
        {
            var sql = "SELECT vw.WriteBackConfigId,vw.WriteBackCode,vw.WriteBackName,vw.WriteBackFlag,vw.Remark,vw.CreateBy,vw.CreateDateTime,vw.ModifyBy,vw.ModifyDateTime,vw.WriteBackFlagName FROM dbo.vwGetERPWriteBackConfig vw WHERE vw.WriteBackConfigId = @WriteBackConfigId";
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@WriteBackConfigId", SqlDbType.Int) { Value = entity.WriteBackConfigId },
            };
            return ComMethod.GetBySql<ERPWriteBackConfigInfo>(sql, parms);
        }

        /// <summary>
        /// 分页获取 ERP_WriteBackConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <returns>ERP_WriteBackConfig 列表。</returns>
        public List<ERPWriteBackConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            var columns = "WriteBackConfigId,WriteBackCode,WriteBackName,WriteBackFlag,Remark,CreateBy,CreateDateTime,ModifyBy,ModifyDateTime,WriteBackFlagName";
            return ComMethod.GetComList<ERPWriteBackConfigInfo>(ref this.recordCount, startRow, maxRows, "dbo.vwGetERPWriteBackConfig", string.Empty, columns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
