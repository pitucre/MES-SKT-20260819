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
    public class MsdContainer
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） MsdContainer 信息。
        /// </summary>
        /// <param name="entity">MsdContainer 实体对象。</param>
        public Int32 Edit(MsdContainerInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@MsdContainerId", SqlDbType.Int),
                new SqlParameter("@ContainerType", SqlDbType.Int),
                new SqlParameter("@ContainerCode", SqlDbType.VarChar),
                new SqlParameter("@MaxTemp", SqlDbType.Decimal),
                new SqlParameter("@MinTemp", SqlDbType.Decimal),
                new SqlParameter("@MaxQty", SqlDbType.Int),
                new SqlParameter("@State", SqlDbType.Int),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 100),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ContainerName", SqlDbType.NVarChar)
            };

            parms[0].Value = entity.MsdContainerId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ContainerType;
            parms[2].Value = entity.ContainerCode;
            parms[3].Value = entity.MaxTemp;
            parms[4].Value = entity.MinTemp;
            parms[5].Value = entity.MaxQty;
            parms[6].Value = entity.State;
            parms[7].Value = entity.Remark;
            parms[8].Value = entity.CreateBy;
            parms[9].Value = entity.ModifyBy;
            parms[10].Value = entity.ContainerName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MsdContainer_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 MsdContainerId 字符串删除 MsdContainer 信息。
        /// </summary>
        /// <param name="idString">MsdContainerId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_MsdContainer_Delete", parms);
        }

        /// <summary>
        /// 根据 MsdContainerId 获取实体信息。
        /// </summary>
        /// <param name="msdContainerId">MsdContainerId。</param>
        /// <returns>MsdContainer 实体对象。</returns>
        public MsdContainerInfo GetInfo(Int32 msdContainerId)
        {
            return ComMethod.GetInfo<MsdContainerInfo>(msdContainerId, "Prod_MsdContainer_GetInfo"); 
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>MsdContainer 实体对象。</returns>
        public MsdContainerInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<MsdContainerInfo>(fieldValue, "Prod_MsdContainer_GetInfo");             
        }

        /// <summary>
        /// 分页获取 MsdContainer 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="msdContainerCount">msdContainer 总数。</param>
        /// <returns>MsdContainer 列表。</returns>
        public List<MsdContainerInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
             List<MsdContainerInfo> list = new List<MsdContainerInfo>();
            //表名或者视图
            string strTb = "vWGetMsdContainer";
            //主键
            string strKey = "MsdContainerId";
            //查询栏位字串
            string strColumns = @"[MsdContainerId], [ContainerType],[ContainerName], [ContainerCode], [MaxTemp], [MinTemp], [MaxQty], [State], [Remark], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime],[UseQty]";

            return ComMethod.GetComList<MsdContainerInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);           
        }            

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}