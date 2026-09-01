using System;

namespace SKT.LeanMES.MaskGroup.Model
{
    [Serializable]
    public class MaskGroupMemberInfo
    {
        private Int32 id;
        private Int32 maskId;
        private Int32 sequence;
        private String maskType;
        private String displayMask;
        private String regularExpression;
        private Int32 minLength;
        private Int32 maxLength;
        private DateTime validFrom;
        private DateTime validTo;

        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.GROUP_MEMBERInfo 类的新实例。
        /// </summary>
        public MaskGroupMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.GROUP_MEMBERInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="maskID">掩码ID</param>
        /// <param name="sequence">次序</param>
        /// <param name="maskType">掩码类别</param>
        /// <param name="displayMask">显示掩码</param>
        /// <param name="regularExpression">规则表达式</param>
        /// <param name="minLength">最小长度</param>
        /// <param name="maxLength">最大长度</param>
        /// <param name="validFrom">验证开始日期</param>
        /// <param name="validTo">验证截至日期</param>
        public MaskGroupMemberInfo(Int32 id, Int32 maskID, Int32 sequence, String maskType, 
            String displayMask, String regularExpression, Int32 minLength, Int32 maxLength, DateTime validFrom, 
            DateTime validTo)
        {
            this.id = id;
            this.maskId = maskID;
            this.sequence = sequence;
            this.maskType = maskType;
            this.displayMask = displayMask;
            this.regularExpression = regularExpression;
            this.minLength = minLength;
            this.maxLength = maxLength;
            this.validFrom = validFrom;
            this.validTo = validTo;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置掩码ID
        /// </summary>
        public Int32 MaskID
        {
            get { return this.maskId; }
            set { this.maskId = value; }
        }

        /// <summary>
        /// 获取或设置次序
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设置掩码类别
        /// </summary>
        public String MaskType
        {
            get { return this.maskType; }
            set { this.maskType = value; }
        }

        /// <summary>
        /// 获取或设置显示掩码
        /// </summary>
        public String DisplayMask
        {
            get { return this.displayMask; }
            set { this.displayMask = value; }
        }

        /// <summary>
        /// 获取或设置规则表达式
        /// </summary>
        public String RegularExpression
        {
            get { return this.regularExpression; }
            set { this.regularExpression = value; }
        }

        /// <summary>
        /// 获取或设置验证开始日期
        /// </summary>
        /// 
        public DateTime ValidFrom
        {
            get { return this.validFrom; }
            set { this.validFrom = value; }
        }         

        /// <summary>
        /// 获取或设置验证截至日期
        /// </summary>
        /// 
        public DateTime ValidTo
        {
            get { return this.validTo; }
            set { this.validTo = value; }
        }        

        /// <summary>
        /// 获取或设置最小长度
        /// </summary>
        public Int32 MinLength
        {
            get { return this.minLength; }
            set { this.minLength = value; }
        }

        /// <summary>
        /// 获取或设置最大长度
        /// </summary>
        public Int32 MaxLength
        {
            get { return this.maxLength; }
            set { this.maxLength = value; }
        }        
    }
}