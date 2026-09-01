using System;

namespace SKT.LeanMES.Plan.Model
{
    [Serializable]
    public class PlanInfo
    {
        private Int32 planId;
        private Int32 planTypeId;
        private String orderNumber;
        private String materialCode;
        private String materialDescription;
        private Int32 amount;
        private DateTime orderStartTime;
        private DateTime orderEndTime;
        private String state;
        private DateTime orderCreateDateTime;
        private String orderType;
        private String synthesisMachine;
        private DateTime synthesisDateTime;
        private String synthesisTeam;
        private String pressNumber;
        private Int32 scrappedQuantity;
        private String explain;
        private String planRemark;
        private String createBy;
        private DateTime createDateTime;
        private DateTime qICATSDT;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 在前台Jquery调用AjaxServices使用
        /// </summary>
        public string OrderStartTimeStr { get;set;}

        /// <summary>
        /// 在前台Jquery调用AjaxServices使用
        /// </summary>
        public string OrderEndTimeStr { get; set; }

        /// <summary>
        /// 在前台Jquery调用AjaxServices使用
        /// </summary>
        public string OrderCreateDateTimeStr { get; set; }

        /// <summary>
        /// 在前台Jquery调用AjaxServices使用
        /// </summary>
        public string SynthesisDateTimeStr { get; set; }

        /// <summary>
        /// 在前台Jquery调用AjaxServices使用
        /// </summary>
        public string QICATSDTStr { get; set; } 

  

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PlanInfo 类的新实例。
        /// </summary>
        public PlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PlanInfo 类的新实例。
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="planTypeId">计划类型</param>
        /// <param name="orderNumber">生产计划订单号</param>
        /// <param name="materialCode">物料编码</param>
        /// <param name="materialDescription">物料描述</param>
        /// <param name="amount">数量</param>
        /// <param name="orderStartTime">订单创建时间</param>
        /// <param name="orderEndTime">结束日期</param>
        /// <param name="state">状态</param>
        /// <param name="orderCreateDateTime">订单创建时间</param>
        /// <param name="orderType">订单类型</param>
        /// <param name="synthesisMachine">合成机台</param>
        /// <param name="synthesisDateTime">合成时间</param>
        /// <param name="synthesisTeam">合成班组</param>
        /// <param name="pressNumber">压机号</param>
        /// <param name="scrappedQuantity">废品数量</param>
        /// <param name="explain">特别说明</param>
        /// <param name="planRemark">计划说明</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="qICATSDT">质检收取磨耗比测试样日期</param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public PlanInfo(Int32 planId, Int32 planTypeId, String orderNumber, String materialCode,
            String materialDescription, Int32 amount, DateTime orderStartTime, DateTime orderEndTime, String state,
            DateTime orderCreateDateTime, String orderType, String synthesisMachine, DateTime synthesisDateTime, String synthesisTeam,
            String pressNumber, Int32 scrappedQuantity, String explain, String planRemark, String createBy,
            DateTime createDateTime, DateTime qICATSDT, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.planId = planId;
            this.planTypeId = planTypeId;
            this.orderNumber = orderNumber;
            this.materialCode = materialCode;
            this.materialDescription = materialDescription;
            this.amount = amount;
            this.orderStartTime = orderStartTime;
            this.orderEndTime = orderEndTime;
            this.state = state;
            this.orderCreateDateTime = orderCreateDateTime;
            this.orderType = orderType;
            this.synthesisMachine = synthesisMachine;
            this.synthesisDateTime = synthesisDateTime;
            this.synthesisTeam = synthesisTeam;
            this.pressNumber = pressNumber;
            this.scrappedQuantity = scrappedQuantity;
            this.explain = explain;
            this.planRemark = planRemark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.qICATSDT = qICATSDT;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PlanId
        {
            get { return this.planId; }
            set { this.planId = value; }
        }

        /// <summary>
        /// 获取或设置计划类型
        /// </summary>
        public Int32 PlanTypeId
        {
            get { return this.planTypeId; }
            set { this.planTypeId = value; }
        }

        public string PlanTypeName
        {
            get { return planTypeId == 1 ? "成品计划" : "半成品计划"; }
        }

        /// <summary>
        /// 获取或设置生产计划订单号
        /// </summary>
        public String OrderNumber
        {
            get { return this.orderNumber; }
            set { this.orderNumber = value; }
        }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String MaterialCode
        {
            get { return this.materialCode; }
            set { this.materialCode = value; }
        }

        /// <summary>
        /// 获取或设置物料描述
        /// </summary>
        public String MaterialDescription
        {
            get { return this.materialDescription; }
            set { this.materialDescription = value; }
        }

        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public Int32 Amount
        {
            get { return this.amount; }
            set { this.amount = value; }
        }

