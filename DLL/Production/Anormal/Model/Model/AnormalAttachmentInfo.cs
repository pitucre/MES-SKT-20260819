using System;

namespace SKT.LeanMES.ProdAnormal.Model
{
    [Serializable]
    public class AnormalAttachmentInfo
    {
        private Int32 anormalAttachmentId;
        private Int32 anormalId;
        private String attachmentName;
        private String attachmentPhysicalName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalAttachmentInfo 类的新实例。
        /// </summary>
        public AnormalAttachmentInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.AnormalAttachmentInfo 类的新实例。
        /// </summary>
        /// <param name="anormalAttachmentId">异常附件ID</param>
        /// <param name="anormalId">异常ID</param>
        /// <param name="attachmentName">附件名</param>
        /// <param name="attachmentPhysicalName">附件物理名称</param>
        /// <param name="createBy">上传人</param>
        /// <param name="createDateTime">上传时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public AnormalAttachmentInfo(Int32 anormalAttachmentId, Int32 anormalId, String attachmentName, String attachmentPhysicalName, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.anormalAttachmentId = anormalAttachmentId;
            this.anormalId = anormalId;
            this.attachmentName = attachmentName;
            this.attachmentPhysicalName = attachmentPhysicalName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置异常附件ID
        /// </summary>
        public Int32 AnormalAttachmentId
        {
            get { return this.anormalAttachmentId; }
            set { this.anormalAttachmentId = value; }
        }

        /// <summary>
        /// 获取或设置异常ID
        /// </summary>
        public Int32 AnormalId
        {
            get { return this.anormalId; }
            set { this.anormalId = value; }
        }

        /// <summary>
        /// 获取或设置附件名
        /// </summary>
        public String AttachmentName
        {
            get { return this.attachmentName; }
            set { this.attachmentName = value; }
        }

        /// <summary>
        /// 获取或设置附件物理名称
        /// </summary>
        public String AttachmentPhysicalName
        {
            get { return this.attachmentPhysicalName; }
            set { this.attachmentPhysicalName = value; }
        }

        /// <summary>
        /// 获取或设置上传人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置上传时间
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
    }
}