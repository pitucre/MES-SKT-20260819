using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class ContainerDocumentInfo
    {
        private Int32 containerDocumentId;
        private Int32 containerId;
        private Int32 documentID;
        private Decimal seauence;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        private String documentName;

      

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerDocumentInfo 类的新实例。
        /// </summary>
        public ContainerDocumentInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerDocumentInfo 类的新实例。
        /// </summary>
        /// <param name="containerDocumentId">ContainerDocument Unique Identifier</param>
        /// <param name="containerId">Basal_Container.ContainerID</param>
        /// <param name="documentID">Basal_Document.DocumentID</param>
        /// <param name="seauence">需要打印的文档的顺序</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public ContainerDocumentInfo(Int32 containerDocumentId, Int32 containerId, Int32 documentID, Decimal seauence, 
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.containerDocumentId = containerDocumentId;
            this.containerId = containerId;
            this.documentID = documentID;
            this.seauence = seauence;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置ContainerDocument Unique Identifier
        /// </summary>
        public Int32 ContainerDocumentId
        {
            get { return this.containerDocumentId; }
            set { this.containerDocumentId = value; }
        }

        /// <summary>
        /// 获取或设置Basal_Container.ContainerID
        /// </summary>
        public Int32 ContainerId
        {
            get { return this.containerId; }
            set { this.containerId = value; }
        }

        /// <summary>
        /// 获取或设置Basal_Document.DocumentID
        /// </summary>
        public Int32 DocumentID
        {
            get { return this.documentID; }
            set { this.documentID = value; }
        }

        /// <summary>
        /// 获取或设置需要打印的文档的顺序
        /// </summary>
        public Decimal Seauence
        {
            get { return this.seauence; }
            set { this.seauence = value; }
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
        /// 获取或设置修改人
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
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DocumentName
        {
            get { return this.documentName; }
            set { this.documentName = value; }
        }

 

        
    }
}