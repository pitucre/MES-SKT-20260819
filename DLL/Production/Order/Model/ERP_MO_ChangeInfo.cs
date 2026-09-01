using System;

namespace SKT.LeanMES.Order.Model
{
    [Serializable]
    public class MO_ChangeInfo
    {
        private Int32 id;
        private object moCode;
        private object rowno;
        private object busType;
        private object moId;
        private object mDeptCode;
        private object mDeptName;
        private object mDate;
        private object planBeginDate;
        private object planEndTime;
        private object invCode;
        private object invName;
        private object comUnitCode;
        private object qty;
        private object qualifiedInQty;
        private object pubufts;
        private object cMemo;
        private object define1;
        private object define2;
        private object define3;
        private object define4;
        private object define5;
        private object define6;
        private object define7;
        private object define8;
        private object define9;
        private object define10;
        private object state;
        private object mOStatus;
        private object changePerson;
        private object changeDate;
        private object changeRemark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.MO_ChangeInfo 类的新实例。
        /// </summary>
        public MO_ChangeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.MO_ChangeInfo 类的新实例。
        /// </summary>
        /// <param name="moCode">工单号</param>
        /// <param name="rowno">单身项次</param>
        /// <param name="busType">工单类型</param>
        /// <param name="moId">工单ID </param>
        /// <param name="mDeptCode">生产部门</param>
        /// <param name="mDeptName">生产部门名称</param>
        /// <param name="mDate">开单日期</param>
        /// <param name="planBeginDate">计划开工时间</param>
        /// <param name="planEndTime">计划完工时间</param>
        /// <param name="invCode">存货编码</param>
        /// <param name="invName">存货名称</param>
        /// <param name="comUnitCode">单位</param>
        /// <param name="qty">生产订单数量</param>
        /// <param name="qualifiedInQty">入库数量</param>
        /// <param name="pubufts">时间戳</param>
        /// <param name="cMemo">备注</param>
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
        /// <param name="state">状态(0新增、1修改、2删除、3结案、 9已传MES、)</param>
        /// <param name="mOStatus"></param>
        public MO_ChangeInfo(Int32 id, object moCode, object rowno, object busType, object moId, 
            object mDeptCode, object mDeptName, object mDate, object planBeginDate, object planEndTime, 
            object invCode, object invName, object comUnitCode, object qty, object qualifiedInQty, 
             object pubufts, object cMemo, object define1, object define2, object define3, 
            object define4, object define5, object define6, object define7, object define8, 
            object define9, object define10, object state, object mOStatus)
        {
            this.id = id;
            this.moCode = moCode;
            this.rowno = rowno;
            this.busType = busType;
            this.moId = moId;
            this.mDeptCode = mDeptCode;
            this.mDeptName = mDeptName;
            this.mDate = mDate;
            this.planBeginDate = planBeginDate;
            this.planEndTime = planEndTime;
            this.invCode = invCode;
            this.invName = invName;
            this.comUnitCode = comUnitCode;
            this.qty = qty;
            this.qualifiedInQty = qualifiedInQty;
            this.pubufts = pubufts;
            this.cMemo = cMemo;
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
            this.state = state;
            this.mOStatus = mOStatus;
        }

        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }


        /// <summary>
        /// 获取或设置工单号
        /// </summary>
        public object MoCode
        {
            get { return this.moCode; }
            set { this.moCode = value; }
        }

        /// <summary>
        /// 获取或设置单身项次
        /// </summary>
        public object Rowno
        {
            get { return this.rowno; }
            set { this.rowno = value; }
        }

        /// <summary>
        /// 获取或设置工单类型
        /// </summary>
        public object BusType
        {
            get { return this.busType; }
            set { this.busType = value; }
        }

        /// <summary>
        /// 获取或设置生产订单明细资料ID 
        /// </summary>
        public object MoId
        {
            get { return this.moId; }
            set { this.moId = value; }
        }

        /// <summary>
        /// 获取或设置生产部门
        /// </summary>
        public object MDeptCode
        {
            get { return this.mDeptCode; }
            set { this.mDeptCode = value; }
        }

        /// <summary>
        /// 获取或设置生产部门名称
        /// </summary>
        public object MDeptName
        {
            get { return this.mDeptName; }
            set { this.mDeptName = value; }
        }

        /// <summary>
        /// 获取或设置开单日期
        /// </summary>
        public object MDate
        {
            get { return this.mDate; }
            set { this.mDate = value; }
        }

        /// <summary>
        /// 获取或设置计划开工时间
        /// </summary>
        public object PlanBeginDate
        {
            get { return this.planBeginDate; }
            set { this.planBeginDate = value; }
        }

        /// <summary>
        /// 获取或设置计划完工时间
        /// </summary>
        public object PlanEndTime
        {
            get { return this.planEndTime; }
            set { this.planEndTime = value; }
        }

        /// <summary>
        /// 获取或设置存货编码
        /// </summary>
        public object InvCode
        {
            get { return this.invCode; }
            set { this.invCode = value; }
        }

        /// <summary>
        /// 获取或设置存货名称
        /// </summary>
        public object InvName
        {
            get { return this.invName; }
            set { this.invName = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public object ComUnitCode
        {
            get { return this.comUnitCode; }
            set { this.comUnitCode = value; }
        }

        /// <summary>
        /// 获取或设置生产订单数量
        /// </summary>
        public object Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置入库数量
        /// </summary>
        public object QualifiedInQty
        {
            get { return this.qualifiedInQty; }
            set { this.qualifiedInQty = value; }
        }

        /// <summary>
        /// 获取或设置时间戳
        /// </summary>
        public object Pubufts
        {
            get { return this.pubufts; }
            set { this.pubufts = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public object Memo
        {
            get { return this.cMemo; }
            set { this.cMemo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define1
        {
            get { return this.define1; }
            set { this.define1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define2
        {
            get { return this.define2; }
            set { this.define2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define3
        {
            get { return this.define3; }
            set { this.define3 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define4
        {
            get { return this.define4; }
            set { this.define4 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define5
        {
            get { return this.define5; }
            set { this.define5 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define6
        {
            get { return this.define6; }
            set { this.define6 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define7
        {
            get { return this.define7; }
            set { this.define7 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define8
        {
            get { return this.define8; }
            set { this.define8 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define9
        {
            get { return this.define9; }
            set { this.define9 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object Define10
        {
            get { return this.define10; }
            set { this.define10 = value; }
        }

        /// <summary>
        /// 获取或设置状态(0新增、1修改、2删除、3结案、 9已传MES、)
        /// </summary>
        public object State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public object MOStatus
        {
            get { return this.mOStatus; }
            set { this.mOStatus = value; }
        }

        public object ChangePerson
        {
            get { return this.changePerson; }
            set { this.changePerson = value; }
        }

        public object ChangeDate
        {
            get { return this.changeDate; }
            set { this.changeDate = value; }
        }

        public object ChangeRemark
        {
            get { return this.changeRemark; }
            set { this.changeRemark = value; }
        }
    }
}