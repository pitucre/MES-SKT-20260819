using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class ItemCategoryInfo
    {
        private Int32 itemCategoryId;
        private Int32 parentId;
        private String categoryName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        public string ParentName { get; set; }
        public string CategoryCode { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemCategoryInfo 类的新实例。
        /// </summary>
        public ItemCategoryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ItemCategoryInfo 类的新实例。
        /// </summary>
        /// <param name="itemCategoryId">产品/物料管理分类表 ID</param>
        /// <param name="parentId">上级ID, -1表示当前为最顶级（大类）</param>
        /// <param name="categoryName">分类名称</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public ItemCategoryInfo(Int32 itemCategoryId, Int32 parentId, String categoryName, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.itemCategoryId = itemCategoryId;
            this.parentId = parentId;
            this.categoryName = categoryName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置产品/物料管理分类表 ID
        /// </summary>
        public Int32 ItemCategoryId
        {
            get { return this.itemCategoryId; }
            set { this.itemCategoryId = value; }
        }

        /// <summary>
        /// 获取或设置上级ID, -1表示当前为最顶级（大类）
        /// </summary>
        public Int32 ParentId
        {
            get { return this.parentId; }
            set { this.parentId = value; }
        }

        /// <summary>
        /// 获取或设置分类名称
        /// </summary>
        public String CategoryName
        {
            get { return this.categoryName; }
            set { this.categoryName = value; }
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
        /// 获取或设置创建时间
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

        /// <summary>
        /// 是否上料 1=是 0=否
        /// </summary>
        public int IsLoadMateril { get; set; }
    }
}