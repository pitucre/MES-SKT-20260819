using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    public class TowerGRNInfo
    {
        /// <summary>
        /// 料塔-GRN信息表Id
        /// </summary>
        public int TowerGRNId { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// GRN
        /// </summary>
        public string GRN { get; set; }

        /// <summary>
        /// 层码
        /// </summary>
        public string LayerNo { get; set; }

        /// <summary>
        /// 位号
        /// </summary>
        public string PositionNo { get; set; }

        /// <summary>
        /// 库位条码
        /// </summary>
        public string cBarCode { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 状态（0：待存料 1：在库 2：待取出 3：取出）
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string Msg { get; set; }

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
        /// 料塔IP地址
        /// </summary>
        public string EquipmentIP { get; set; }

        /// <summary>
        /// 料塔端口号
        /// </summary>
        public string EquipmentPort { get; set; }
    }
}