        /// <summary>
        /// 获取或设置订单创建时间
        /// </summary>
        public DateTime OrderStartTime
        {
            get { return this.orderStartTime; }
            set { this.orderStartTime = value; }
        }

        /// <summary>
        /// 开始时间，这个属性用于前台绑定
        /// </summary>
        public String OrderStartTime_BindStr
        {
            get { return this.orderStartTime == DateTime.Parse("9999-12-31")
                || (this.orderStartTime == DateTime.Parse("1900-01-01")) ? "" : this.orderStartTime.ToString("yyyy-MM-dd");
            }
           
        }

        /// <summary>
        /// 获取或设置结束日期
        /// </summary>
        public DateTime OrderEndTime
        {
            get { return this.orderEndTime; }
            set { this.orderEndTime = value; }
        }

        /// <summary>
        /// 结束时间，这个属性用于前台绑定
        /// </summary>
        public string OrderEndTime_BindStr
        {
            get
            {
                return this.orderEndTime == DateTime.Parse("9999-12-31")
                    || (this.orderEndTime == DateTime.Parse("1900-01-01")) ? "" : this.orderEndTime.ToString("yyyy-MM-dd");
            }

        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public String State
        {
            get { return this.state; }
            set { this.state = value; }
        }

        /// <summary>
        /// 获取或设置订单创建时间
        /// </summary>
        public DateTime OrderCreateDateTime
        {
            get { return this.orderCreateDateTime; }
            set { this.orderCreateDateTime = value; }
        }

        /// <summary>
        /// 订单创建时间，这个属性用于前台绑定
        /// </summary>
        public string OrderCreateDateTime_BindStr
        {
            get
            {
                return this.orderCreateDateTime == DateTime.Parse("9999-12-31")
                    || (this.orderCreateDateTime == DateTime.Parse("1900-01-01")) ? "" : this.orderCreateDateTime.ToString("yyyy-MM-dd");
            }

        }

        /// <summary>
        /// 获取或设置订单类型
        /// </summary>
        public String OrderType
        {
            get { return this.orderType; }
            set { this.orderType = value; }
        }

        /// <summary>
        /// 获取或设置合成机台
        /// </summary>
        public String SynthesisMachine
        {
            get { return this.synthesisMachine; }
            set { this.synthesisMachine = value; }
        }

        /// <summary>
        /// 获取或设置合成时间
        /// </summary>
        public DateTime SynthesisDateTime
        {
            get { return this.synthesisDateTime; }
            set { this.synthesisDateTime = value; }
        }

        /// <summary>
        /// 合成时间，这个属性用于前台绑定
        /// </summary>
        public string SynthesisDateTime_BindStr
        {
            get
            {
                return this.synthesisDateTime == DateTime.Parse("9999-12-31")
                    || (this.synthesisDateTime == DateTime.Parse("1900-01-01")) ? "" : this.synthesisDateTime.ToString("yyyy-MM-dd");
            }

        }

        /// <summary>
        /// 获取或设置合成班组
        /// </summary>
        public String SynthesisTeam
        {
            get { return this.synthesisTeam; }
            set { this.synthesisTeam = value; }
        }

        /// <summary>
        /// 获取或设置压机号
        /// </summary>
        public String PressNumber
        {
            get { return this.pressNumber; }
            set { this.pressNumber = value; }
        }

        /// <summary>
        /// 获取或设置废品数量
        /// </summary>
        public Int32 ScrappedQuantity
        {
            get { return this.scrappedQuantity; }
            set { this.scrappedQuantity = value; }
        }

        /// <summary>
        /// 获取或设置特别说明
        /// </summary>
        public String Explain
        {
            get { return this.explain; }
            set { this.explain = value; }
        }

        /// <summary>
        /// 获取或设置计划说明
        /// </summary>
        public String PlanRemark
        {
            get { return this.planRemark; }
            set { this.planRemark = value; }
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
        /// 获取或设置质检收取磨耗比测试样日期
        /// </summary>
        public DateTime QICATSDT
        {
            get { return this.qICATSDT; }
            set { this.qICATSDT = value; }
        }


        /// <summary>
        /// 质检收取磨耗比测试样日期，这个属性用于前台绑定
        /// </summary>
        public string QICATSDT_BindStr
        {
            get
            {
                return this.qICATSDT == DateTime.Parse("9999-12-31")
                    || (this.qICATSDT == DateTime.Parse("1900-01-01")) ? "" : this.qICATSDT.ToString("yyyy-MM-dd");
            }

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
    }
}