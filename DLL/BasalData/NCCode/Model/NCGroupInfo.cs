using System;

namespace SKT.LeanMES.NCCode.Model
{
    [Serializable]
    public class NCGroupInfo
    {
        private Int32 nCGroupId;
        private String nCGroupName;
        private Boolean isAllOperations;
        private String description;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.NCCode.Model.NCGroupInfo 类的新实例。
        /// </summary>
        public NCGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.NCCode.Model.NCGroupInfo 类的新实例。
        /// </summary>
        /// <param name="nCGroupId">Unique Identifier</param>
        /// <param name="nCGroupName">分组名称</param>
        /// <param name="isAllOperations">是否所有站位可见</param>
        /// <param name="description">描述</param>
        /// <param name="modifyDateTime">最后修改时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        public NCGroupInfo(Int32 nCGroupId, String nCGroupName, Boolean isAllOperations, String description, 
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.nCGroupId = nCGroupId;
            this.nCGroupName = nCGroupName;
            this.isAllOperations = isAllOperations;
            this.description = description;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 NCGroupId
        {
            get { return this.nCGroupId; }
            set { this.nCGroupId = value; }
        }

        /// <summary>
        /// 获取或设置分组名称
        /// </summary>
        public String NCGroupName
        {
            get { return this.nCGroupName; }
            set { this.nCGroupName = value; }
        }

        /// <summary>
        /// 获取或设置是否所有站位可见
        /// </summary>
        public Boolean IsAllOperations
        {
            get { return this.isAllOperations; }
            set { this.isAllOperations = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置最后修改时间
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
    }
}