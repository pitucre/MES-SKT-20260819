using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SPC.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SPC.BLL
{
    public class SPCWarn
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SPCWarn 信息。
        /// </summary>
        /// <param name="entity">SPCWarn 实体对象。</param>
        public void Edit(SPCWarnInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCWarnId", SqlDbType.Int),              
                new SqlParameter("@Reson", SqlDbType.NVarChar, 200),
                new SqlParameter("@DealDesc", SqlDbType.NVarChar, 200),
                new SqlParameter("@DealBy", SqlDbType.NVarChar, 50)               
            };

            parms[0].Value = entity.SPCWarnId;
            parms[1].Value = entity.Reson;
            parms[2].Value = entity.DealDesc;
            parms[3].Value = entity.DealBy;          

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCWarn_Edit", parms); 
        }

        /// <summary>
        /// 根据 SPCWarnId 字符串删除 SPCWarn 信息。
        /// </summary>
        /// <param name="idString">SPCWarnId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCWarn_Delete", parms);
        }

        /// <summary>
        /// 根据 SPCWarnId 获取实体信息。
        /// </summary>
        /// <param name="sPCWarnId">SPCWarnId。</param>
        /// <returns>SPCWarn 实体对象。</returns>
        public SPCWarnInfo GetInfo(Int32 sPCWarnId)
        {
            return ComMethod.GetInfo<SPCWarnInfo>(sPCWarnId, "Quality_SPCWarn_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SPCWarn 实体对象。</returns>
        public SPCWarnInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<SPCWarnInfo>(fieldValue, "Quality_SPCWarn_GetInfo");
        }

        /// <summary>
        /// 分页获取 SPCWarn 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sPCWarnCount">sPCWarn 总数。</param>
        /// <returns>SPCWarn 列表。</returns>
        public List<SPCWarnInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SPCWarnInfo> list = new List<SPCWarnInfo>();

            //表名或者视图
            string strTb = "vwGetSPCWarn";
            //主键
            string strKey = "SPCWarnId";
            //查询栏位字串
            string strColumns = @"[SPCWarnId], [SPCTaskId],[TaskName], [SPCWarnMsg], [WarnTime], [Reson], [DealDesc], [DealBy], [DealTime], [CreateBy]";

            return ComMethod.GetComList<SPCWarnInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}