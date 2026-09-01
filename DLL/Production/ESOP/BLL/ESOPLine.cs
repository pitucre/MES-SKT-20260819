using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SKT.LeanMES.ESOP.Model;
using SKT.Common.DAL.Marshal;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.ESOP.BLL
{
    public class ESOPLine
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） ESOPLine 信息。
        /// </summary>
        /// <param name="entity">ESOPLine 实体对象。</param>
        public Int32 Edit(ESOPLineInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@ESOPLineId", SqlDbType.Int),
                new SqlParameter("@LineId", SqlDbType.Int),
                new SqlParameter("@ProdOrderId", SqlDbType.Int),
                new SqlParameter("@IsDefault", SqlDbType.Bit),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@CreateDate", SqlDbType.DateTime),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyDate", SqlDbType.DateTime)
            };

            parms[0].Value = entity.ESOPLineId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.LineId;
            parms[2].Value = entity.ProdOrderId;
            parms[3].Value = entity.IsDefault;
            parms[4].Value = entity.CreateBy;
            parms[5].Value = entity.CreateDate;
            parms[6].Value = entity.ModifyBy;
            parms[7].Value = entity.ModifyDate;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPLine_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 ESOPLineId 字符串删除 ESOPLine 信息。
        /// </summary>
        /// <param name="idString">ESOPLineId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_ESOPLine_Delete", parms);
        }

        /// <summary>
        /// 根据 ESOPLineId 获取实体信息。
        /// </summary>
        /// <param name="eSOPLineId">ESOPLineId。</param>
        /// <returns>ESOPLine 实体对象。</returns>
        public ESOPLineInfo GetInfo(Int32 eSOPLineId)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<ESOPLineInfo>(eSOPLineId, "Prod_ESOPLine_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>ESOPLine 实体对象。</returns>
        public ESOPLineInfo GetInfo(String fieldValue)
        {
            return CommonHelper.BLL.ComMethod.GetInfo<ESOPLineInfo>(fieldValue, "Prod_ESOPLine_GetInfo");
        }

        /// <summary>
        /// 分页获取 ESOPLine 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="eSOPLineCount">eSOPLine 总数。</param>
        /// <returns>ESOPLine 列表。</returns>
        public List<ESOPLineInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<ESOPLineInfo> list = new List<ESOPLineInfo>();
            //表名或者视图
            string strTb = "vwESOPLineInfo";
            //主键
            string strKey = "ESOPLineId";
            //查询栏位字串
            string strColumns = @"[ESOPLineId], [LineId], [LineName], [ProdOrderId], [OrderNo],[ItemCode], [ItemName],[IsDefault], [CreateBy], [CreateDate], [ModifyBy],[ModifyDate]";

            return ComMethod.GetComList<ESOPLineInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
