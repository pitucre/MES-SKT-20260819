using System;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// 检验SN信息表
    /// </summary>
    [Serializable]
    public class InspectionOrderSNInfo
    {
        /// <summary>
        /// 检验SN Id
        /// </summary>
        public int InspectionOrderSNId { get; set; }

        /// <summary>
        /// 检验单Id
        /// </summary>
        public int? InspectionOrderId { get; set; }

        /// <summary>
        /// 检验单号
        /// </summary>
        public string InspectionNo { get; set; }

        /// <summary>
        /// 检验中的检验项Id（关联Quality_InspectionOrderOATemplateDetail表InspectionOrderOATemplateDetailId字段）（仅针对IQC检验）
        /// </summary>
        public int? InspectionOrderOATemplateDetailId { get; set; }

        /// <summary>
        /// SN
        /// </summary>
        public string SerialNumber { get; set; }

        /// <summary>
        /// 结果录入值
        /// </summary>
        public string InputValue { get; set; }

        /// <summary>
        /// 检验结果（-1：未检验 0：NG 1：OK 2：N/A）
        /// </summary>
        public int? Result { get; set; }

        /// <summary>
        /// 不良代码（多个用逗号隔开）
        /// </summary>
        public string NcCode { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 删除标记（0：否 1：是）
        /// </summary>
        public int? DeleteFlag { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }

        /// <summary>
        /// 计算方式（0：相位(值1-值2) 1：衰减(值1/值2) 2：VP(无公式)） 仅FQC检验用到
        /// </summary>
        public int? CalcWay { get; set; }

        /// <summary>
        /// 结果录入值1（界面上叫实际测量值1） 仅FQC检验用到
        /// </summary>
        public string InputValue1 { get; set; }

        /// <summary>
        /// 结果录入值2（界面上叫实际测量值2） 仅FQC检验用到
        /// </summary>
        public string InputValue2 { get; set; }
    }
}