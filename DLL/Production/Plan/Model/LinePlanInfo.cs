using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class LinePlanInfo
    {

        private Int32 linePlanId;
        private Int32 lineId;
        private Int32 fInterID;
        private String fBILLNO;
        private DateTime fPlanCommitDate;
        private DateTime fPlanFinishDate;
        private Decimal fQty;
        private int state;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        public string TableName { get; set; }
        public int LinePlanType { get; set; }//排程工单类型 1、SMT 2、后段工单
        public string OrderNo { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemModel { get; set; }
        public string CLNumber { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LinePlanInfo 类的新实例。
        /// </summary>
        public LinePlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.LinePlanInfo 类的新实例。
        /// </summary>
        /// <param name="linePlanId"></param>
        /// <param name="lineId">产线ID</param>
        /// <param name="fInterID">工单内码</param>
        /// <param name="fBILLNO">工单编号</param>
        /// <param name="fPlanCommitDate">计划开工时间</param>
        /// <param name="fPlanFinishDate">计划完工日期</param>
        /// <param name="fQty">计划生产数量</param>
        /// <param name="state">状态</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public LinePlanInfo(Int32 linePlanId, Int32 lineId, Int32 fInterID, String fBILLNO,
            DateTime fPlanCommitDate, DateTime fPlanFinishDate, Decimal fQty, int state, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.linePlanId = linePlanId;
            this.lineId = lineId;
            this.fInterID = fInterID;
            this.fBILLNO = fBILLNO;
            this.fPlanCommitDate = fPlanCommitDate;
            this.fPlanFinishDate = fPlanFinishDate;
            this.fQty = fQty;
            this.state = state;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LinePlanId
        {
            get { return this.linePlanId; }
            set { this.linePlanId = value; }
        }

        /// <summary>
        /// 获取或设置产线ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置工单内码
        /// </summary>
        public Int32 FInterID
        {
            get { return this.fInterID; }
            set { this.fInterID = value; }
        }

        /// <summary>
        /// 获取或设置工单编号
        /// </summary>
        public String FBILLNO
        {
            get { return this.fBILLNO; }
            set { this.fBILLNO = value; }
        }

        /// <summary>
        /// 获取或设置计划开工时间
        /// </summary>
        public DateTime FPlanCommitDate
        {
            get { return this.fPlanCommitDate; }
            set { this.fPlanCommitDate = value; }
        }

        /// <summary>
        /// 获取或设置计划完工日期
        /// </summary>
        public DateTime FPlanFinishDate
        {
            get { return this.fPlanFinishDate; }
            set { this.fPlanFinishDate = value; }
        }

        /// <summary>
        /// 获取或设置计划生产数量
        /// </summary>
        public Decimal FQty
        {
            get { return this.fQty; }
            set { this.fQty = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public int State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 已生产数量
        /// </summary>
        public decimal FStockQty { get; set; }

        /// <summary>
        /// 物料锁定标识（0：未锁定 1：已锁定）
        /// </summary>
        public int MaterialLockFlag { get; set; }


        /// <summary>
        /// 工单Bom物料编码
        /// </summary>
        public string BomItemCode { get; set; }

        /// <summary>
        /// 工单Bom物料名称
        /// </summary>
        public string BomItemName { get; set; }

        /// <summary>
        /// 工单Bom物料单位
        /// </summary>
        public string BomUnits { get; set; }

        /// <summary>
        /// 工单Bom物料用量
        /// </summary>
        public decimal PerNum { get; set; }

        /// <summary>
        /// 工单BOM物料需用数量
        /// </summary>
        public decimal NeedQty { get; set; }

        /// <summary>
        /// 工单BOM物料可用数量
        /// </summary>
        public decimal BalanceQty { get; set; }

        /// <summary>
        /// 缺料数
        /// </summary>
        public decimal LackQty { get; set; }

        /// <summary>
        /// 齐套状态
        /// </summary>
        public string HomogeneityStatus { get; set; }

        /// <summary>
        /// 线别每日生产排序号
        /// </summary>
        public int ProductionLineSort { get; set; }
        /// <summary>
        /// 是否手动排产(插单) 0=否 1=是
        /// </summary>
        public int IsHand { get; set; }

        /// <summary>
        /// 资源ID
        /// </summary>
        public int ResourceId { get; set; }

        public string ResName { get; set; }

        public string StatusDesc { get; set; }

        public string LineName { get; set; }

        public string EquipmentCode { get; set; }

    }
}