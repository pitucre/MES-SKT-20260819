using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
   
    [Serializable]
    public class AQLRuleMemberInfo
    {
        private Int32 aQLRuleMemberId;
        private Int32 aQLRuleId;
        private String samplingValue;
        private Int32 aCValue;
        private Int32 rEValue;
        private String createrBy;
        private DateTime createDate;
        private String modifyBy;
        private DateTime modifyDate;

        public string LotLetter { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AQLRuleMemberInfo 类的新实例。
        /// </summary>
        public AQLRuleMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AQLRuleMemberInfo 类的新实例。
        /// </summary>
        /// <param name="aLQRuleMemberId"></param>
        /// <param name="aQLRuleId"></param>
        /// <param name="minValue">抽检范围最小值</param>
        /// <param name="maxValue">抽检范围最大值</param>
        /// <param name="samplingValue">抽检值</param>
        /// <param name="isPercent">是否按百分比</param>
        /// <param name="aCValue">允收不合格值</param>
        /// <param name="rEValue">应退数量</param>
        /// <param name="createrBy"></param>
        /// <param name="createDate"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDate"></param>
        public AQLRuleMemberInfo(Int32 aLQRuleMemberId, Int32 aQLRuleId, String samplingValue, Int32 aCValue, Int32 rEValue, String createrBy, 
            DateTime createDate, String modifyBy, DateTime modifyDate)
        {
            this.aQLRuleMemberId = aLQRuleMemberId;
            this.aQLRuleId = aQLRuleId;
            this.samplingValue = samplingValue;
            this.aCValue = aCValue;
            this.rEValue = rEValue;
            this.createrBy = createrBy;
            this.createDate = createDate;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AQLRuleMemberId
        {
            get { return this.aQLRuleMemberId; }
            set { this.aQLRuleMemberId = value; }
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
        /// 获取或设置抽检值
        /// </summary>
        public String SamplingValue
        {
            get { return this.samplingValue; }
            set { this.samplingValue = value; }
        }

        /// <summary>
        /// 获取或设置允收不合格值
        /// </summary>
        public Int32 ACValue
        {
            get { return this.aCValue; }
            set { this.aCValue = value; }
        }

        /// <summary>
        /// 获取或设置应退数量
        /// </summary>
        public Int32 REValue
        {
            get { return this.rEValue; }
            set { this.rEValue = value; }
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