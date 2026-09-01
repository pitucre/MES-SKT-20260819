using System;

namespace SKT.LeanMES.EmailConfig.Model
{
    [Serializable]
    public class EmailMapRecPersonInfo
    {
        private Int32 eRecId;
        private Int32 recId;
        private String emailTypeName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailMapRecPersonInfo 类的新实例。
        /// </summary>
        public EmailMapRecPersonInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.EmailConfig.Model.EmailMapRecPersonInfo 类的新实例。
        /// </summary>
        /// <param name="eRecId"></param>
        /// <param name="recId"></param>
        /// <param name="emailTypeName"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EmailMapRecPersonInfo(Int32 eRecId, Int32 recId, String emailTypeName, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.eRecId = eRecId;
            this.recId = recId;
            this.emailTypeName = emailTypeName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取 邮件类型与收件人表的主键
        /// </summary>
        public Int32 ERecId
        {
            get { return this.eRecId; }
            set { this.eRecId = value; }
        }

        /// <summary>
        /// 获取或设置 收件人表的主键
        /// </summary>
        public Int32 RecId
        {
            get { return this.recId; }
            set { this.recId = value; }
        }

        /// <summary>
        /// 获取或设置 邮件类型
        /// </summary>
        public String EmailTypeName
        {
            get { return this.emailTypeName; }
            set { this.emailTypeName = value; }
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
    }
}