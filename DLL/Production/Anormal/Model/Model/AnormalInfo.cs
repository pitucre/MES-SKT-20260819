using System;

namespace SKT.LeanMES.ProdAnormal.Model
{
    [Serializable]
    public class AnormalInfo
    {
        public Int32 AnormalId { get; set; }
        public Int32 AnormalTypeId { get; set; }
        public String AnormalObject { get; set; }
        public Int32 LineId { get; set; }
        public Int32 OpeId { get; set; }
        public Int32 UserId { get; set; }
        public String Owner { get; set; }
        public String DeptId { get; set; }
        public Int32 Status { get; set; }
        public DateTime StartTime { get; set; }
        public DateTime EndTime { get; set; }
        public String Descriptions { get; set; }
        public Boolean IsLineStop { get; set; }
        public DateTime LineStopTime { get; set; }
        public String CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public String Remark { get; set; }
        public Int32 Shift { get; set; }
        public String RCCA { get; set; }
        public Int32 SolutionId { get; set; }
        public String ActionPerson { get; set; }
        public String Solution { get; set; }
        public DateTime ActionTime { get; set; }
        public Double AbnormalTimeLength { get; set; }
        public String AbnormalUnit { get; set; }
        public Decimal EffectPerson { get; set; }
        public String AnormalTypeCode { get; set; }
        public String AnormalTypeName { get; set; }
        public String Station { get; set; }
        public String CName { get; set; }
        public String LineName { get; set; }

        public String ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }

        public String DeptName { set; get; }
        public String AuditPerson { set; get; }
        public DateTime AuditTime { set; get; }
        public string AuditRemark { set; get; }
      
        /// <summary>
        /// 原因分析
        /// </summary>
        public string CauseAnalysis { get; set; }

        /// <summary>
        /// 临时改善方案
        /// </summary>
        public string TempSolution { get; set; }

        /// <summary>
        /// 永久改善方案
        /// </summary>
        public string PermanentSolution { get; set; }

        /// <summary>
        /// 推送消息
        /// </summary>
        public string PushInformation { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public string ActionPersonName { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string OwnerName { get; set; }





        public string AbnormalDocumentNo { get; set; }
        public int OrderQty { get; set; }
        public int ProductIntoQty { get; set; }
        public int BadQty { get; set; }
        public decimal BadRate { get; set; }
        public string MachineModel { get; set; }
        public string Source { get; set; }
        public string IPQCConfirmer { get; set; }
        public string PECauseAnalysisMan { get; set; }
        public DateTime? PECauseAnalysisTime { get; set; }
        public string AnormalItemCode { get; set; }
        public string AnormalItemName { get; set; }
        public int TempTreatmentScheme { get; set; }
        public int InventoryMaterialHandlingMethod { get; set; }
        public int OutputHandlingMethod { get; set; }
        public int PackedHandlingMethod { get; set; }
        public string TempHandler { get; set; }
        public DateTime? TempHandleTime { get; set; }
        public decimal FinalBadRate { get; set; }
        public string DutyDept { get; set; }
        public string DutyMan { get; set; }
        public string QEConfirmer { get; set; }
        public DateTime? QEConfirmTime { get; set; }
        public string ImproveMaker { get; set; }
        public DateTime? ImproveTime { get; set; }
        public string CountermeasureTracking { get; set; }
        public int Closed { get; set; }
        public string QAFinalConfirm { get; set; }
        public DateTime? QAFinalConfirmTime { get; set; }
        public string Supplier { get; set; }

        public string Supervisor { get; set; }

        public bool SolutionFinished { get; set; }
    }
}