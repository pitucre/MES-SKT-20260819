using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulingInfo
    {  
        private String prodOrderNO;
        private String productName;
        private String factoryName;
        private String sectionName;
        private Int32 prodOrderQty;
        private Int32 finishedQty;
        private String planBeginDate;
        private String planEndTime;
        private String actualBeginDate;
        private String actualEndTime;
        private Int32 scheduleId;
        private Int32 schedulingId;
        private Int32 schedulingStatus;
        private Int32 schedulingSeq;
        private String shift;
        private String line;
        private Decimal schedulingQty;

        public String WorkSEQ { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.SchedulingInfo 类的新实例。
        /// </summary>
        public SchedulingInfo()
        {
        }


        public SchedulingInfo(Int32 schedulingId, String prodOrderNO, String productName, String factoryName, String workSEQ,
            Int32 prodOrderQty, Int32 finishedQty,
            String planBeginDate, String planEndTime, String actualBeginDate, String actualEndTime,
            Int32 scheduleId, Int32 schedulingStatus, Int32 schedulingSeq, String shift,
            String line, Decimal schedulingQty)
        {
            this.schedulingId = schedulingId;
            this.prodOrderNO = prodOrderNO;
            this.productName = productName;
            this.factoryName = factoryName;
            this.WorkSEQ = workSEQ;
            this.prodOrderQty = prodOrderQty;
            this.finishedQty = finishedQty;
            this.planBeginDate = planBeginDate;
            this.planEndTime = planEndTime;
            this.actualBeginDate = actualBeginDate;
            this.actualEndTime = actualEndTime;
            this.scheduleId = scheduleId;
            this.schedulingStatus = schedulingStatus;
            this.schedulingSeq = schedulingSeq;
            this.shift = shift;
            this.line = line;
            this.schedulingQty = schedulingQty;
        }

        /// <summary>
        /// 获取或设置工单号
        /// </summary>
        public String ProdOrderNO
        {
            get { return this.prodOrderNO; }
            set { this.prodOrderNO = value; }
        }

        /// <summary>
        /// 获取或设置产品名
        /// </summary>
        public String ProductName
        {
            get { return this.productName; }
            set { this.productName = value; }
        }

        /// <summary>
        /// 获取或设置工厂名称
        /// </summary>
        public String FactoryName
        {
            get { return this.factoryName; }
            set { this.factoryName = value; }
        }

        /// <summary>
        /// 获取或设置工段名称
        /// </summary>
        public String SectionName
        {
            get { return this.sectionName; }
            set { this.sectionName = value; }
        }

        /// <summary>
        /// 获取或设置工单总量
        /// </summary>
        public Int32 ProdOrderQty
        {
            get { return this.prodOrderQty; }
            set { this.prodOrderQty = value; }
        }

        /// <summary>
        /// 获取或设置完成数量
        /// </summary>
        public Int32 FinishedQty
        {
            get { return this.finishedQty; }
            set { this.finishedQty = value; }
        }

        /// <summary>
        /// 获取或设置计划开始时间
        /// </summary>
        public String PlanBeginDate
        {
            get { return this.planBeginDate; }
            set { this.planBeginDate = value; }
        }

        /// <summary>
        /// 获取或设置计划完成时间
        /// </summary>
        public String PlanEndTime
        {
            get { return this.planEndTime; }
            set { this.planEndTime = value; }
        }

        /// <summary>
        /// 获取或设置实际开始时间
        /// </summary>
        public String ActualBeginDate
        {
            get { return this.actualBeginDate; }
            set { this.actualBeginDate = value; }
        }

        /// <summary>
        /// 获取或设置实际完成时间
        /// </summary>
        public String ActualEndTime
        {
            get { return this.actualEndTime; }
            set { this.actualEndTime = value; }
        }

        /// <summary>
        /// 获取或设置排程Id
        /// </summary>
        public Int32 ScheduleId
        {
            get { return this.scheduleId; }
            set { this.scheduleId = value; }
        }

        /// <summary>
        /// 获取或设置排产ID
        /// </summary>
        public Int32 SchedulingId
        {
            get { return this.schedulingId; }
            set { this.schedulingId = value; }
        }

        /// <summary>
        /// 获取或设置排产状态
        /// </summary>
        public Int32 SchedulingStatus
        {
            get { return this.schedulingStatus; }
            set { this.schedulingStatus = value; }
        }

        /// <summary>
        /// 获取或设置排产顺序
        /// </summary>
        public Int32 SchedulingSeq
        {
            get { return this.schedulingSeq; }
            set { this.schedulingSeq = value; }
        }

        /// <summary>
        /// 获取或设置班次
        /// </summary>
        public String Shift
        {
            get { return this.shift; }
            set { this.shift = value; }
        }

        /// <summary>
        /// 获取或设置产线
        /// </summary>
        public String Line
        {
            get { return this.line; }
            set { this.line = value; }
        }

        /// <summary>
        /// 获取或设置排产数量
        /// </summary>
        public Decimal SchedulingQty
        {
            get { return this.schedulingQty; }
            set { this.schedulingQty = value; }
        }

    }
}