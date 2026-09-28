using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.OrderControl.Model
{
    /// <summary>
    /// 订单控制信息实体类 - 与MES系统集成
    /// </summary>
    [Serializable]
    public class OrderControlInfo
    {
        /// <summary>
        /// 主键ID (OrderControl表)
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 机台编号 (如: 212352)
        /// </summary>
        public string MachineCode { get; set; }

        /// <summary>
        /// 设备类型: Engel/Haitian/Demag
        /// </summary>
        public string MachineType { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 产品编号
        /// </summary>
        public string PartNumber { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string PartName { get; set; }

        /// <summary>
        /// 订单数量
        /// </summary>
        public int OrderQuantity { get; set; }

        /// <summary>
        /// 已完成数量
        /// </summary>
        public int CompletedQuantity { get; set; }

        /// <summary>
        /// 良品数量
        /// </summary>
        public int GoodQuantity { get; set; }

        /// <summary>
        /// 不良品数量
        /// </summary>
        public int RejectQuantity { get; set; }

        /// <summary>
        /// 状态: 0=待生产, 1=生产中, 2=已完成, 3=已暂停, 4=已取消
        /// </summary>
        public int Status { get; set; }

        /// <summary>
        /// 是否启用自动控制
        /// </summary>
        public bool ControlEnabled { get; set; }

        /// <summary>
        /// 是否达到目标数量
        /// </summary>
        public bool TargetReached { get; set; }

        /// <summary>
        /// 是否已发送停止命令
        /// </summary>
        public bool StopCommandSent { get; set; }

        /// <summary>
        /// 开始生产时间
        /// </summary>
        public DateTime? StartTime { get; set; }

        /// <summary>
        /// 结束生产时间
        /// </summary>
        public DateTime? EndTime { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreatedDate { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifiedDate { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        // ========== MES系统相关字段 ==========

        /// <summary>
        /// 设备IP地址 (从MachineConfig或MES设备表)
        /// </summary>
        public string EquipmentIP { get; set; }

        /// <summary>
        /// 设备端口 (从MachineConfig或MES设备表)
        /// </summary>
        public string EquipmentPort { get; set; }

        /// <summary>
        /// EUROMAP 63路径 (从MachineConfig, 恩格尔专用)
        /// </summary>
        public string Euromap63Path { get; set; }

        /// <summary>
        /// 工单状态 (来自ERP_Prod_Order.Status)
        /// </summary>
        public int OrderStatus { get; set; }

        /// <summary>
        /// 设备名称 (来自Basal_Equipment.EquipmentName)
        /// </summary>
        public string EquipmentName { get; set; }

        /// <summary>
        /// 设备类型编码 (来自Basal_Equipment.EquipmentTypeCode)
        /// </summary>
        public string EquipmentTypeCode { get; set; }

        /// <summary>
        /// 设备品牌 (来自Basal_Equipment.Brand)
        /// </summary>
        public string MachineBrand { get; set; }

        /// <summary>
        /// 设备状态 (来自Basal_Equipment.Status)
        /// </summary>
        public int? EquipmentStatus { get; set; }

        /// <summary>
        /// 计划开始时间 (来自ERP_Prod_Order.Planned_Start_Time)
        /// </summary>
        public DateTime? Planned_Start_Time { get; set; }

        /// <summary>
        /// 计划完成时间 (来自ERP_Prod_Order.Planned_Completed_Date)
        /// </summary>
        public DateTime? Planned_Completed_Date { get; set; }

        // ========== 计算属性 ==========

        /// <summary>
        /// 获取完成百分比
        /// </summary>
        public double CompletionPercentage
        {
            get
            {
                if (OrderQuantity <= 0) return 0;
                return (double)CompletedQuantity / OrderQuantity * 100;
            }
        }

        /// <summary>
        /// 获取状态描述
        /// </summary>
        public string StatusDescription
        {
            get
            {
                switch (Status)
                {
                    case 0: return "待生产";
                    case 1: return "生产中";
                    case 2: return "已完成";
                    case 3: return "已暂停";
                    case 4: return "已取消";
                    default: return "未知";
                }
            }
        }

        /// <summary>
        /// 获取设备类型图标
        /// </summary>
        public string MachineTypeIcon
        {
            get
            {
                switch (MachineType?.ToUpper())
                {
                    case "ENGEL": return "🔧";
                    case "HAITIAN": return "🏭";
                    case "DEMAG": return "⚙️";
                    default: return "❓";
                }
            }
        }
    }
}
