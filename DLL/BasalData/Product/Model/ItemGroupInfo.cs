using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemGroupInfo
    {
        private Int32 itemGroupId;
        private String groupName;
        private String groupDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ItemGroupInfo 类的新实例。
        /// </summary>
        public ItemGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Product.Model.ItemGroupInfo 类的新实例。
        /// </summary>
        /// <param name="itemGroupId">Unique Identifier</param>
        /// <param name="groupName">产品组名称。</param>
        /// <param name="groupDesc">产品组描述。</param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">说明。</param>
        public ItemGroupInfo(Int32 itemGroupId, String groupName, String groupDesc, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.itemGroupId = itemGroupId;
            this.groupName = groupName;
            this.groupDesc = groupDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ItemGroupId
        {
            get { return this.itemGroupId; }
            set { this.itemGroupId = value; }
        }

        /// <summary>
        /// 获取或设置产品组名称。
        /// </summary>
        public String GroupName
        {
            get { return this.groupName; }
            set { this.groupName = value; }
        }

        /// <summary>
        /// 获取或设置产品组描述。
        /// </summary>
        public String GroupDesc
        {
            get { return this.groupDesc; }
            set { this.groupDesc = value; }
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
        /// 获取或设置说明。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}