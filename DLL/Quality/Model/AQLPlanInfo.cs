using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class AQLPlanInfo
    {
        private Int32 planId;
        private String aqlName;
        private Int32 aqlRuleTypeId;
        private Int32 aqlPlanType;
        private Int32 applyTo;
        private Int32 aqlPlanStatus;
        private String aqlDescription;
        private Int32 reject;
        private String remark;
        private String createrBy;
        private DateTime createDate;
        private String modifyBy;
        private DateTime modifyDate;

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLPlanInfo 类的新实例。
        /// </summary>
        public AQLPlanInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLPlanInfo 类的新实例。
        /// </summary>
        /// <param name="planId"></param>
        /// <param name="aqlName"></param>
        /// <param name="aqlRuleTypeId"></param>
        /// <param name="aqlPlanType"></param>
        /// <param name="applyTo"></param>
        /// <param name="aqlPlanStatus"></param>
        /// <param name="aqlDescription"></param>
        /// <param name="reject"></param>
        /// <param name="remark"></param>
        /// <param name="createrBy"></param>
        /// <param name="createDate"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDate"></param>
        public AQLPlanInfo(Int32 planId, String aqlName, Int32 aqlRuleTypeId, Int32 aqlPlanType, 
            Int32 applyTo, Int32 aqlPlanStatus, String aqlDescription, Int32 reject, String remark, 
            String createrBy, DateTime createDate, String modifyBy, DateTime modifyDate)
        {
            this.planId = planId;
            this.aqlName = aqlName;
            this.aqlRuleTypeId = aqlRuleTypeId;
            this.aqlPlanType = aqlPlanType;
            this.applyTo = applyTo;
            this.aqlPlanStatus = aqlPlanStatus;
            this.aqlDescription = aqlDescription;
            this.reject = reject;
            this.remark = remark;
            this.createrBy = createrBy;
            this.createDate = createDate;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
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
        /// 获取或设置
        /// </summary>
        public String AqlName
        {
            get { return this.aqlName; }
            set { this.aqlName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AqlRuleTypeId
        {
            get { return this.aqlRuleTypeId; }
            set { this.aqlRuleTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AqlPlanType
        {
            get { return this.aqlPlanType; }
            set { this.aqlPlanType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ApplyTo
        {
            get { return this.applyTo; }
            set { this.applyTo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AqlPlanStatus
        {
            get { return this.aqlPlanStatus; }
            set { this.aqlPlanStatus = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AqlDescription
        {
            get { return this.aqlDescription; }
            set { this.aqlDescription = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Reject
        {
            get { return this.reject; }
            set { this.reject = value; }
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
        /// 获取或设置
        /// </summary>
        public String CreaterBy
        {
            get { return this.createrBy; }
            set { this.createrBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
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
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }
    }
}