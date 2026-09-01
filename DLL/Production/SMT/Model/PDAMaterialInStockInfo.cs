using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.SMT.Model
{
    /// <summary>
    /// 物料生产入库
    /// </summary>
    public class PDAMaterialInStockInfo
    {
        public PDAMaterialInStockInfo()
        {
            this.ServerNo = "";
            this.LayerNo = 0;
            this.PositionNo = 0;
        }
        /// <summary>
        /// 自增ID
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 设备ID
        /// </summary>
        public int EquipmentId { get; set; }

        /// <summary>
        /// 设备编号
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 物料条码
        /// </summary>
        public string MaterialGRN { get; set; }

        /// <summary>
        /// 物料编码
        /// </summary>
        public string MaterialCode { get; set; }

        /// <summary>
        /// 物料编码可以数量
        /// </summary>
        public int MaterialQty { get; set; }

        /// <summary>
        /// 回调地址
        /// </summary>
        public string CallbackUrl { get; set; }

        /// <summary>
        /// 回调结果
        /// </summary>
        public string CallbackResult { get; set; }

        /// <summary>
        /// 服务号
        /// </summary>
        public string ServerNo { get; set; }

        /// <summary>
        /// 层号
        /// </summary>
        public int LayerNo { get; set; }

        /// <summary>
        /// 储位号
        /// </summary>
        public int PositionNo { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public int Status { get; set; }

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
    }
}

