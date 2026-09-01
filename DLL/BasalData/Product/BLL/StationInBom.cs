using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.Product.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.Product.BLL
{
    public class StationInBom
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationInBom 信息。
        /// </summary>
        /// <param name="entity">StationInBom 实体对象。</param>
        public Int32 Edit(StationInBomInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationInBomId", SqlDbType.Int),
                new SqlParameter("@OrganizationCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemBomId", SqlDbType.Int),
                new SqlParameter("@ItemBomChildId", SqlDbType.Int),
                new SqlParameter("@StationId", SqlDbType.Int),               
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                 new SqlParameter("@DataTypeId", SqlDbType.Int)
            };

            parms[0].Value = entity.StationInBomId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrganizationCode;
            parms[2].Value = entity.ItemBomId;
            parms[3].Value = entity.ItemBomChildId;
            parms[4].Value = entity.StationId;
            parms[5].Value = entity.State;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;
            parms[8].Value = entity.DataTypeId ;
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationInBom_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 StationInBomId 字符串删除 StationInBom 信息。
        /// </summary>
        /// <param name="idString">StationInBomId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationInBom_Delete", parms);
        }

        /// <summary>
        /// 根据 StationInBomId 获取实体信息。
        /// </summary>
        /// <param name="stationInBomId">StationInBomId。</param>
        /// <returns>StationInBom 实体对象。</returns>
        public StationInBomInfo GetInfo(Int32 stationInBomId)
        {
            return ComMethod.GetInfo<StationInBomInfo>(stationInBomId, "Basal_StationInBom_GetInfo");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationInBom 实体对象。</returns>
        public StationInBomInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<StationInBomInfo>(fieldValue, "Basal_StationInBom_GetInfo");
        }

        /// <summary>
        /// 分页获取 StationInBom 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationInBomCount">stationInBom 总数。</param>
        /// <returns>StationInBom 列表。</returns>
        public List<StationInBomInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationInBomInfo> list = new List<StationInBomInfo>();          

            //表名或者视图
            string strTb = "vwGetStationBomMatList";
            //主键
            string strKey = "StationInBomId";
            //查询栏位字串
            string strColumns = @"StationInBomId, Station, ItemCode, ItemName, BomName, CreateBy, CreateDateTime,ModifyBy,ModifyDateTime";

            return ComMethod.GetComList<StationInBomInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);                        
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}