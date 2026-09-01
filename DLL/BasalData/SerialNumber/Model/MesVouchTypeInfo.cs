using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class MesVouchTypeInfo
    {
        private Int32 mesVouchTypeId;
        private String pageName;
        private String vouchName;
        private String vouchENName;
        private String mTableName;
        private String cTableName;
        private Int32 encodeRule;
        private Int32 ruleName;
        private Int32 packRule;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String encodeStr;
        private String ruleStr;
        private String packRuleStr;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MesVouchTypeInfo 类的新实例。
        /// </summary>
        public MesVouchTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MesVouchTypeInfo 类的新实例。
        /// </summary>
        /// <param name="mesVouchTypeId">单据类型编码</param>
        /// <param name="pageName">单据类型页面名</param>
        /// <param name="vouchName">单据类型名称</param>
        /// <param name="vouchENName">单据类型英文名</param>
        /// <param name="mTableName">对应主表</param>
        /// <param name="cTableName">对应子表</param>
        /// <param name="encodeRule">单据编码规则</param>
        /// <param name="ruleName">批号规则</param>
        /// <param name="packRule">包装条码规则</param>
        /// <param name="createPerson">建档人</param>
        /// <param name="createDateTime">建档时间</param>
        /// <param name="modifyPerson">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public MesVouchTypeInfo(Int32 mesVouchTypeId, String pageName, String vouchName, String vouchENName, 
            String mTableName, String cTableName, Int32 encodeRule, Int32 ruleName, Int32 packRule,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.mesVouchTypeId = mesVouchTypeId;
            this.pageName = pageName;
            this.vouchName = vouchName;
            this.vouchENName = vouchENName;
            this.mTableName = mTableName;
            this.cTableName = cTableName;
            this.encodeRule = encodeRule;
            this.ruleName = ruleName;
            this.packRule = packRule;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置单据类型编码
        /// </summary>
        public Int32 MesVouchTypeId
        {
            get { return this.mesVouchTypeId; }
            set { this.mesVouchTypeId = value; }
        }

        /// <summary>
        /// 获取或设置单据类型页面名
        /// </summary>
        public String PageName
        {
            get { return this.pageName; }
            set { this.pageName = value; }
        }

        /// <summary>
        /// 获取或设置单据类型名称
        /// </summary>
        public String VouchName
        {
            get { return this.vouchName; }
            set { this.vouchName = value; }
        }

        /// <summary>
        /// 获取或设置单据类型英文名
        /// </summary>
        public String VouchENName
        {
            get { return this.vouchENName; }
            set { this.vouchENName = value; }
        }

        /// <summary>
        /// 获取或设置对应主表
        /// </summary>
        public String MTableName
        {
            get { return this.mTableName; }
            set { this.mTableName = value; }
        }

        /// <summary>
        /// 获取或设置对应子表
        /// </summary>
        public String CTableName
        {
            get { return this.cTableName; }
            set { this.cTableName = value; }
        }

        /// <summary>
        /// 获取或设置单据编码规则
        /// </summary>
        public Int32 EncodeRule
        {
            get { return this.encodeRule; }
            set { this.encodeRule = value; }
        }

        /// <summary>
        /// 获取或设置批号规则
        /// </summary>
        public Int32 RuleName
        {
            get { return this.ruleName; }
            set { this.ruleName = value; }
        }

        /// <summary>
        /// 获取或设置包装条码规则
        /// </summary>
        public Int32 PackRule
        {
            get { return this.packRule; }
            set { this.packRule = value; }
        }

        /// <summary>
        /// 获取或设置建档人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置建档时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String EncodeStr
        {
            get { return this.encodeStr; }
            set { this.encodeStr = value; }
        }
        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String RuleStr
        {
            get { return this.ruleStr; }
            set { this.ruleStr = value; }
        }
        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String PackRuleStr
        {
            get { return this.packRuleStr; }
            set { this.packRuleStr = value; }
        }

    }
}