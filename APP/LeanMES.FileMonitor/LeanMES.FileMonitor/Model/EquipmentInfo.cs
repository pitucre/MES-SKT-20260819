using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LeanMES.FileMonitor.Model
{
    [Serializable]
    public class EquipmentInfo
    {
        /// <summary>
        /// 设备IP
        /// </summary>
        public string EquipmentIP { get; set; }

        /// <summary>
        /// 设备端口
        /// </summary>
        public string EquipmentPort { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode {  get; set; }
    }
}
