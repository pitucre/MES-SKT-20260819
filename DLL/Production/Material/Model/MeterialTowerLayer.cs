using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// 料塔层
    /// </summary>
    [Serializable]
    public class MeterialTowerLayer
    {
        /// <summary>
        /// 标识
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 设备编码
        /// </summary>
        public string MeterialTowerNo { get; set; }
        /// <summary>
        /// 层码
        /// </summary>
        public int LayerNo { get; set; }
        /// <summary>
        /// 电机组
        /// </summary>
        public int MotorNo { get; set; }
        /// <summary>
        /// 存储量
        /// </summary>
        public int StorageQuantity { get; set; }
        /// <summary>
        /// 存储大小
        /// </summary>
        public int StorageSize { get; set; }
        /// <summary>
        /// 优先顺序
        /// </summary>
        public int OrderLevel { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }
    }
}
