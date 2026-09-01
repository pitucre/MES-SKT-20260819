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
    public class StationMateriel
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） StationMateriel 信息。
        /// </summary>
        /// <param name="entity">StationMateriel 实体对象。</param>
        public Int32 Edit(StationMaterielInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@StationMatId", SqlDbType.Int),
                new SqlParameter("@OrganizationCode", SqlDbType.VarChar, 50),
                new SqlParameter("@ItemCode", SqlDbType.VarChar, 30),
                new SqlParameter("@StationId", SqlDbType.Int),
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.StationMatId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrganizationCode;
            parms[2].Value = entity.ItemCode;
            parms[3].Value = entity.StationId;
            parms[4].Value = entity.State;
            parms[5].Value = entity.CreateBy;
            parms[6].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationMateriel_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 StationMaterielId 字符串删除 StationMateriel 信息。
        /// </summary>
        /// <param name="idString">StationMaterielId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Basal_StationMateriel_Delete", parms);
        }

        /// <summary>
        /// 根据 StationMaterielId 获取实体信息。
        /// </summary>
        /// <param name="stationMaterielId">StationMaterielId。</param>
        /// <returns>StationMateriel 实体对象。</returns>
        public StationMaterielInfo GetInfo(Int32 stationMaterielId)
        {
            return ComMethod.GetInfo<StationMaterielInfo>(stationMaterielId, "Basal_StationMateriel_GetInfo");  
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>StationMateriel 实体对象。</returns>
        public StationMaterielInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<StationMaterielInfo>(fieldValue, "Basal_StationMateriel_GetInfo");  
        }

        /// <summary>
        /// 分页获取 StationMateriel 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="stationMaterielCount">stationMateriel 总数。</param>
        /// <returns>StationMateriel 列表。</returns>
        public List<StationMaterielInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<StationMaterielInfo> list = new List<StationMaterielInfo>();

            //表名或者视图
            string strTb = "vwGetStationMatList";
            //主键
            string strKey = "StationMatId";
            //查询栏位字串
            string strColumns = @"StationMatId,Station,ItemCode,ItemName,CategoryOne,CategoryTwo,CategoryThree,CreateBy,CreateDateTime";

            return ComMethod.GetComList<StationMaterielInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);                        
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}