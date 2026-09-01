using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.LeanMES.SerialNumber.Model;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SerialNumber.BLL
{
    public class OfflineSNConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） OfflineSNConfig 信息。
        /// </summary>
        /// <param name="entity">OfflineSNConfig 实体对象。</param>
        public Int32 Edit(OfflineSNConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@OfflineSNConfigId", SqlDbType.Int),
                new SqlParameter("@MainItemId", SqlDbType.Int),
                new SqlParameter("@PartItemId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@AssemblyQty", SqlDbType.Int),
                new SqlParameter("@MaskId", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@PartType", SqlDbType.VarChar, 20),
            };

            parms[0].Value = entity.OfflineSNConfigId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.MainItemId;
            parms[2].Value = entity.PartItemId;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.AssemblyQty;
            parms[5].Value = entity.MaskId;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.PartType;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OfflineSNConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 OfflineSNConfigId 字符串删除 OfflineSNConfig 信息。
        /// </summary>
        /// <param name="idString">OfflineSNConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_OfflineSNConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 OfflineSNConfigId 获取实体信息。
        /// </summary>
        /// <param name="offlineSNConfigId">OfflineSNConfigId。</param>
        /// <returns>OfflineSNConfig 实体对象。</returns>
        public OfflineSNConfigInfo GetInfo(Int32 offlineSNConfigId)
        {
            return ComMethod.GetInfo<OfflineSNConfigInfo>(offlineSNConfigId, "Prod_OfflineSNConfig_GetInfo");             
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>OfflineSNConfig 实体对象。</returns>
        public OfflineSNConfigInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<OfflineSNConfigInfo>(fieldValue, "Prod_OfflineSNConfig_GetInfo");           
        }

        /// <summary>
        /// 分页获取 OfflineSNConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="offlineSNConfigCount">offlineSNConfig 总数。</param>
        /// <returns>OfflineSNConfig 列表。</returns>
        public List<OfflineSNConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<OfflineSNConfigInfo> list = new List<OfflineSNConfigInfo>();
            //表名或者视图
            string strTb = "vwGetOfflieSNConfigList";
            //主键
            string strKey = "OfflineSNConfigId";
            //查询栏位字串
            string strColumns = @"[OfflineSNConfigId], [MainItemId], [MainItemCode], [PartItemId], [PartItemCode], [StationId], [Station], [AssemblyQty], [MaskId], [MaskGroup],[Remark],[CreateBy],[CreateDateTime],[ModifyBy],[ModifyDateTime],[PartName],[PartType]";

            return ComMethod.GetComList<OfflineSNConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}