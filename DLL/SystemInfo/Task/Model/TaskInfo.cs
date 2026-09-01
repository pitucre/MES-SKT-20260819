using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Task.Model
{
    /// <summary>
    /// 任务信息表
    /// </summary>
    [Serializable]
    public class TaskInfo
    {
        /// <summary>
        /// 任务Id（主键）
        /// </summary>
        public int TaskId { get; set; }

        /// <summary>
        /// 任务名称
        /// </summary>
        public string TaskName { get; set; }

        /// <summary>
        /// 任务描述
        /// </summary>
        public string TaskDesc { get; set; }

        /// <summary>
        /// 执行的DLL
        /// </summary>
        public string ExecDll { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        public DateTime? StartTime { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 间隔时间
        /// </summary>
        public int? IntervalTime { get; set; }

        /// <summary>
        /// 上次执行时间
        /// </summary>
        public DateTime? LastExecTime { get; set; }

        /// <summary>
        /// 上次执行结果
        /// </summary>
        public int? LastExecResult { get; set; }

        /// <summary>
        /// 下次执行时间
        /// </summary>
        public DateTime? NextExecTime { get; set; }

        /// <summary>
        /// 执行次数
        /// </summary>
        public int? ExecQty { get; set; }

        /// <summary>
        /// 执行成功次数
        /// </summary>
        public int? ExecSuccessQty { get; set; }

        /// <summary>
        /// 执行失败次数
        /// </summary>
        public int? ExecErrorQty { get; set; }

        /// <summary>
        /// 是否启用（0：否 1：是）
        /// </summary>
        public int? EnableFlag { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }

        /// <summary>
        /// 触发器（1：每天 2：每周）
        /// </summary>
        public int? Trigger { get; set; }

        /// <summary>
        /// 触发器值
        /// </summary>
        public string Trigger_Value { get; set; }


        /// <summary>
        /// 上次执行结果名称
        /// </summary>
        public string LastExecResultName { get; set; }
    }
}
