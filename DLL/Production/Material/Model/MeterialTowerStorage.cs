using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// 
    /// </summary>
    [Serializable]
    public class MeterialTowerStorage
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
        /// 储位号
        /// </summary>
        public int StorageNo { get; set; }
    }
}
