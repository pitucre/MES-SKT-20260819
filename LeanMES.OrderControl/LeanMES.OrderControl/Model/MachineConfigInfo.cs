using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.OrderControl.Model
{
    /// <summary>
    /// 机台配置信息实体类
    /// </summary>
    [Serializable]
    public class MachineConfigInfo
    {
        /// <summary>
        /// 主键ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 机台编号
        /// </summary>
        public string MachineCode { get; set; }

        /// <summary>
        /// 设备类型: Engel/Haitian/Demag
        /// </summary>
        public string MachineType { get; set; }

        /// <summary>
        /// 机台名称
        /// </summary>
        public string MachineName { get; set; }

        /// <summary>
        /// 设备IP地址
        /// </summary>
        public string EquipmentIP { get; set; }

        /// <summary>
        /// 设备端口
        /// </summary>
        public string EquipmentPort { get; set; }

        /// <summary>
        /// EUROMAP 63路径 (恩格尔专用)
        /// </summary>
        public string Euromap63Path { get; set; }

        /// <summary>
        /// 是否启用控制
        /// </summary>
        public bool ControlEnabled { get; set; }

        /// <summary>
        /// 是否启用采集
        /// </summary>
        public bool CollectEnabled { get; set; }

        /// <summary>
        /// 采集间隔(秒)
        /// </summary>
        public int CollectInterval { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreatedDate { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifiedDate { get; set; }
    }
}
