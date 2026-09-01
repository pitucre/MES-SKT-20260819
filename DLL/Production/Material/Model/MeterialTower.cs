using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// 料塔信息
    /// </summary>
    [Serializable]
    public class MeterialTower
    {
        /// <summary>
        /// 标识
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }
        /// <summary>
        /// 设备名称
        /// </summary>
        public string EquipmentName { get; set; }
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string WareHourseCode { get; set; }
        /// <summary>
        /// 仓库名称
        /// </summary>
        public string WareHourseName { get; set; }
        /// <summary>
        /// 设备接口IP地址
        /// </summary>
        public string IP { get; set; }
        /// <summary>
        /// 设备ApiKey
        /// </summary>
        public string ApiKey { get; set; }
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
