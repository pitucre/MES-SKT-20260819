using System;

namespace SKT.LeanMES.Warehouse.Model
{
    public class WarehouseAGVMarkInfo
    {
        /// <summary>
        /// AGV地标码
        /// </summary>
        public string AGVLandMarkCode { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 状态值
        /// </summary>
        public int? Statues { get; set; }

        /// <summary>
        /// ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 地标码顺序
        /// </summary>
        public string AGVLandMarkCodeSort { get; set; }

        /// <summary>
        /// 是否AGV发货位
        /// </summary>
        public bool AGVDeliveryLocation { get; set; }

        /// <summary>
        /// 是否AGV发料位
        /// </summary>
        public bool AGVMaterialLocation { get; set; }

        /// <summary>
        /// 状态名称
        /// </summary>
        public string StatueName { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// AGV区域名称
        /// </summary>
        public string AGVAreaName { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 巷道顺序
        /// </summary>
        public int LaneSort { get; set; }
    }
}
