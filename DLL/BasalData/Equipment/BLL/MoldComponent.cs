using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Equipment.Model;

namespace SKT.LeanMES.Equipment.BLL
{
    public class MoldComponent
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） Msl 信息。
        /// </summary>
        /// <param name="entity">Msl 实体对象。</param>
        public Int32 Edit(MoldComponentInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MoldComponentId", SqlDbType.Int),
                new SqlParameter("@ComponentName", SqlDbType.VarChar),
                new SqlParameter("@SafeStock", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.VarChar),
                new SqlParameter("@UserName", SqlDbType.VarChar)                
            };

            parms[0].Value = entity.MoldComponentId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ComponentName;
            parms[2].Value = entity.SafeStock;
            parms[3].Value = entity.Remark;
            parms[4].Value = entity.CreateBy;
          
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspEditMoldComponent", parms);

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

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspDeleteMoldComponent", parms);
        }

        /// <summary>
        /// 根据 MslId 获取实体信息。
        /// </summary>
        /// <param name="mslId">MslId。</param>
        /// <returns>Msl 实体对象。</returns>
        public MoldComponentInfo GetInfo(Int32 mslId)
        {
            return ComMethod.GetInfo<MoldComponentInfo>(mslId, "uspGetMoldComponent");
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>Msl 实体对象。</returns>
        public MoldComponentInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<MoldComponentInfo>(fieldValue, "uspGetMoldComponent");
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
        public List<MoldComponentInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoldComponentInfo> list = new List<MoldComponentInfo>();
            //表名或者视图
            string strTb = "VWBasalMoldComponent";
            //主键
            string strKey = "MoldComponentId";
            //查询栏位字串
            string strColumns = @"[MoldComponentId],[SafeStock], [ComponentName], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]";

            return ComMethod.GetComList<MoldComponentInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
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
        public List<MoldComponentInfo> GetMoldComponentStock(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<MoldComponentInfo> list = new List<MoldComponentInfo>();
            //表名或者视图
            string strTb = "vwGetMoldComponentStock";
            //主键
            string strKey = "MoldComponentId";
            //查询栏位字串
            string strColumns = @"[MoldComponentId], [ComponentName], [InStock], [OutStock], [TotalStock]";

            return ComMethod.GetComList<MoldComponentInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
