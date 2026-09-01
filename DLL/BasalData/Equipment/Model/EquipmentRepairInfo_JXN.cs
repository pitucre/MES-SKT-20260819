using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// EquipmentRepairInfo_JXN
    /// </summary>
    [Serializable]
    public class EquipmentRepairInfo_JXN
    {
        /// <summary>
        /// 设备维修信息表Id
        /// </summary>
        public int EquipmentRepairId { get; set; }

        /// <summary>
        /// 维修单号
        /// </summary>
        public string RepairNo { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 设备故障描述
        /// </summary>
        public string AnormalDesc { get; set; }

        /// <summary>
        /// 异常图片（服务器名称）
        /// </summary>
        public string AnormalImg { get; set; }

        /// <summary>
        /// 异常类型编码（关联Basal_Anormal_Type表AnormalTypeCode字段）（不再使用此字段）
        /// </summary>
        public string AnormalTypeCode { get; set; }

        /// <summary>
        /// 异常类型（关联Basal_Anormal_Type表AnormalTypeName字段）
        /// </summary>
        public string AnormalTypeName { get; set; }

        /// <summary>
        /// 工序Id
        /// </summary>
        public int? StationId { get; set; }

        /// <summary>
        /// 紧急程度（-1：未选择 0：低 1：中 2：高）
        /// </summary>
        public int? UrgencyFlag { get; set; }

        /// <summary>
        /// 维修人
        /// </summary>
        public string RepairBy { get; set; }

        /// <summary>
        /// 维修开始时间
        /// </summary>
        public DateTime? RepairStartTime { get; set; }

        /// <summary>
        /// 维修结束时间
        /// </summary>
        public DateTime? RepairEndTime { get; set; }

        /// <summary>
        /// HandleContent
        /// </summary>
        public string HandleContent { get; set; }

        /// <summary>
        /// PartContent
        /// </summary>
        public string PartContent { get; set; }

        /// <summary>
        /// Reserve1
        /// </summary>
        public string Reserve1 { get; set; }

        /// <summary>
        /// Reserve2
        /// </summary>
        public string Reserve2 { get; set; }

        /// <summary>
        /// Reserve3
        /// </summary>
        public string Reserve3 { get; set; }

        /// <summary>
        /// 维修时间
        /// </summary>
        public DateTime? RepairTime { get; set; }

        /// <summary>
        /// 备件条码
        /// </summary>
        public string PartNo { get; set; }

        /// <summary>
        /// 备件数量
        /// </summary>
        public decimal? PartQty { get; set; }

        /// <summary>
        /// 维修方法
        /// </summary>
        public string RepairFunction { get; set; }

        /// <summary>
        /// 外修原因
        /// </summary>
        public string ExternalRepairRemark { get; set; }

        /// <summary>
        /// 验收/拒收备注
        /// </summary>
        public string AcceptRemark { get; set; }

        /// <summary>
        /// 验收人
        /// </summary>
        public string AcceptBy { get; set; }

        /// <summary>
        /// 验收时间
        /// </summary>
        public DateTime? AcceptTime { get; set; }

        /// <summary>
        /// 审核人
        /// </summary>
        public string AuditBy { get; set; }

        /// <summary>
        /// 审核时间
        /// </summary>
        public DateTime? AuditTime { get; set; }

        /// <summary>
        /// 状态（0：待处理 1：维修中 2:报废 3：外修 4：已完成 5：已验收 6：已拒收）
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

        /// <summary>
        /// 是否停机（0：否 1：是） 如果选择停机，在数据采集时，不允许扫描设备，否则允许扫描设备
        /// </summary>
        public int? StopFlag { get; set; }

        /// <summary>
        /// 设备名称
        /// </summary>
        public string EquipmentName { get; set; }

        /// <summary>
        /// 状态（0：待处理 1：维修中 2:报废 3：外修 4：已完成 5：已验收 6：已拒收 7：已审核）
        /// </summary>
        public string StatusName { get; set; }

        /// <summary>
        /// 操作类型（0 开始维修 1：报废 2：外修 3：维修完成 4：验收 5：拒收）
        /// </summary>
        public int Flag { get; set; }

        /// <summary>
        /// 紧急程度（-1：未选择 0：低 1：中 2：高）
        /// </summary>
        public string UrgencyName { get; set; }

        /// <summary>
        /// 工序
        /// </summary>
        public string Station { get; set; }

        /// <summary>
        /// 线体
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 停机时长（小时）
        /// </summary>
        public string StopHour { get; set; }

        /// <summary>
        /// 维修时长（小时）
        /// </summary>
        public string RepairHour { get; set; }

        /// <summary>
        /// 电话
        /// </summary>
        public string Phone { get; set; }


        /// <summary>
        /// 维修人姓名
        /// </summary>
        public string RepairName { get; set; }
        
        /// <summary>
        /// 报修人姓名
        /// </summary>
        public string CreateName { get; set; }

        /// <summary>
        /// 报修人电话
        /// </summary>
        public string CreatePhone { get; set; }

        /// <summary>
        /// 验收人姓名
        /// </summary>
        public string AcceptName { get; set; }

        /// <summary>
        /// 审核人姓名
        /// </summary>
        public string AuditName { get; set; }

        /// <summary>
        /// 外修状态（-1：默认值 1：待OA处理 2：OA已处理）
        /// </summary>
        public int? ExternalRepairStatus { get; set; }

        /// <summary>
        /// OA回写MES — 是否外修（0：否 1：是  如果是0，则MES保持外修状态，如果是1，则MES将维修单改为维修中状态）
        /// </summary>
        public int? ExternalRepairFlag { get; set; }

        /// <summary>
        /// OA单号（OA回写MES用到）
        /// </summary>
        public string OABillNo { get; set; }

        /// <summary>
        /// 是否停机（0：否 1：是） 如果选择停机，在数据采集时，不允许扫描设备，否则允许扫描设备
        /// </summary>
        public string StopFlagName { get; set; }


        /// <summary>
        /// 故障部位
        /// </summary>
        public string FaultLocation { get; set; }


        /// <summary>
        /// 故障状况
        /// </summary>
        public string FaultCause { get; set; }



        /// <summary>
        /// 消息发送方工号
        /// </summary>
        public string fromOaNumber { get; set; }

        /// <summary>
        /// 消息接收方工号
        /// </summary>
        public string toOaNumber { get; set; }

        /// <summary>
        /// 发送的消息
        /// </summary>
        public string info { get; set; }

        /// <summary>
        /// 维修图片
        /// </summary>
        public string RepairImg1 { get; set; }


        /// <summary>
        /// 备件类型
        /// </summary>
        public string EquipmentTypeName { get; set; }


    }
}
