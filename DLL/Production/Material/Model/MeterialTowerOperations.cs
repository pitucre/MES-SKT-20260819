using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// 料塔操作
    /// </summary>
    [Serializable]
    public class MeterialTowerOperations
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
        public int? LayerNo { get; set; }
        /// <summary>
        /// 储位号
        /// </summary>
        public int? PositionNo { get; set; }
        /// <summary>
        /// 操作类型
        /// </summary>
        public int OprateType { get; set; }
        /// <summary>
        /// 状态
        /// </summary>
        public int Status { get; set; }
        /// <summary>
        /// 是否完成操作【0：未完成；1：已完成】
        /// </summary>
        public int IsFinished { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
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
