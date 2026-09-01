using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class AQLRuleInfo
    {
        private Int32 aQLRuleId;
        private Int32 aQLRuleTypeId;
        private String ruleName;
        private String ruleDescription;
        private String remark;
        private String createrBy;
        private DateTime createDate;
        private String modifyBy;
        private DateTime modifyDate;

        public string AQLRuleTypeName { get; set; }
        public string AQLRuleTypeStr { get { return ruleName + "-" + AQLRuleTypeName; } }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AQLRuleInfo 类的新实例。
        /// </summary>
        public AQLRuleInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AQLRuleInfo 类的新实例。
        /// </summary>
        /// <param name="aQLRuleId"></param>
        /// <param name="aQLRuleTypeId"></param>
        /// <param name="ruleName"></param>
        /// <param name="ruleDescription"></param>
        /// <param name="remark"></param>
        /// <param name="createrBy"></param>
        /// <param name="createDate"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDate"></param>
        public AQLRuleInfo(Int32 aQLRuleId, Int32 aQLRuleTypeId, String ruleName, String ruleDescription,
            String remark, String createrBy, DateTime createDate, String modifyBy, DateTime modifyDate)
        {
            this.aQLRuleId = aQLRuleId;
            this.aQLRuleTypeId = aQLRuleTypeId;
            this.ruleName = ruleName;
            this.ruleDescription = ruleDescription;
            this.remark = remark;
            this.createrBy = createrBy;
            this.createDate = createDate;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AQLRuleId
        {
            get { return this.aQLRuleId; }
            set { this.aQLRuleId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AQLRuleTypeId
        {
            get { return this.aQLRuleTypeId; }
            set { this.aQLRuleTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RuleName
        {
            get { return this.ruleName; }
            set { this.ruleName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String RuleDescription
        {
            get { return this.ruleDescription; }
            set { this.ruleDescription = value; }
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