using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// 检验项信息表（OA对接）
    /// </summary>
    [Serializable]
    public class EquipmentInspectionTemplateDetailInfo
    {
        /// <summary>
        /// 主键（检验项信息表Id）
        /// </summary>
        public int InspectionOrderOATemplateDetailId { get; set; }

        /// <summary>
        /// 检验单与OA检验模板明细关系信息表Id（关联Quality_InspectionOrderOATemplate表InspectionOrderOATemplateId字段）
        /// </summary>
        public int? InspectionOrderOATemplateId { get; set; }

        /// <summary>
        /// 检验类别（如：常规检验、可靠性、环保等）
        /// </summary>
        public string InspectionTypeName { get; set; }

        /// <summary>
        /// 抽样标准(AQL)
        /// </summary>
        public string AQLRuleName { get; set; }

        /// <summary>
        /// 检验项目名称
        /// </summary>
        public string InspectionItemName { get; set; }

        /// <summary>
        /// 检验周期/频次
        /// </summary>
        public string InspectionCycle { get; set; }

        /// <summary>
        /// 检验方法
        /// </summary>
        public string InspectionMethod { get; set; }

        /// <summary>
        /// 判定方式 如：（人工录入结果、系统根据大小值判定、系统根据最小值判定等，对应CheckBox、Decimal、CommonRange等）（需求变更，不再使用）
        /// </summary>
        public string DataType { get; set; }

        /// <summary>
        /// 最小值标识（0：否 1：是）（需求变更，不再使用）
        /// </summary>
        public int? MinValueFlag { get; set; }

        /// <summary>
        /// 最大值标识（0：否 1：是）（需求变更，不再使用）
        /// </summary>
        public int? MaxValueFlag { get; set; }

        /// <summary>
        /// 平均值标识（0：否 1：是）（需求变更，不再使用）
        /// </summary>
        public int? AvgValueFlag { get; set; }

        /// <summary>
        /// 固定结果标识（也叫手动判定，OK、NG单选框）（0：否 1：是 ；0：系统判定 1：人工判定）
        /// </summary>
        public int? FixResultFlag { get; set; }

        /// <summary>
        /// 标准值（例如：OK/NG 、 >=1 、 ==2 、 1~100 、 1,2,3 等）
        /// </summary>
        public string StandardValue { get; set; }

        /// <summary>
        /// 单位（需求变更，不再使用）
        /// </summary>
        public string Unit { get; set; }

        /// <summary>
        /// 输出数据标识（0：否 1：是）
        /// </summary>
        public int? OutPutDataFlag { get; set; }

        /// <summary>
        /// 输出图标标识（0：否 1：是）
        /// </summary>
        public int? OutPutImageFlag { get; set; }

        /// <summary>
        /// 输出文件标识（0：否 1：是）
        /// </summary>
        public int? OutPutFileFlag { get; set; }

        /// <summary>
        /// 抽检数量（人工录入）
        /// </summary>
        public decimal? SamplingQty { get; set; }

        /// <summary>
        /// 测试人
        /// </summary>
        public string TestBy { get; set; }

        /// <summary>
        /// 测试设备
        /// </summary>
        public string TestEquipment { get; set; }

        /// <summary>
        /// 检验数据（多个用逗号隔开，只做展示作用，具体数据在Quality_InspectionOrderSN表中）
        /// </summary>
        public string InspectionData { get; set; }

        /// <summary>
        /// 最小值
        /// </summary>
        public decimal? MinValue { get; set; }

        /// <summary>
        /// 最大值
        /// </summary>
        public decimal? MaxValue { get; set; }

        /// <summary>
        /// 平均值
        /// </summary>
        public decimal? AvgValue { get; set; }

        /// <summary>
        /// 上传检验图片名称
        /// </summary>
        public string InspectionImageName { get; set; }

        /// <summary>
        /// 上传检验图片路径
        /// </summary>
        public string InspectionImageUrl { get; set; }

        /// <summary>
        /// 上传检验文件名称
        /// </summary>
        public string InspectionFileName { get; set; }

        /// <summary>
        /// 上传检验文件路径
        /// </summary>
        public string InspectionFileUrl { get; set; }

        /// <summary>
        /// 检验项检验数量（人工录入）
        /// </summary>
        public decimal? InspectionItemQty { get; set; }

        /// <summary>
        /// 检验项不合格数量（人工录入）
        /// </summary>
        public decimal? InspectionItemNGQty { get; set; }

        /// <summary>
        /// 结果（-1：未检验 0：NG 1:OK 2:N/A）
        /// </summary>
        public int? Result { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 上传不合格图片名称
        /// </summary>
        public string InspectionNGImageName { get; set; }

        /// <summary>
        /// 上传不合格图片路径
        /// </summary>
        public string InspectionNGImageUrl { get; set; }

        /// <summary>
        /// 序号
        /// </summary>
        public int? RowNum { get; set; }

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
        /// 检验项记录时间
        /// </summary>
        public DateTime? InspectionItemRecordTime { get; set; }

        /// <summary>
        /// IPQC检验结果（-1：未检验 0：NG 1：OK）
        /// </summary>
        public int? IPQCResult { get; set; }

        /// <summary>
        /// IPQC确认时间
        /// </summary>
        public DateTime? IPQCConfirmTime { get; set; }

        /// <summary>
        /// IPQC备注
        /// </summary>
        public string IPQCRemark { get; set; }

        /// <summary>
        /// IPQC确认人
        /// </summary>
        public string IPQCConfirmBy { get; set; }

        /// <summary>
        /// 检验项类型（-1：默认值 0：生产检验项 1：品质检验项）（仅对首件检验用到）
        /// </summary>
        public int? InspectionItemType { get; set; }

        /// <summary>
        /// 检验批次为月检时，检验项检验时间
        /// </summary>
        public DateTime? MonthTime { get; set; }

        /// <summary>
        /// 检验批次为月检时，检验项对应的检验单Id
        /// </summary>
        public int? MonthInspectionId { get; set; }

        /// <summary>
        /// 是否为在当前检验单中的进行的检验（0：否 1：是），如果为1，则表示是当前检验单中进行的检验，否则表示从其他检验单中进行的更新
        /// </summary>
        public int? MonthInspectionFlag { get; set; }

        /// <summary>
        /// 已提示月检标识（0：否 未提示 1：是 已提示）（过期之后，只有第一个检验单才提示检验）
        /// </summary>
        public int? MonthTipFlag { get; set; }

        /// <summary>
        /// 提示检验时间（过期之后，只有第一个检验单才提示检验）
        /// </summary>
        public DateTime? MonthTipTime { get; set; }

        public int? Eid { get; set; }

        public int? DemoId { get; set; }

        public int? DemoSubId { get; set; }
        public int? IsDone { get; set; }

        public string Description { get; set; }

        #region 拓展字段

        /// <summary>
        /// 检验单Id
        /// </summary>
        public int InspectionId { get; set; }

        /// <summary>
        /// 结果（-1：未检验 0：NG 1:OK 2:N/A）
        /// </summary>
        public string ResultName { get; set; }

        /// <summary>
        /// 抽样类型（仅FQC用到）（数据为：子SN，母SN）
        /// </summary>
        public string SampleType { get; set; }

        #endregion

    }

}
