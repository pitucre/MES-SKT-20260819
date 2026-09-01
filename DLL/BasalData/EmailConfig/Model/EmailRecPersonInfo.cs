using System;

namespace SKT.LeanMES.EmailConfig.Model
{
    [Serializable]
    public class EmailRecPersonInfo
    {
        private Int32 recId;
        private String mailAddress;
        private String personName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String recEmailType;

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailRecPersonInfo 类的新实例。
        /// </summary>
        public EmailRecPersonInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailRecPersonInfo 类的新实例。
        /// </summary>
        /// <param name="recId"></param>
        /// <param name="mailAddress"></param>
        /// <param name="personName"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EmailRecPersonInfo(Int32 recId, String mailAddress, String personName, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.recId = recId;
            this.mailAddress = mailAddress;
            this.personName = personName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RecId
        {
            get { return this.recId; }
            set { this.recId = value; }
        }

        /// <summary>
        /// 获取或设置 邮箱地址
        /// </summary>
        public String MailAddress
        {
            get { return this.mailAddress; }
            set { this.mailAddress = value; }
        }

        /// <summary>
        /// 获取或设置 收件人名
        /// </summary> 
        public String PersonName
        {
            get { return this.personName; }
            set { this.personName = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        
        
        /// <summary>
        /// 获取或设置 接收邮件的类型
        /// </summary>
        public String RecEmailType
        {
            get { return this.recEmailType; }
            set { this.recEmailType = value; }
        }
        
    }

    public class RecEmailTypeDictionary
    {
        private int id;
        private string name;
        private string description;
        private string notBind;

        public RecEmailTypeDictionary() { }

        /// <summary>
        /// 字典id
        /// </summary>
        public int Id
        {
            set { this.id = value; }
            get { return this.id; }
        }

        /// <summary>
        /// 名称
        /// </summary>
        public string Name
        {
            set { this.name = value; }
            get { return this.name; }
        }

        /// <summary>
        /// 描述
        /// </summary>
        public string Description
        {
            set { this.description = value; }
            get { return this.description; }
        }

        
        /// <summary>
        /// 此类别是否关联了这个收件人  "1" 没关联
        /// </summary>
        public string NotBind
        {
            set { this.notBind = value; }
            get { return this.notBind; }
        }
    }
}