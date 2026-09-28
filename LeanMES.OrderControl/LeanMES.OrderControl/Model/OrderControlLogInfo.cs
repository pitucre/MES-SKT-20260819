using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.OrderControl.Model
{
    /// <summary>
    /// 订单控制日志实体类
    /// </summary>
    [Serializable]
    public class OrderControlLogInfo
    {
        /// <summary>
        /// 主键ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 关联订单ID
        /// </summary>
        public int OrderControlID { get; set; }

        /// <summary>
        /// 机台编号
        /// </summary>
        public string MachineCode { get; set; }

        /// <summary>
        /// 日志类型: INFO/WARNING/ERROR/COMMAND
        /// </summary>
        public string LogType { get; set; }

        /// <summary>
        /// 日志内容
        /// </summary>
        public string Message { get; set; }

        /// <summary>
        /// 当时的生产数量
        /// </summary>
        public int? CurrentQuantity { get; set; }

        /// <summary>
        /// 目标数量
        /// </summary>
        public int? TargetQuantity { get; set; }

        /// <summary>
        /// 发送的命令内容
        /// </summary>
        public string CommandSent { get; set; }

        /// <summary>
        /// 命令执行结果
        /// </summary>
        public string CommandResult { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreatedDate { get; set; }
    }
}
