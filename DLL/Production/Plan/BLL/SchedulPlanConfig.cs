using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Plan.Model;

namespace SKT.LeanMES.Plan.BLL
{
  public class SchedulPlanConfig
    {
        private Int32 recordCount = 0;
        /// <summary>
        /// 编辑（添加或更新） PlanType 信息。
        /// </summary>
        /// <param name="entity">PlanType 实体对象。</param>
        public Int32 Edit(SchedulPlanConfigInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@Pid", SqlDbType.Int),
                new SqlParameter("@Name", SqlDbType.VarChar, 10),
                new SqlParameter("@CreateBy", SqlDbType.VarChar, 20),
                new SqlParameter("@IsEnable", SqlDbType.Int, 4),
                new SqlParameter("@Remark", SqlDbType.NVarChar, 50),
                new SqlParameter("@PlanTimeDetails", SqlDbType.NVarChar)
            };

            parms[0].Value = entity.Pid;
            parms[0].Direction = ParameterDirection.InputOutput;
            parms[1].Value = entity.Name;
            parms[2].Value = entity.CreateBy;
            parms[3].Value = entity.IsEnable;
            parms[4].Value = entity.Remark;
            parms[5].Value = entity.PlanTimeDetials;


            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Prod_PlanConfig_Edit", parms);

            return (Int32)parms[0].Value;
        }
        /// <summary>
        /// 根据 ConfigId 获取实体信息。
        /// </summary>
        /// <param name="pId">ConfigId。</param>
        /// <returns>Config 实体对象。</returns>
        public SchedulPlanConfigInfo GetInfo(Int32 pId)
        {
            SchedulPlanConfigInfo entity = null;

            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@FieldValue", SqlDbType.NVarChar, 50),
                new SqlParameter("@IsByID", SqlDbType.Bit)
            };

            parms[0].Value = pId;
            parms[1].Value = true;

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Basal_PlanConfig_GetInfo", parms))
            {
                if (rdr.Read())
                {
                    entity = new SchedulPlanConfigInfo();
                    entity.Pid = Convert.ToInt32(rdr["Pid"]);
                    entity.Name = rdr["Name"].ToString();
                    entity.IsEnable = Convert.ToByte(rdr["IsEnable"]);
                    entity.Remark = rdr["Remark"].ToString();
                }
                rdr.Close();
            }

            return entity;
        }

        /// <summary>
        /// 分页获取  资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="planCount">plan 总数。</param>
        /// <returns>Plan 列表。</returns>
        public List<SchedulPlanConfigInfo> GetAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulPlanConfigInfo> list = new List<SchedulPlanConfigInfo>();
            SchedulPlanConfigInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "VwSys_PlanConfig", "Pid",
                "Pid,Name,Remark,IsEnable,CreateBy,CreateTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulPlanConfigInfo();
                    entity.Pid = Convert.ToInt32(rdr["Pid"]);
                    entity.Name = Convert.ToString(rdr["Name"]);
                    entity.Remark = Convert.ToString(rdr["Remark"]);
                    entity.IsEnable = Convert.ToInt32(rdr["IsEnable"]);
                    entity.CreateTime = Convert.ToDateTime(rdr["CreateTime"]);
                    entity.CreateBy = Convert.ToString(rdr["CreateBy"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }

        /// <summary>
        //删除信息。
        /// </summary>
        /// <param name="idString"> 字符串。</param>
        /// <returns>日志内容。</returns>
        public void Delete(String idString, String userName)
        {
            SqlParameter[] parms = new SqlParameter[]{
                new SqlParameter("@IdString", SqlDbType.VarChar, 1000),
                new SqlParameter("@UserName", SqlDbType.VarChar, 20)
            };

            parms[0].Value = idString;
            parms[1].Value = userName;

            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "Plan_PlanConfig_Delete", parms);
        }

        /// <summary>
        /// 分页获取  资料。
        /// </summary>
        /// <param name="startRow">起始行。</param>
        /// <param name="maxRows">最大行数。</param>
        /// <param name="sortExpression">排序表达式。</param>
        /// <param name="searchSettings">搜索配置信息。</param>
        /// <param name="planCount">plan 总数。</param>
        /// <returns>Plan 列表。</returns>
        public List<SchedulPlanConfigDetailInfo> GetDetailAll(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            List<SchedulPlanConfigDetailInfo> list = new List<SchedulPlanConfigDetailInfo>();
            SchedulPlanConfigDetailInfo entity = null;

            SqlParameter[] parms = SQLHelper.CreateCommonPagingStoredProcedureParameters(startRow, maxRows, "Sys_PlanConfigDetail", "PdId",
                "PdId,pid,PlanTime", searchSettings, sortExpression);

            using (SqlDataReader rdr = SQLHelper.ExecuteReaderStoredProcedure(SQLHelper.MESConnString, "Common_GetPageRecords", parms))
            {
                while (rdr.Read())
                {
                    entity = new SchedulPlanConfigDetailInfo();
                    entity.PdId = Convert.ToInt32(rdr["PdId"]);
                    entity.Pid = Convert.ToInt32(rdr["Pid"]);
                    entity.PlanTime = Convert.ToString(rdr["PlanTime"]);
                    list.Add(entity);
                }
                rdr.Close();
            }

            recordCount = Convert.ToInt32(parms[parms.Length - 1].Value);
            return list;
        }


        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
