using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using SKT.Common.DAL.Marshal;
using SKT.LeanMES.Container.Model;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Container.BLL
{
    public class PackingAccessories
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PackingAccessoriesConfig 信息。
        /// </summary>
        /// <param name="entity">PackingAccessoriesConfig 实体对象。</param>
        public Int32 Edit(PackingAccessoriesConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@PackingAccessoriesConfigId", SqlDbType.Int),
                new SqlParameter("@ItemId", SqlDbType.Int),
                new SqlParameter("@AccessoriesName", SqlDbType.NVarChar, 50),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@AccessoriesQty", SqlDbType.Int),
                new SqlParameter("@MaskId", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@Sequence", SqlDbType.Int),
                new SqlParameter("@CheckType", SqlDbType.Int)
            };

            parms[0].Value = entity.PackingAccessoriesConfigId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ItemId;
            parms[2].Value = entity.AccessoriesName;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.AccessoriesQty;
            parms[5].Value = entity.MaskId;
            parms[6].Value = entity.Remark;
            parms[7].Value = entity.CreateBy;
            parms[8].Value = entity.ModifyBy;
            parms[9].Value = entity.Sequence;
            parms[10].Value = entity.CheckType;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PackingAccessoriesConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 PackingAccessoriesConfigId 字符串删除 PackingAccessoriesConfig 信息。
        /// </summary>
        /// <param name="idString">PackingAccessoriesConfigId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PackingAccessoriesConfig_Delete", parms);
        }

        /// <summary>
        /// 根据 PackingAccessoriesConfigId 获取实体信息。
        /// </summary>
        /// <param name="packingAccessoriesConfigId">PackingAccessoriesConfigId。</param>
        /// <returns>PackingAccessoriesConfig 实体对象。</returns>
        public PackingAccessoriesConfigInfo GetInfo(Int32 packingAccessoriesConfigId)
        {
            return ComMethod.GetInfo<PackingAccessoriesConfigInfo>(packingAccessoriesConfigId, "Prod_PackingAccessoriesConfig_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>PackingAccessoriesConfig 实体对象。</returns>
        public PackingAccessoriesConfigInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<PackingAccessoriesConfigInfo>(fieldValue, "Prod_PackingAccessoriesConfig_GetInfo");
        }

        /// <summary>
        /// 分页获取 PackingAccessoriesConfig 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="packingAccessoriesConfigCount">packingAccessoriesConfig 总数。</param>
        /// <returns>PackingAccessoriesConfig 列表。</returns>
        public List<PackingAccessoriesConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<PackingAccessoriesConfigInfo> list = new List<PackingAccessoriesConfigInfo>();
            //表名或者视图
            string strTb = "vwGetPackingAccessoriesConfigList";
            //主键
            string strKey = "PackingAccessoriesConfigId";
            //查询栏位字串
            string strColumns = @"PackingAccessoriesConfigId,AccessoriesName,AccessoriesQty,ItemCode,Station,MaskGroup,CreateBy,CreateDateTime,Sequence,CheckType,Remark,ModifyBy,ModifyDateTime";

            return ComMethod.GetComList<PackingAccessoriesConfigInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}
