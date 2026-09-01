using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    /// <summary>
    /// 送检批信息
    /// </summary>
    public class InspectionInfo
    {
        public int InspectionLotId { get; set; }
        public string InspectionLotNo { get; set; }
        public string ItemCode { get; set; }
        public int LotQty { get; set; }
        public string State { get; set; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        public List<PackingData> PackingDataList { get; set; }
    }

    /// <summary>
    /// 栈板、包装信息
    /// </summary>
    public class PackInfo
    {
        public string PackSN { get; set; }
        public int Quantity { get; set; }
        public string SN { get; set; }
    }

    /// <summary>
    /// 检验项信息
    /// </summary>
    public class InspectionLotMemberInfo
    {
        public int InspectionLotMemberId { get; set; }
        public string AQLSampleName { get; set; }
        public string AQLLevel { get; set; }
        public string AQLRule { get; set; }
        public int InspectionQty { get; set; }
        public int ActualQty { get; set; }
        public string Judgment { get; set; }
        public int NCCodeQty { get; set; }
        public string Result { get; set; }

        /**检验项 zcl 2017-01-10**/
        public int InspectionTemplateId { get; set; }
        public string InspectionTemplateName { get; set; }
        public string InspectionName { get; set; }
        public int InspectionMethodId { get; set; }
        public string InspectionMethodName { get; set; }
        public string InspectionMethodValue { get; set; }
        public string UnitName { get; set; }
        public string CheckFashion { get; set; }
        public string Reserve { get; set; }
        public string Reserve1 { get; set; }
        public int InspectionItemId { get; set; }

        public int Number { get; set; }
        /// <summary>
        /// 是否已扫描 1 已扫描 2 未扫描
        /// </summary>
        public int IsScan { get; set; }
    }

    /// <summary>
    /// 检验项详情扫描的SN
    /// </summary>
    public class InspectionLotMemberSNInfo
    {
        public string SN { get; set; }
        public string AQLSampleName { get; set; }
        public string CustomerSN { get; set; }
        public string Result { get; set; }
        public string NCCode { get; set; }
        public string CreateDateTime { get; set; }
        /// <summary>
        /// SN检验值
        /// </summary>
        public string Value { get; set; }

        /// <summary>
        /// 检验标准
        /// </summary>
        public string InspectionMethodValue { get; set; }
        
        /// <summary>
        /// 不良代码（多个用逗号隔开）
        /// </summary>
        public string NCCodes { get; set; }
        /// <summary>
        /// 不良描述（多个用逗号隔开）
        /// </summary>
        public string Description { get; set; }
        
    }

    public class InspectionLotRecordsInfo
    {
        public string ItemCode { get; set; }
        public string SN { get; set; }
        public string AQLSampleName { get; set; }
        public string CustomerSN { get; set; }
        public string NCCode { get; set; }
        public string Result { get; set; }
        public string CreateBy { get; set; }
        public string CreateDateTime { get; set; }
        public string ImportDateTime { get; set; }
        public int TotalQty { get; set; }
        public int NGQty { get; set; }
    }

    public class StationInfo
    {
        public int StationId { get; set; }
        public string Station { get; set; }
    }

    public class FAICodeInfo : AICodeInfo
    {
        public string FAICode { get; set; }
    }

    public class EAICodeInfo: AICodeInfo
    {
        public string EAICode { get; set; }
    }

    public class AICodeInfo
    {
        public int IOrderId { get; set; } 
        public int Status { get; set; }
    }


    public class FAIInspectionInfo : AIInspectionInfo
    {
        public string FAICode { get; set; }
        public string FAISNStr { get; set; }
    }

    public class EAIInspectionInfo: AIInspectionInfo
    {

        public string EAICode { get; set; }
        public string EAISNStr { get; set; }
    }

    public class AIInspectionInfo
    {
        public int TemplateId { get; set; }
        public string InspectionTemplateName { get; set; }
        public string TemplateVersion { get; set; }
        public int InspectionTypeId { get; set; }
        public int ProdOrderId { get; set; }
        public int LineId { get; set; }
        public int StationId { get; set; }
        public int ResourceId { get; set; }
        public string SendMan { get; set; }
        public string ClassType { get; set; }
        public string UserName { get; set; }
        public int SampleQty { get; set; }
        public int IOrderId { get; set; }
        public string MemberItemStr { get; set; }
    }


    public class FAISNInfo : AISNInfo
    {
        
    }
    public class EAISNInfo: AISNInfo
    {
        
    }

    public class AISNInfo
    {
        public int IOMemberId { get; set; }
        public string SN { get; set; }
        public string Result { get; set; }
        public string ScanTime { get; set; }
        public string NCCode { get; set; }
    }
}
