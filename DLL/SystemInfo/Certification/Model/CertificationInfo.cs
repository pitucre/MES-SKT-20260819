using System;

namespace SKT.LeanMES.Certification.Model
{
    [Serializable]
    public class CertificationInfo
    {
        private Int32 certificationId;
        private String certification;
        private String type;
        private String description;
        private Int32 renewalDays;
        private Int32 warningDays;
        private String expiration_Alarm_Event;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Certification.Model.CertificationInfo 类的新实例。
        /// </summary>
        public CertificationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Certification.Model.CertificationInfo 类的新实例。
        /// </summary>
        /// <param name="certificationId">认证ID</param>
        /// <param name="certification">认证名称</param>
        /// <param name="type">认证类型：Skill，Qualification，License分别对应Operation，Item和Resource（Equipment）</param>
        /// <param name="description">认证描述</param>
        /// <param name="renewalDays">有效期</param>
        /// <param name="warningDays">到期提前提醒天数</param>
        /// <param name="expiration_Alarm_Event">认证到期后需要进行的动作，如报错或者发送电子邮件等</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">最后修改日期</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public CertificationInfo(Int32 certificationId, String certification, String type, String description, 
            Int32 renewalDays, Int32 warningDays, String expiration_Alarm_Event, String remark, DateTime modifyDateTime, 
            String modifyBy, DateTime createDateTime, String createBy)
        {
            this.certificationId = certificationId;
            this.certification = certification;
            this.type = type;
            this.description = description;
            this.renewalDays = renewalDays;
            this.warningDays = warningDays;
            this.expiration_Alarm_Event = expiration_Alarm_Event;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置认证ID
        /// </summary>
        public Int32 CertificationId
        {
            get { return this.certificationId; }
            set { this.certificationId = value; }
        }

        /// <summary>
        /// 获取或设置认证名称
        /// </summary>
        public String Certification
        {
            get { return this.certification; }
            set { this.certification = value; }
        }

        /// <summary>
        /// 获取或设置认证类型：Skill，Qualification，License分别对应Operation，Item和Resource（Equipment）
        /// </summary>
        public String Type
        {
            get { return this.type; }
            set { this.type = value; }
        }

        /// <summary>
        /// 获取或设置认证描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置有效期
        /// </summary>
        public Int32 RenewalDays
        {
            get { return this.renewalDays; }
            set { this.renewalDays = value; }
        }

        /// <summary>
        /// 获取或设置到期提前提醒天数
        /// </summary>
        public Int32 WarningDays
        {
            get { return this.warningDays; }
            set { this.warningDays = value; }
        }

        /// <summary>
        /// 获取或设置认证到期后需要进行的动作，如报错或者发送电子邮件等
        /// </summary>
        public String Expiration_Alarm_Event
        {
            get { return this.expiration_Alarm_Event; }
            set { this.expiration_Alarm_Event = value; }
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
        /// 获取或设置最后修改日期
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置最后修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
    }
}