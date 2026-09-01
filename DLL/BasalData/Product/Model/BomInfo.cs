using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class BomInfo
    {
        private Int32 bomId;
        private String bomName;
        private String revision;
        private String bomDesc;
        private Int32 status;
        private Boolean isCurrentRev;
        private Int32 copiedFromBomID;
        private Boolean hasBeenReleased;
        private DateTime effStartDate;
        private DateTime effEndDate;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String bomStatus_Choose;//for choosePage

        public String IsMESadd { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.BomInfo 类的新实例。
        /// </summary>
        public BomInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.BomInfo 类的新实例。
        /// </summary>
        /// <param name="bomId">BOM Unique Identifier</param>
        /// <param name="bomName">BOM名字。</param>
        /// <param name="revision">BOM版本。</param>
        /// <param name="bomDesc">描述。</param>
        /// <param name="status">状态。</param>
        /// <param name="isCurrentRev">是否为当前版本。</param>
        /// <param name="copiedFromBomID">复制BOM源ID。用于做BOM复制时使用</param>
        /// <param name="hasBeenReleased">是否已生产。当绑定该BOM的产品或者工单开始生产时，BOM HasBeenReleased状态改变，BOM不可修改</param>
        /// <param name="effStartDate">BOM生效时间</param>
        /// <param name="effEndDate">BOM失效时间</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public BomInfo(Int32 bomId, String bomName, String revision, String bomDesc, 
            Int32 status, Boolean isCurrentRev, Int32 copiedFromBomID, Boolean hasBeenReleased, DateTime effStartDate, 
            DateTime effEndDate, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            String remark)
        {
            this.bomId = bomId;
            this.bomName = bomName;
            this.revision = revision;
            this.bomDesc = bomDesc;
            this.status = status;
            this.isCurrentRev = isCurrentRev;
            this.copiedFromBomID = copiedFromBomID;
            this.hasBeenReleased = hasBeenReleased;
            this.effStartDate = effStartDate;
            this.effEndDate = effEndDate;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置BOM Unique Identifier
        /// </summary>
        public Int32 BomId
        {
            get { return this.bomId; }
            set { this.bomId = value; }
        }

        /// <summary>
        /// 获取或设置BOM名字。
        /// </summary>
        public String BomName
        {
            get { return this.bomName; }
            set { this.bomName = value; }
        }

        /// <summary>
        /// 获取或设置BOM版本。
        /// </summary>
        public String Revision
        {
            get { return this.revision; }
            set { this.revision = value; }
        }

        /// <summary>
        /// 获取或设置描述。
        /// </summary>
        public String BomDesc
        {
            get { return this.bomDesc; }
            set { this.bomDesc = value; }
        }

        /// <summary>
        /// 获取或设置状态。
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置是否为当前版本。
        /// </summary>
        public Boolean IsCurrentRev
        {
            get { return this.isCurrentRev; }
            set { this.isCurrentRev = value; }
        }

        /// <summary>
        /// 获取或设置复制BOM源ID。用于做BOM复制时使用
        /// </summary>
        public Int32 CopiedFromBomID
        {
            get { return this.copiedFromBomID; }
            set { this.copiedFromBomID = value; }
        }

        /// <summary>
        /// 获取或设置是否已生产。当绑定该BOM的产品或者工单开始生产时，BOM HasBeenReleased状态改变，BOM不可修改
        /// </summary>
        public Boolean HasBeenReleased
        {
            get { return this.hasBeenReleased; }
            set { this.hasBeenReleased = value; }
        }

        /// <summary>
        /// 获取或设置BOM生效时间
        /// </summary>
        public DateTime EffStartDate
        {
            get { return this.effStartDate; }
            set { this.effStartDate = value; }
        }

        /// <summary>
        /// 获取或设置BOM失效时间
        /// </summary>
        public DateTime EffEndDate
        {
            get { return this.effEndDate; }
            set { this.effEndDate = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        public String BomStatus_Choose
        {
            get { return bomStatus_Choose; }
            set { bomStatus_Choose = value; }
        }
    }
}