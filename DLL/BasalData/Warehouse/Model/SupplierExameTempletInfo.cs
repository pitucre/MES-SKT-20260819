using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class SupplierExameTempletInfo
    {
        private Int32 supplierExameTempletID;
        private String supplierExameTempletCode;
        private String supplierExameTempletName;
        private String isEnable;
        private String description;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String supplierExameTempletType;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletInfo 类的新实例。
        /// </summary>
        public SupplierExameTempletInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SupplierExameTempletInfo 类的新实例。
        /// </summary>
        /// <param name="supplierExameTempletID">考核模板ID</param>
        /// <param name="supplierExameTempletCode">考核模板编号</param>
        /// <param name="supplierExameTempletName">考核模板名称</param>
        /// <param name="isEnable">是否启用(0:不启用,1:启用)</param>
        /// <param name="description">描述</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="supplierExameTempletType">考核模板类型(月度,季度,年度)</param>
        public SupplierExameTempletInfo(Int32 supplierExameTempletID, String supplierExameTempletCode, String supplierExameTempletName, String isEnable,
            String description, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String supplierExameTempletType)
        {
            this.supplierExameTempletID = supplierExameTempletID;
            this.supplierExameTempletCode = supplierExameTempletCode;
            this.supplierExameTempletName = supplierExameTempletName;
            this.isEnable = isEnable;
            this.description = description;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.supplierExameTempletType = supplierExameTempletType;
        }

        /// <summary>
        /// 获取或设置考核模板ID
        /// </summary>
        public Int32 SupplierExameTempletID
        {
            get { return this.supplierExameTempletID; }
            set { this.supplierExameTempletID = value; }
        }

        /// <summary>
        /// 获取或设置考核模板编号
        /// </summary>
        public String SupplierExameTempletCode
        {
            get { return this.supplierExameTempletCode; }
            set { this.supplierExameTempletCode = value; }
        }

        /// <summary>
        /// 获取或设置考核模板名称
        /// </summary>
        public String SupplierExameTempletName
        {
            get { return this.supplierExameTempletName; }
            set { this.supplierExameTempletName = value; }
        }

        /// <summary>
        /// 获取或设置是否启用(0:不启用,1:启用)
        /// </summary>
        public String IsEnable
        {
            get { return this.isEnable; }
            set { this.isEnable = value; }
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
        /// 获取或设置考核模板类型(月度,季度,年度)
        /// </summary>
        public String SupplierExameTempletType
        {
            get { return this.supplierExameTempletType; }
            set { this.supplierExameTempletType = value; }
        }

        public int IsAllSupplier { set; get; }
    }
}