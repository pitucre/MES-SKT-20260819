using System;

namespace SKT.LeanMES.Container.Model
{
    [Serializable]
    public class ContainerDataInfo
    {
        private Int32 cCDataId;
        private String containerNumber;
        private Int32 cCID;
        private Int32 statusId;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        public String OrderNO { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerDataInfo 类的新实例。
        /// </summary>
        public ContainerDataInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Container.Model.ContainerDataInfo 类的新实例。
        /// </summary>
        /// <param name="cCDataId"></param>
        /// <param name="containerNumber"></param>
        /// <param name="cCID"></param>
        /// <param name="statusId"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public ContainerDataInfo(Int32 cCDataId, String containerNumber, Int32 cCID, Int32 statusId, 
            DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy)
        {
            this.cCDataId = cCDataId;
            this.containerNumber = containerNumber;
            this.cCID = cCID;
            this.statusId = statusId;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CCDataId
        {
            get { return this.cCDataId; }
            set { this.cCDataId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ContainerNumber
        {
            get { return this.containerNumber; }
            set { this.containerNumber = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CCID
        {
            get { return this.cCID; }
            set { this.cCID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StatusId
        {
            get { return this.statusId; }
            set { this.statusId = value; }
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
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
    }
}