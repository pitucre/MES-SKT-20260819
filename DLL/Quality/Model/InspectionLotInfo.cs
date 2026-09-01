using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quantity.Model
{
    public class InspectionLotInfo
    {
        public int InspectionLotId { get; set; }
        public string InspectionLotNo { get; set; }
        public string State { get; set; }
        public int LotQty { get; set; }
        public string ItemCode { get; set; }
        public string Result { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string CreateBy { get; set; }
        public string ItemName { get; set; }
        public int LineId { get; set; }
        public string LineName { get; set; }

        public int ActualQty { get; set; }
        public string OrderNo { get; set; }
        public int ProdOrderId { get; set; }
        public int SystemType { get; set; }
        public string SystemTypeName { get; set; }
    }

    public class InspectionLotMemberInfo
    {
        public int InspectionLotMemberId { get; set; }
        public string AQLSampleName { get; set; }
        public string AQLRule { get; set; }
        public int InspectionQty { get; set; }
        public int AcQty { get; set; }
        public int ReQty { get; set; }
        public int ActualQty { get; set; }
        public int NCCodeQty { get; set; }
        public string Result { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string CreateBy { get; set; }
        public string InspectionName { get; set; }
        public string InspectionTemplateName { get; set; }
        public int InspectionMethodId { get; set; }
        public string InspectionMethodName { get; set; }
        public string InspectionMethodValue { get; set; }
        public string UnitName { get; set; }
        public string CheckFashion { get; set; }
    }

    public class InspectionLotMemberSNInfo
    {
        public int InspectionLotMemberSNId { get; set; }
        public string SN { get; set; }
        public string CustomerSN { get; set; }
        public string Result { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string CreateBy { get; set; }

        public string InspectionMethodValue { get; set; }
        public string Value { get; set; }
        public string NCCodes { get; set; }
    }

    /// <summary>
    /// 检验批次SN信息
    /// </summary>
    public class InspectionLotSNInfo
    {
        public Int64 UID { get; set; }
        public string SN { get; set; }
        public string QcLotNo { get; set; }
        public string CustomerSN { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }

        public string ProcessSN { get; set; }
    }
}
