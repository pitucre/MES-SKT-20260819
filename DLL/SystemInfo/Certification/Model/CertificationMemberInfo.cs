using System;

namespace SKT.LeanMES.Certification.Model
{
    [Serializable]
    public class CertificationMemberInfo
    {
        private Int32 certificationMemberId;
        private Int32 userId;
        private Int32 certificationId;
        private DateTime expiration_Date;
        private DateTime certification_Date;
        private String warning_Sent;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        private String userName;
        private String certification;
        private String certtype;
        private String cName;
       

        /// <summary>
        /// 初始化 SKT.LeanMES.Certification.Model.CertificationMemberInfo 类的新实例。
        /// </summary>
        public CertificationMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Certification.Model.CertificationMemberInfo 类的新实例。
        /// </summary>
        /// <param name="certificationMemberId">用户岗位认证ID</param>
        /// <param name="userId">用户ID</param>
        /// <param name="certificationId">岗位认证ID</param>
        /// <param name="expiration_Date">过期日期</param>
        /// <param name="certification_Date">授权日期</param>
        /// <param name="warning_Sent">预警信息发送</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public CertificationMemberInfo(Int32 certificationMemberId, Int32 userId, Int32 certificationId, DateTime expiration_Date, 
            DateTime certification_Date, String warning_Sent, String remark, DateTime modifyDateTime, String modifyBy, 
            DateTime createDateTime, String createBy)
        {
            this.certificationMemberId = certificationMemberId;
            this.userId = userId;
            this.certificationId = certificationId;
            this.expiration_Date = expiration_Date;
            this.certification_Date = certification_Date;
            this.warning_Sent = warning_Sent;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置用户岗位认证ID
        /// </summary>
        public Int32 CertificationMemberId
        {
            get { return this.certificationMemberId; }
            set { this.certificationMemberId = value; }
        }

        /// <summary>
        /// 获取或设置用户ID
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
        }

        /// <summary>
        /// 获取或设置岗位认证ID
        /// </summary>
        public Int32 CertificationId
        {
            get { return this.certificationId; }
            set { this.certificationId = value; }
        }

        /// <summary>
        /// 获取或设置过期日期
        /// </summary>
        public DateTime Expiration_Date
        {
            get { return this.expiration_Date; }
            set { this.expiration_Date = value; }
        }

        /// <summary>
        /// 获取或设置授权日期
        /// </summary>
        public DateTime Certification_Date
        {
            get { return this.certification_Date; }
            set { this.certification_Date = value; }
        }

        /// <summary>
        /// 获取或设置预警信息发送
        /// </summary>
        public String Warning_Sent
        {
            get { return this.warning_Sent; }
            set { this.warning_Sent = value; }
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
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改者
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


        /// <summary>
        /// 用户名称
        /// </summary>
        public String UserName
        {
            get { return this.userName; }
            set { this.userName = value; }
        }

        /// <summary>
        /// 认证名称
        /// </summary>
        public String Certification
        {
            get { return this.certification; }
            set { this.certification = value; }
        }

        /// <summary>
        /// 认证类型
        /// </summary>
        public String CertType
        {
            get { return this.certtype; }
            set { this.certtype = value; }
        }
        public String CName
        {
            get { return this.cName; }
            set { this.cName = value; }
        }
     
    }
}