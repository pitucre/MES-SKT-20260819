using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class OBAAuditInfo
    {
        private Int32 auditRuleId;
        private Int32 itemId;
        private Int32 lotSize;
        private Double samplePercent;
        private Int32 sampleSize;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private string itemCode;

        private string itemName;

        private String samplePercentStr;

        /// <summary>
        /// 初始化 SKT.MES.Model.AUDITInfo 类的新实例。
        /// </summary>
        public OBAAuditInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.AUDITInfo 类的新实例。
        /// </summary>
        /// <param name="itemAuditId"></param>
        /// <param name="itemId"></param>
        /// <param name="lotSize"></param>
        /// <param name="samplePercent"></param>
        /// <param name="sampleSize"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public OBAAuditInfo(Int32 itemAuditId, Int32 itemId, Int32 lotSize, Double samplePercent,
            Int32 sampleSize, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.auditRuleId = itemAuditId;
            this.itemId = itemId;
            this.lotSize = lotSize;
            this.samplePercent = samplePercent;
            this.sampleSize = sampleSize;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        public String ItemName
        {
            set { this.itemName = value; }
            get { return this.itemName; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AuditRuleId
        {
            get { return this.auditRuleId; }
            set { this.auditRuleId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LotSize
        {
            get { return this.lotSize; }
            set { this.lotSize = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double SamplePercent
        {
            get { return this.samplePercent; }
            set { this.samplePercent = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SampleSize
        {
            get { return this.sampleSize; }
            set { this.sampleSize = value; }
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

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }

        /// <summary>
        /// 百分比的 字符形式 20%
        /// </summary>
        public string SamplePercentStr
        {
            get { return samplePercentStr; }
            set { samplePercentStr = value; }
        }
    }
}