using System;

namespace SKT.LeanMES.Schedule.Model
{
    [Serializable]
    public class ERP_MOBOMInfo
    {
        private Int32 id;
        private string moCode;
        private string rowno;
        private string busType;
        private string allocateId;
        private string moId;
        private string mDeptCode;
        private string mDeptName;
        private string invCode;
        private string invName;
        private string comUnitCode;
        private string whCode;
        private string whName;
        private string vouchCode;
        private string vouchName;
        private string qty;
        private string requisitionIssQty;
        private string issQty;
        private string compScrap;
        private string cBatch;
        private string rSortSeq;
        private string sortSeq;
        private string createDate;
        private string modifyDate;
        private string whEndDate;
        private string pubufts;
        private string define1;
        private string define2;
        private string define3;
        private string define4;
        private string define5;
        private string define6;
        private string define7;
        private string define8;
        private string define9;
        private string define10;
        private string state;
        private string workSeq;
        private string changePerson;
        private string changeDate;
        private string changeRemark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.MOBOMInfo 类的新实例。
        /// </summary>
        public ERP_MOBOMInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.MOBOMInfo 类的新实例。
        /// </summary>
        /// <param name="moCode">工单号</param>
        /// <param name="rowno">单身项次</param>
        /// <param name="busType">工单类型</param>
        /// <param name="allocateId">生产订单子件明细</param>
        /// <param name="moId">工单Id</param>
        /// <param name="mDeptCode">生产部门编码</param>
        /// <param name="mDeptName">生产部门名称</param>
        /// <param name="invCode">物料编码</param>
        /// <param name="invName">存货名称</param>
        /// <param name="comUnitCode">单位</param>
        /// <param name="whCode">仓库编码</param>
        /// <param name="whName">仓库名称</param>
        /// <param name="vouchCode">货位编码</param>
        /// <param name="vouchName">货位名称</param>
        /// <param name="qty">工单应发数量</param>
        /// <param name="requisitionIssQty">申请已领量</param>
        /// <param name="issQty">已领量</param>
        /// <param name="compScrap">损耗率</param>
        /// <param name="cBatch">批号</param>
        /// <param name="rSortSeq">工段号</param>
        /// <param name="sortSeq">工序号</param>
        /// <param name="createDate">创建日期</param>
        /// <param name="modifyDate">修改日期</param>
        /// <param name="whEndDate"></param>
        /// <param name="pubufts">时间戳</param>
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
        /// <param name="state">状态(0新增、1修改、2删除 9已传MES、)</param>
        /// <param name="workSeq"></param>
        public ERP_MOBOMInfo(string moCode, string rowno, string busType, string allocateId,
            string moId, string mDeptCode, string mDeptName, string invCode, string invName,
            string comUnitCode, string whCode, string whName, string vouchCode, string vouchName,
            string qty, string requisitionIssQty, string issQty, string compScrap, string cBatch,
            string rSortSeq, string sortSeq, string createDate, string modifyDate, string whEndDate,
            string pubufts, string define1, string define2, string define3, string define4,
            string define5, string define6, string define7, string define8, string define9,
            string define10, string state, string workSeq)
        {
            this.moCode = moCode;
            this.rowno = rowno;
            this.busType = busType;
            this.allocateId = allocateId;
            this.moId = moId;
            this.mDeptCode = mDeptCode;
            this.mDeptName = mDeptName;
            this.invCode = invCode;
            this.invName = invName;
            this.comUnitCode = comUnitCode;
            this.whCode = whCode;
            this.whName = whName;
            this.vouchCode = vouchCode;
            this.vouchName = vouchName;
            this.qty = qty;
            this.requisitionIssQty = requisitionIssQty;
            this.issQty = issQty;
            this.compScrap = compScrap;
            this.cBatch = cBatch;
            this.rSortSeq = rSortSeq;
            this.sortSeq = sortSeq;
            this.createDate = createDate;
            this.modifyDate = modifyDate;
            this.whEndDate = whEndDate;
            this.pubufts = pubufts;
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
            this.workSeq = workSeq;
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Schedule.Model.MOBOMInfo 类的新实例。
        /// </summary>
        /// <param name="moCode">工单号</param>
        /// <param name="rowno">单身项次</param>
        /// <param name="busType">工单类型</param>
        /// <param name="allocateId">生产订单子件明细</param>
        /// <param name="moId">工单Id</param>
        /// <param name="mDeptCode">生产部门编码</param>
        /// <param name="mDeptName">生产部门名称</param>
        /// <param name="invCode">物料编码</param>
        /// <param name="invName">存货名称</param>
        /// <param name="comUnitCode">单位</param>
        /// <param name="whCode">仓库编码</param>
        /// <param name="whName">仓库名称</param>
        /// <param name="vouchCode">货位编码</param>
        /// <param name="vouchName">货位名称</param>
        /// <param name="qty">工单应发数量</param>
        /// <param name="requisitionIssQty">申请已领量</param>
        /// <param name="issQty">已领量</param>
        /// <param name="compScrap">损耗率</param>
        /// <param name="cBatch">批号</param>
        /// <param name="rSortSeq">工段号</param>
        /// <param name="sortSeq">工序号</param>
        /// <param name="createDate">创建日期</param>
        /// <param name="modifyDate">修改日期</param>
        /// <param name="whEndDate"></param>
        /// <param name="pubufts">时间戳</param>
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
        /// <param name="state">状态(0新增、1修改、2删除 9已传MES、)</param>
        /// <param name="workSeq"></param>
        public ERP_MOBOMInfo(Int32 id, string moCode, string rowno, string busType, string allocateId, 
            string moId, string mDeptCode, string mDeptName, string invCode, string invName, 
            string comUnitCode, string whCode, string whName, string vouchCode, string vouchName, 
            string qty, string requisitionIssQty, string issQty, string compScrap, string cBatch, 
            string rSortSeq, string sortSeq, string createDate, string modifyDate, string whEndDate, 
            string pubufts, string define1, string define2, string define3, string define4, 
            string define5, string define6, string define7, string define8, string define9, 
            string define10, string state, string workSeq)
        {
            this.id = id;
            this.moCode = moCode;
            this.rowno = rowno;
            this.busType = busType;
            this.allocateId = allocateId;
            this.moId = moId;
            this.mDeptCode = mDeptCode;
            this.mDeptName = mDeptName;
            this.invCode = invCode;
            this.invName = invName;
            this.comUnitCode = comUnitCode;
            this.whCode = whCode;
            this.whName = whName;
            this.vouchCode = vouchCode;
            this.vouchName = vouchName;
            this.qty = qty;
            this.requisitionIssQty = requisitionIssQty;
            this.issQty = issQty;
            this.compScrap = compScrap;
            this.cBatch = cBatch;
            this.rSortSeq = rSortSeq;
            this.sortSeq = sortSeq;
            this.createDate = createDate;
            this.modifyDate = modifyDate;
            this.whEndDate = whEndDate;
            this.pubufts = pubufts;
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
            this.workSeq = workSeq;
        }

        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }


