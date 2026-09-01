using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class ProdBatchSNNcDataInfo
    {
        /// <summary>
        /// 主键ID
        /// </summary>
        public int ID { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNo { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// SN
        /// </summary>
        public string SN { get; set; }

        /// <summary>
        /// 线别ID
        /// </summary>
        public int? LineID { get; set; }

        /// <summary>
        /// 工序ID
        /// </summary>
        public int? StationID { get; set; }

        /// <summary>
        /// 资源ID
        /// </summary>
        public int? ResourceID { get; set; }

        /// <summary>
        /// 不良类型ID
        /// </summary>
        public int? NCGroupID { get; set; }

        /// <summary>
        /// 不良代码
        /// </summary>
        public string NCCode { get; set; }

        /// <summary>
        /// 不良数量
        /// </summary>
        public decimal? NGQty { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 操作人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 操作时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 批次送修生成SN
        /// </summary>
        public string SendRepairSN { get; set; }

        /// <summary>
        /// 批次送修生成SN
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 批次送修生成SN
        /// </summary>
        public string StationName { get; set; }
    }
}