using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class SchedulesInfo
    {
        private Decimal mPID;
        private String creatDate;
        private String moCode;
        private String busType;
        private String busTypeName;
        private String invCode;
        private String invName;
        private String comUnitCode;
        private String mDeptCode;
        private String mDeptName;
        private String rSortSeq;
        private Decimal sortSeq;
        private String sortSeqName;
        private Decimal qty;
        private Decimal planQty;
        private String planBeginDate;
        private String planEndTime;
        private String modifyDate;
        private String memo;
        private String define1;
        private String define2;
        private String define3;
        private String define4;
        private String define5;
        private String define6;
        private Int32 define7;
        private Int32 define8;
        private String define9;
        private String define10;
        private String pubufts;
        private Byte state;
        private Int32 publishStatus;
        private Int32 scheduleId;

        private Int32 kittingStatus;
        private Boolean haveUpdate;
        private Decimal allotQty;

        public String LineName { get; set; }
        public String ShiftName { get; set; }
        public Int32 AllotId { get; set; }
        public String WorkSEQ { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.ScheduleInfo 类的新实例。
        /// </summary>
        public SchedulesInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.ScheduleInfo 类的新实例。
        /// </summary>
        /// <param name="mPID">生产计划顺序号</param>
        /// <param name="creatDate">计划编制日期</param>
        /// <param name="moCode">生产工单号码</param>
        /// <param name="busType">业务类型</param>
        /// <param name="busTypeName">业务类型名称</param>
        /// <param name="invCode">产品编码 </param>
        /// <param name="invName">产品名称</param>
        /// <param name="comUnitCode">单位</param>
        /// <param name="mDeptCode">工厂编号</param>
        /// <param name="mDeptName">工厂名称</param>
        /// <param name="rSortSeq">工段编号</param>
        /// <param name="sortSeq">工序序号</param>
        /// <param name="sortSeqName">工序名称</param>
        /// <param name="qty">工单数量</param>
        /// <param name="planQty">计划生产数量</param>
        /// <param name="planBeginDate">计划上线时间</param>
        /// <param name="planEndTime">计划完工时间</param>
        /// <param name="modifyDate">更新时间</param>
        /// <param name="memo">备注</param>
        /// <param name="define1">自定义项1</param>
        /// <param name="define2"></param>
        /// <param name="define3"></param>
        /// <param name="define4"></param>
        /// <param name="define5"></param>
        /// <param name="define6"></param>
        /// <param name="define7"></param>
        /// <param name="define8"></param>
        /// <param name="define9"></param>
        /// <param name="define10"></param>
        /// <param name="pubufts">时间戳</param>
        /// <param name="sTATE">状态(0新增、1修改、2删除 9、已传MES)</param>
        /// <param name="publishStatus">排程发布状态 1 导入 2 发布</param>
        /// <param name="scheduleId">主键id</param>
        /// <param name="kittingStatus">1 未齐套 2 齐套</param>
        /// <param name="haveUpdate">0 没有 1 有</param>
        /// <param name="allotQty">分配数量</param>
        public SchedulesInfo(Decimal mPID, String creatDate, String moCode, String busType, 
            String busTypeName, String invCode, String invName, String comUnitCode, String mDeptCode, 
            String mDeptName, String rSortSeq, String sortSeqName, Decimal qty, Decimal planQty,
            String planBeginDate, String planEndTime, String modifyDate, String memo, String define1, 
            String define2, String define3, String define4, String define5, String define6,
            Int32 define7, Int32 define8, String define9, String define10, String pubufts,
            Byte state, Int32 publishStatus, Int32 scheduleId, Int32 kittingStatus, Boolean haveUpdate, Decimal allotQty, Decimal sortSeq)
        {
            this.mPID = mPID;
            this.creatDate = creatDate;
            this.moCode = moCode;
            this.busType = busType;
            this.busTypeName = busTypeName;
            this.invCode = invCode;
            this.invName = invName;
            this.comUnitCode = comUnitCode;
            this.mDeptCode = mDeptCode;
            this.mDeptName = mDeptName;
            this.rSortSeq = rSortSeq;
            this.sortSeq = sortSeq;
            this.sortSeqName = sortSeqName;
            this.qty = qty;
            this.planQty = planQty;
            this.planBeginDate = planBeginDate;
            this.planEndTime = planEndTime;
            this.modifyDate = modifyDate;
            this.memo = memo;
            this.define1 = define1;
            this.define2 = define2;
            this.define3 = define3;
            this.define4 = define4;
            this.define5 = define5;
            this.define6 = define6;
            this.define7 = define7;
            this.define8 = define8;
            this.define9 = define9;
            this.define10 = define10;
            this.pubufts = pubufts;
            this.state = state;
            this.publishStatus = publishStatus;
            this.scheduleId = scheduleId;
            this.kittingStatus = kittingStatus;
            this.haveUpdate = haveUpdate;
            this.allotQty = allotQty;
            this.sortSeq = sortSeq;
        }

        /// <summary>
        /// 获取或设置生产计划顺序号
        /// </summary>
        public Decimal MPID
        {
            get { return this.mPID; }
            set { this.mPID = value; }
        }

        /// <summary>
        /// 获取或设置计划编制日期
        /// </summary>
        public String CreatDate
        {
            get { return this.creatDate; }
            set { this.creatDate = value; }
        }

        /// <summary>
        /// 获取或设置生产工单号码
        /// </summary>
        public String MoCode
        {
            get { return this.moCode; }
            set { this.moCode = value; }
        }

        /// <summary>
        /// 获取或设置业务类型
        /// </summary>
        public String BusType
        {
            get { return this.busType; }
            set { this.busType = value; }
        }

        /// <summary>
        /// 获取或设置业务类型名称
        /// </summary>
        public String BusTypeName
        {
            get { return this.busTypeName; }
            set { this.busTypeName = value; }
        }

        /// <summary>
        /// 获取或设置产品编码 
        /// </summary>
        public String InvCode
        {
            get { return this.invCode; }
            set { this.invCode = value; }
        }

        /// <summary>
        /// 获取或设置产品名称
        /// </summary>
        public String InvName
        {
            get { return this.invName; }
            set { this.invName = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public String ComUnitCode
        {
            get { return this.comUnitCode; }
            set { this.comUnitCode = value; }
        }

        /// <summary>
        /// 获取或设置工厂编号
        /// </summary>
        public String MDeptCode
        {
            get { return this.mDeptCode; }
            set { this.mDeptCode = value; }
        }

        /// <summary>
        /// 获取或设置工厂名称
        /// </summary>
        public String MDeptName
        {
            get { return this.mDeptName; }
            set { this.mDeptName = value; }
        }

        /// <summary>
        /// 获取或设置工段编号
        /// </summary>
        public String RSortSeq
        {
            get { return this.rSortSeq; }
            set { this.rSortSeq = value; }
        }

        /// <summary>
        /// 获取或设置工序序号
        /// </summary>
        public Decimal SortSeq
        {
            get { return this.sortSeq; }
            set { this.sortSeq = value; }
        }

        /// <summary>
        /// 获取或设置工序名称
        /// </summary>
        public String SortSeqName
        {
            get { return this.sortSeqName; }
            set { this.sortSeqName = value; }
        }

        /// <summary>
        /// 获取或设置工单数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置计划生产数量
        /// </summary>
        public Decimal PlanQty
        {
            get { return this.planQty; }
            set { this.planQty = value; }
        }

        /// <summary>
        /// 获取或设置计划上线时间
        /// </summary>
        public String PlanBeginDate
        {
            get { return this.planBeginDate; }
            set { this.planBeginDate = value; }
        }

        /// <summary>
        /// 获取或设置计划完工时间
        /// </summary>
        public String PlanEndTime
        {
            get { return this.planEndTime; }
            set { this.planEndTime = value; }
        }

        /// <summary>
        /// 获取或设置更新时间
        /// </summary>
        public String ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Memo
        {
            get { return this.memo; }
            set { this.memo = value; }
        }

        /// <summary>
        /// 获取或设置自定义项1
        /// </summary>
        public String Define1
        {
            get { return this.define1; }
            set { this.define1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define2
        {
            get { return this.define2; }
            set { this.define2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define3
        {
            get { return this.define3; }
            set { this.define3 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define4
        {
            get { return this.define4; }
            set { this.define4 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define5
        {
            get { return this.define5; }
            set { this.define5 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define6
        {
            get { return this.define6; }
            set { this.define6 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Define7
        {
            get { return this.define7; }
            set { this.define7 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Define8
        {
            get { return this.define8; }
            set { this.define8 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define9
        {
            get { return this.define9; }
            set { this.define9 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Define10
        {
            get { return this.define10; }
            set { this.define10 = value; }
        }

        /// <summary>
        /// 获取或设置时间戳
        /// </summary>
        public String Pubufts
        {
            get { return this.pubufts; }
            set { this.pubufts = value; }
        }

        /// <summary>
        /// 获取或设置状态(0新增、1修改、2删除 9、已传MES)
        /// </summary>
        public Byte State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置排程发布状态 1 导入 2 发布
        /// </summary>
        public Int32 PublishStatus
        {
            get { return this.publishStatus; }
            set { this.publishStatus = value; }
        }

        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 ScheduleId
        {
            get { return this.scheduleId; }
            set { this.scheduleId = value; }
        }

        /// <summary>
        /// 齐套  1 未齐套 2 齐套
        /// </summary>
        public Int32 KittingStatus
        {
            get { return this.kittingStatus; }
            set { this.kittingStatus = value; }
        }

        /// <summary>
        /// 是否有更新  0 没有 1 有
        /// </summary>
        public Boolean HaveUpdate
        {
            get { return this.haveUpdate; }
            set { this.haveUpdate = value; }
        }

        /// <summary>
        /// 已分配数量
        /// </summary>
        public Decimal AllotQty
        {
            get { return this.allotQty; }
            set { this.allotQty = value; }
        }
    }

}