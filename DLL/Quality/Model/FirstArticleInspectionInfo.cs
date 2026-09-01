using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    /// <summary>
    /// 首件检验推送信息表
    /// </summary>
    public class FirstArticleInspectionInfo
    {
        /// <summary>
        /// 首件检验推送信息表Id
        /// </summary>
        public int FirstArticleInspectionId { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 首件检验单号
        /// </summary>
        public string InspectionNo { get; set; }

        /// <summary>
        /// 状态（0：待检验 1：已检验）
        /// </summary>
        public int? Status { get; set; }

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



        #region 扩展字段

        /// <summary>
        /// 状态（0：待检验 1：已检验）
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// 工单数量
        /// </summary>
        public int Qty_to_Build { get; set; }

        #endregion


    }
}
