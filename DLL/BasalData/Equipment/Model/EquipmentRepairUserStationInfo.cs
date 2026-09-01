using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// 设备维修人员工序信息表（维修人员对应的工序）
    /// </summary>
    [Serializable]
    public class EquipmentRepairUserStationInfo
    {
        /// <summary>
        /// 设备维修人员工序信息表Id
        /// </summary>
        public int EquipmentRepairStationId { get; set; }

        /// <summary>
        /// 维修人员Id（关联Prod_EquipmentRepairUser表EquipmentRepairUserId字段）
        /// </summary>
        public int? EquipmentRepairUserId { get; set; }

        /// <summary>
        /// 工序Id（关联Basal_Station表StationId）
        /// </summary>
        public int? StationId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }


        /// <summary>
        /// 工序
        /// </summary>
        public string Station { get; set; }

        /// <summary>
        /// 工序描述
        /// </summary>
        public string StationDesc { get; set; }

        /// <summary>
        /// 工序类型
        /// </summary>
        public string StationType { get; set; }
    }
}
