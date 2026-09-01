using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.MSD.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.MSD.BLL
{
    public class Msl
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Msl 信息。
        /// </summary>
        /// <param name="entity">Msl 实体对象。</param>
        public Int32 Edit(MslInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MslId", SqlDbType.Int),
                new SqlParameter("@OrganizationCode", SqlDbType.VarChar, 50),
                new SqlParameter("@MSL", SqlDbType.VarChar, 20),
                new SqlParameter("@FloorLife", SqlDbType.Int),
                new SqlParameter("@ShelfLife", SqlDbType.Int),
                new SqlParameter("@BakeCount", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.MslId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.OrganizationCode;
            parms[2].Value = entity.MSL;
            parms[3].Value = entity.FloorLife;
            parms[4].Value = entity.ShelfLife;
            parms[5].Value = entity.BakeCount;
            parms[6].Value = entity.CreateBy;
            parms[7].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Msl_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MslId 字符串删除 Msl 信息。
        /// </summary>
        /// <param name="idString">MslId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_Msl_Delete", parms);
        }

        /// <summary>
        /// 根据 MslId 获取实体信息。
        /// </summary>
        /// <param name="mslId">MslId。</param>
        /// <returns>Msl 实体对象。</returns>
        public MslInfo GetInfo(Int32 mslId)
        {
            return ComMethod.GetInfo<MslInfo>(mslId, "Prod_Msl_GetInfo"); 
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Msl 实体对象。</returns>
        public MslInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<MslInfo>(fieldValue, "Prod_Msl_GetInfo");            
        }

        /// <summary>
        /// 分页获取 Msl 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="mslCount">msl 总数。</param>
        /// <returns>Msl 列表。</returns>
        public List<MslInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MslInfo> list = new List<MslInfo>();
            //表名或者视图
            string strTb = "vwProd_Msl";////Prod_Msl
            //主键
            string strKey = "MslId";
            //查询栏位字串
            string strColumns = @"[MslId], [OrganizationCode], [MSL], [FloorLife], [ShelfLife], [BakeCount], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]";

            return ComMethod.GetComList<MslInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);           
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}