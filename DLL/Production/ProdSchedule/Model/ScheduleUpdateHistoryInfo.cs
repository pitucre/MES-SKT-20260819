using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class ScheduleUpdateHistoryInfo
    {
        private Int32 historyId;
        private Decimal mPID;
        private DateTime creatDate;
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
        private DateTime planBeginDate;
        private DateTime planEndTime;
        private DateTime modifyDate;
        private String memo;
        private String define1;
        private String define2;
        private String define3;
        private String define4;
        private String define5;
        private String define6;
        private Int32 define7;
        private Int32 define8;
        private DateTime define9;
        private DateTime define10;
        private String pubufts;
        private Byte state;
        private DateTime updateDateTime;
        private String updatePerson;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.ScheduleUpdateHistoryInfo 类的新实例。
        /// </summary>
        public ScheduleUpdateHistoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.ScheduleUpdateHistoryInfo 类的新实例。
        /// </summary>
        /// <param name="historyId"></param>
        /// <param name="mPID"></param>
        /// <param name="creatDate"></param>
        /// <param name="moCode"></param>
        /// <param name="busType"></param>
        /// <param name="busTypeName"></param>
        /// <param name="invCode"></param>
        /// <param name="invName"></param>
        /// <param name="comUnitCode"></param>
        /// <param name="mDeptCode"></param>
        /// <param name="mDeptName"></param>
        /// <param name="rSortSeq"></param>
        /// <param name="sortSeq"></param>
        /// <param name="sortSeqName"></param>
        /// <param name="qty"></param>
        /// <param name="planQty"></param>
        /// <param name="planBeginDate"></param>
        /// <param name="planEndTime"></param>
        /// <param name="modifyDate"></param>
        /// <param name="memo"></param>
        /// <param name="define1"></param>
        /// <param name="define2"></param>
        /// <param name="define3"></param>
        /// <param name="define4"></param>
        /// <param name="define5"></param>
        /// <param name="define6"></param>
        /// <param name="define7"></param>
        /// <param name="define8"></param>
        /// <param name="define9"></param>
        /// <param name="define10"></param>
        /// <param name="pubufts"></param>
        /// <param name="sTATE"></param>
        /// <param name="updateDateTime">排程导入更新时间</param>
        /// <param name="updatePerson">更新人</param>
        /// <param name="remark">备注</param>
        public ScheduleUpdateHistoryInfo(Int32 historyId, Decimal mPID, DateTime creatDate, String moCode, 
            String busType, String busTypeName, String invCode, String invName, String comUnitCode,
            String mDeptCode, String mDeptName, String rSortSeq, String sortSeqName, Decimal qty, 
            Decimal planQty, DateTime planBeginDate, DateTime planEndTime, DateTime modifyDate, String memo, 
            String define1, String define2, String define3, String define4, String define5, 
            String define6, Int32 define7, Int32 define8, DateTime define9, DateTime define10,
            String pubufts, Byte state, DateTime updateDateTime, String updatePerson, String remark, Decimal sortSeq)
        {
            this.historyId = historyId;
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
            this.updateDateTime = updateDateTime;
            this.updatePerson = updatePerson;
            this.remark = remark;
            this.sortSeq = sortSeq;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 HistoryId
        {
            get { return this.historyId; }
            set { this.historyId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal MPID
        {
            get { return this.mPID; }
            set { this.mPID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreatDate
        {
            get { return this.creatDate; }
            set { this.creatDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MoCode
        {
            get { return this.moCode; }
            set { this.moCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String BusType
        {
            get { return this.busType; }
            set { this.busType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String BusTypeName
        {
            get { return this.busTypeName; }
            set { this.busTypeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InvCode
        {
            get { return this.invCode; }
            set { this.invCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InvName
        {
            get { return this.invName; }
            set { this.invName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ComUnitCode
        {
            get { return this.comUnitCode; }
            set { this.comUnitCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MDeptCode
        {
            get { return this.mDeptCode; }
            set { this.mDeptCode = value; }
        }

        /// <summary>
        /// 获取或设置
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
        /// 获取或设置
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal PlanQty
        {
            get { return this.planQty; }
            set { this.planQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime PlanBeginDate
        {
            get { return this.planBeginDate; }
            set { this.planBeginDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime PlanEndTime
        {
            get { return this.planEndTime; }
            set { this.planEndTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Memo
        {
            get { return this.memo; }
            set { this.memo = value; }
        }

        /// <summary>
        /// 获取或设置
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
        public DateTime Define9
        {
            get { return this.define9; }
            set { this.define9 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime Define10
        {
            get { return this.define10; }
            set { this.define10 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Pubufts
        {
            get { return this.pubufts; }
            set { this.pubufts = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置排程导入更新时间
        /// </summary>
        public DateTime UpdateDateTime
        {
            get { return this.updateDateTime; }
            set { this.updateDateTime = value; }
        }

        /// <summary>
        /// 获取或设置更新人
        /// </summary>
        public String UpdatePerson
        {
            get { return this.updatePerson; }
            set { this.updatePerson = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}