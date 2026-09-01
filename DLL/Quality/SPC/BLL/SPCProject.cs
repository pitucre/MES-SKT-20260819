using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.SPC.Model;
using SKT.LeanMES.CommonHelper.BLL;

namespace SKT.LeanMES.SPC.BLL
{
    public class SPCProject
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） SPCProject 信息。
        /// </summary>
        /// <param name="entity">SPCProject 实体对象。</param>
        public Int32 Edit(SPCProjectInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@SPCProjectId", SqlDbType.Int),
                new SqlParameter("@ProjectName", SqlDbType.NVarChar, 50),
                new SqlParameter("@ProjectDesc", SqlDbType.NVarChar, 100),
                new SqlParameter("@GraphType", SqlDbType.VarChar, 50),
                new SqlParameter("@SampleQty", SqlDbType.Int),
                new SqlParameter("@GroupQty", SqlDbType.Int),
                new SqlParameter("@SampleDecimalPoint", SqlDbType.Int),
                new SqlParameter("@IsShowCP", SqlDbType.Bit),
                new SqlParameter("@IsShowCPK", SqlDbType.Bit),
                new SqlParameter("@IsShowPP", SqlDbType.Bit),
                new SqlParameter("@IsShowPPK", SqlDbType.Bit),
                new SqlParameter("@NCGroupId", SqlDbType.Int),
                new SqlParameter("@NCCodeIdA", SqlDbType.Int),
                new SqlParameter("@NCCodeIdB", SqlDbType.Int),
                new SqlParameter("@NCCodeIdC", SqlDbType.Int),
                new SqlParameter("@NCCodeIdD", SqlDbType.Int),
                new SqlParameter("@NCCodeIdE", SqlDbType.Int),
                new SqlParameter("@IsWarnA", SqlDbType.Bit),
                new SqlParameter("@IsWarnB", SqlDbType.Bit),
                new SqlParameter("@IsWarnC", SqlDbType.Bit),
                new SqlParameter("@WarnCVal", SqlDbType.Int),
                new SqlParameter("@IsWarnD", SqlDbType.Bit),
                new SqlParameter("@WarnDVal", SqlDbType.Int),
                new SqlParameter("@IsWarnE", SqlDbType.Bit),
                new SqlParameter("@WarnEVal", SqlDbType.Int),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20)
            };

            parms[0].Value = entity.SPCProjectId;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.ProjectName;
            parms[2].Value = entity.ProjectDesc;
            parms[3].Value = entity.GraphType;
            parms[4].Value = entity.SampleQty;
            parms[5].Value = entity.GroupQty;
            parms[6].Value = entity.SampleDecimalPoint;
            parms[7].Value = entity.IsShowCP;
            parms[8].Value = entity.IsShowCPK;
            parms[9].Value = entity.IsShowPP;
            parms[10].Value = entity.IsShowPPK;
            parms[11].Value = entity.NCGroupId;
            parms[12].Value = entity.NCCodeIdA;
            parms[13].Value = entity.NCCodeIdB;
            parms[14].Value = entity.NCCodeIdC;
            parms[15].Value = entity.NCCodeIdD;
            parms[16].Value = entity.NCCodeIdE;
            parms[17].Value = entity.IsWarnA;
            parms[18].Value = entity.IsWarnB;
            parms[19].Value = entity.IsWarnC;
            parms[20].Value = entity.WarnCVal;
            parms[21].Value = entity.IsWarnD;
            parms[22].Value = entity.WarnDVal;
            parms[23].Value = entity.IsWarnE;
            parms[24].Value = entity.WarnEVal;
            parms[25].Value = entity.CreateBy;
            parms[26].Value = entity.ModifyBy;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCProject_Edit", parms);

            return (Int32)parms[0].Value;
        }

        /// <summary>
        /// 根据 SPCProjectId 字符串删除 SPCProject 信息。
        /// </summary>
        /// <param name="idString">SPCProjectId 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Quality_SPCProject_Delete", parms);
        }

        /// <summary>
        /// 根据 SPCProjectId 获取实体信息。
        /// </summary>
        /// <param name="sPCProjectId">SPCProjectId。</param>
        /// <returns>SPCProject 实体对象。</returns>
        public SPCProjectInfo GetInfo(Int32 sPCProjectId)
        {
            return ComMethod.GetInfo<SPCProjectInfo>(sPCProjectId, "Quality_SPCProject_GetInfo");  
        }

        /// <summary>
        /// 根据 字段值 获取实体信息。
        /// </summary>
        /// <param name="fieldValue">字段值。</param>
        /// <returns>SPCProject 实体对象。</returns>
        public SPCProjectInfo GetInfo(String fieldValue)
        {
            return ComMethod.GetInfo<SPCProjectInfo>(fieldValue, "Quality_SPCProject_GetInfo");  
        }

        /// <summary>
        /// 分页获取 SPCProject 资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="sPCProjectCount">sPCProject 总数。</param>
        /// <returns>SPCProject 列表。</returns>
        public List<SPCProjectInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {            
            List<SPCProjectInfo> list = new List<SPCProjectInfo>();
            //表名或者视图
            string strTb = "Quality_SPCProject";
            //主键
            string strKey = "SPCProjectId";
            //查询栏位字串
            string strColumns = @"[SPCProjectId], [ProjectName], [ProjectDesc], [GraphType], [SampleQty], [GroupQty], [SampleDecimalPoint], [IsShowCP], [IsShowCPK], [IsShowPP], [IsShowPPK], [NCGroupId], [NCCodeIdA], [NCCodeIdB], [NCCodeIdC], [NCCodeIdD], [NCCodeIdE], [IsWarnA], [IsWarnB], [IsWarnC], [WarnCVal], [IsWarnD], [WarnDVal], [IsWarnE], [WarnEVal], [CreateBy], [CreateDateTime], [ModifyBy], [ModifyDateTime]";

            return ComMethod.GetComList<SPCProjectInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);           
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }

    }
}