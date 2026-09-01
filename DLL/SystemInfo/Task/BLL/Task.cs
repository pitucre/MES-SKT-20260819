using SKT.Common.DAL.Marshal;
using SKT.Common.Model;
using SKT.LeanMES.CommonHelper.BLL;
using SKT.LeanMES.Task.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Task.BLL
{
    public class Task
    {
        private Int32 recordCount = 0;

        /// <summary>
        /// 获取任务列表
        /// </summary>
        /// <param name="startRow"></param>
        /// <param name="maxRows"></param>
        /// <param name="sortExpression"></param>
        /// <param name="searchSettings"></param>
        /// <returns></returns>
        public List<TaskInfo> GetTaskList(Int32 startRow, Int32 maxRows, String sortExpression, SearchSettings searchSettings)
        {
            //表名或者视图
            string strTb = "vwGetTask";
            //主键
            string strKey = "TaskId";
            //查询栏位字串
            string strColumns = @"TaskId,TaskName,TaskDesc,ExecDll,StartTime,EndTime,IntervalTime,LastExecTime,LastExecResult,NextExecTime,ExecQty,ExecSuccessQty,ExecErrorQty,EnableFlag,CreateBy,CreateTime,ModifyBy,ModifyTime,
                                  LastExecResultName,[Trigger],Trigger_Value";
            return ComMethod.GetComList<TaskInfo>(ref recordCount, startRow, maxRows, strTb, strKey, strColumns, sortExpression, searchSettings);
        }

        /// <summary>
        /// 获取任务信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public TaskInfo GetTaskInfo(TaskInfo entity)
        {

            //表名或者视图
            var sql = @"SELECT 
                            TaskId,TaskName,TaskDesc,ExecDll,StartTime,EndTime,IntervalTime,LastExecTime,LastExecResult,NextExecTime,ExecQty,ExecSuccessQty,ExecErrorQty,EnableFlag,CreateBy,CreateTime,ModifyBy,ModifyTime,
                            LastExecResultName,[Trigger],Trigger_Value
                        FROM vwGetTask
                        WHERE TaskId = @TaskId";
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@TaskId",SqlDbType.Int)
            };
            parms[0].Value = entity.TaskId;
            return ComMethod.GetBySql<TaskInfo>(sql, parms);
        }

        /// <summary>
        /// 编辑任务
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public void EditTask(TaskInfo entity)
        {
            SqlParameter[] parms = new SqlParameter[]
            {
                new SqlParameter("@TaskId", SqlDbType.Int) { Value = entity.TaskId },
                new SqlParameter("@TaskName", SqlDbType.NVarChar, 100) { Value = entity.TaskName },
                new SqlParameter("@TaskDesc", SqlDbType.NVarChar, 1000) { Value = entity.TaskDesc },
                new SqlParameter("@ExecDll", SqlDbType.VarChar, 200) { Value = entity.ExecDll },
                new SqlParameter("@StartTime", SqlDbType.DateTime) { Value = entity.StartTime },
                new SqlParameter("@EndTime", SqlDbType.DateTime) { Value = entity.EndTime },
                new SqlParameter("@IntervalTime", SqlDbType.Int) { Value = entity.IntervalTime },
                new SqlParameter("@ModifyBy", SqlDbType.VarChar, 20) { Value = entity.ModifyBy },
                new SqlParameter("@Trigger", SqlDbType.Int) { Value = entity.Trigger },
                new SqlParameter("@Trigger_Value", SqlDbType.VarChar, 200) { Value = entity.Trigger_Value },
            };
            SQLHelper.ExecuteNonQueryStoredProcedure(SQLHelper.MESConnString, "uspTaskEdit", parms);
        }


        /// <summary>
        /// 获取任务信息
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public void DeleteTask(TaskInfo entity)
        {

            //表名或者视图
            var sql = @"DELETE FROM dbo.Sys_Task WHERE TaskId = @TaskId";
            SqlParameter[] parms = new SqlParameter[] {
                  new SqlParameter("@TaskId",SqlDbType.Int)
            };
            parms[0].Value = entity.TaskId;
            SQLHelper.ExecuteNonQueryText(SQLHelper.MESConnString, sql, parms);
        }

        public Int32 GetCount(SearchSettings searchSettings)
        {
            return this.recordCount;
        }
    }
}