        /// <summary>
        /// 获取或设置工单号
        /// </summary>
        public string MoCode
        {
            get { return this.moCode; }
            set { this.moCode = value; }
        }

        /// <summary>
        /// 获取或设置单身项次
        /// </summary>
        public string Rowno
        {
            get { return this.rowno; }
            set { this.rowno = value; }
        }

        /// <summary>
        /// 获取或设置工单类型
        /// </summary>
        public string BusType
        {
            get { return this.busType; }
            set { this.busType = value; }
        }

        /// <summary>
        /// 获取或设置生产订单子件明细
        /// </summary>
        public string AllocateId
        {
            get { return this.allocateId; }
            set { this.allocateId = value; }
        }

        /// <summary>
        /// 获取或设置生产订单明细
        /// </summary>
        public string MoId
        {
            get { return this.moId; }
            set { this.moId = value; }
        }

        /// <summary>
        /// 获取或设置生产部门编码
        /// </summary>
        public string MDeptCode
        {
            get { return this.mDeptCode; }
            set { this.mDeptCode = value; }
        }

        /// <summary>
        /// 获取或设置生产部门名称
        /// </summary>
        public string MDeptName
        {
            get { return this.mDeptName; }
            set { this.mDeptName = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public string InvCode
        {
            get { return this.invCode; }
            set { this.invCode = value; }
        }

        /// <summary>
        /// 获取或设置存货名称
        /// </summary>
        public string InvName
        {
            get { return this.invName; }
            set { this.invName = value; }
        }

        /// <summary>
        /// 获取或设置单位
        /// </summary>
        public string ComUnitCode
        {
            get { return this.comUnitCode; }
            set { this.comUnitCode = value; }
        }

        /// <summary>
        /// 获取或设置仓库编码
        /// </summary>
        public string WhCode
        {
            get { return this.whCode; }
            set { this.whCode = value; }
        }

        /// <summary>
        /// 获取或设置仓库名称
        /// </summary>
        public string WhName
        {
            get { return this.whName; }
            set { this.whName = value; }
        }

        /// <summary>
        /// 获取或设置货位编码
        /// </summary>
        public string VouchCode
        {
            get { return this.vouchCode; }
            set { this.vouchCode = value; }
        }

        /// <summary>
        /// 获取或设置货位名称
        /// </summary>
        public string VouchName
        {
            get { return this.vouchName; }
            set { this.vouchName = value; }
        }

        /// <summary>
        /// 获取或设置工单应发数量
        /// </summary>
        public string Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置申请已领量
        /// </summary>
        public string RequisitionIssQty
        {
            get { return this.requisitionIssQty; }
            set { this.requisitionIssQty = value; }
        }

        /// <summary>
        /// 获取或设置已领量
        /// </summary>
        public string IssQty
        {
            get { return this.issQty; }
            set { this.issQty = value; }
        }

        /// <summary>
        /// 获取或设置损耗率
        /// </summary>
        public string CompScrap
        {
            get { return this.compScrap; }
            set { this.compScrap = value; }
        }

        /// <summary>
        /// 获取或设置批号
        /// </summary>
        public string Batch
        {
            get { return this.cBatch; }
            set { this.cBatch = value; }
        }

        /// <summary>
        /// 获取或设置工段号
        /// </summary>
        public string RSortSeq
        {
            get { return this.rSortSeq; }
            set { this.rSortSeq = value; }
        }

        /// <summary>
        /// 获取或设置工序号
        /// </summary>
        public string SortSeq
        {
            get { return this.sortSeq; }
            set { this.sortSeq = value; }
        }

        /// <summary>
        /// 获取或设置创建日期
        /// </summary>
        public string CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }

        /// <summary>
        /// 获取或设置修改日期
        /// </summary>
        public string ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string WhEndDate
        {
            get { return this.whEndDate; }
            set { this.whEndDate = value; }
        }

        /// <summary>
        /// 获取或设置时间戳
        /// </summary>
        public string Pubufts
        {
            get { return this.pubufts; }
            set { this.pubufts = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define1
        {
            get { return this.define1; }
            set { this.define1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define2
        {
            get { return this.define2; }
            set { this.define2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define3
        {
            get { return this.define3; }
            set { this.define3 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define4
        {
            get { return this.define4; }
            set { this.define4 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define5
        {
            get { return this.define5; }
            set { this.define5 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define6
        {
            get { return this.define6; }
            set { this.define6 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define7
        {
            get { return this.define7; }
            set { this.define7 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define8
        {
            get { return this.define8; }
            set { this.define8 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define9
        {
            get { return this.define9; }
            set { this.define9 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Define10
        {
            get { return this.define10; }
            set { this.define10 = value; }
        }

        /// <summary>
        /// 获取或设置状态(0新增、1修改、2删除 9已传MES、)
        /// </summary>
        public string State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string WorkSeq
        {
            get { return this.workSeq; }
            set { this.workSeq = value; }
        }


        public string ChangePerson
        {
            get { return this.changePerson; }
            set { this.changePerson = value; }
        }

        public string ChangeDate
        {
            get { return this.changeDate; }
            set { this.changeDate = value; }
        }

        public string ChangeRemark
        {
            get { return this.changeRemark; }
            set { this.changeRemark = value; }
        }
    }
}