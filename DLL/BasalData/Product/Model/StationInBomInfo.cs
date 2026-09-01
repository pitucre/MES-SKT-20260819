using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class StationInBomInfo
    {
        private Int32 stationInBomId;
        private String organizationCode;
        private Int32 itemBomId;
        private Int32 itemBomChildId;
        private Int32 stationId;
        private Int32 state;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public string Station { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string BomName { get; set; }
        public int DataTypeId { get; set; }
        public string DataTypeName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationInBomInfo 类的新实例。
        /// </summary>
        public StationInBomInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationInBomInfo 类的新实例。
        /// </summary>
        /// <param name="stationInBomId">产品BOM的物料与工序关系表ID</param>
        /// <param name="organizationCode">ERP组织代码</param>
        /// <param name="itemBomId">产品BOM ID</param>
        /// <param name="itemBomChildId">产品BOM子表ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="state">状态：0、停用；1、启用</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public StationInBomInfo(Int32 stationInBomId, String organizationCode, Int32 itemBomId, Int32 itemBomChildId, 
            Int32 stationId, Int32 state, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.stationInBomId = stationInBomId;
            this.organizationCode = organizationCode;
            this.itemBomId = itemBomId;
            this.itemBomChildId = itemBomChildId;
            this.stationId = stationId;
            this.state = state;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置产品BOM的物料与工序关系表ID
        /// </summary>
        public Int32 StationInBomId
        {
            get { return this.stationInBomId; }
            set { this.stationInBomId = value; }
        }

        /// <summary>
        /// 获取或设置ERP组织代码
        /// </summary>
        public String OrganizationCode
        {
            get { return this.organizationCode; }
            set { this.organizationCode = value; }
        }

        /// <summary>
        /// 获取或设置产品BOM ID
        /// </summary>
        public Int32 ItemBomId
        {
            get { return this.itemBomId; }
            set { this.itemBomId = value; }
        }

        /// <summary>
        /// 获取或设置产品BOM子表ID
        /// </summary>
        public Int32 ItemBomChildId
        {
            get { return this.itemBomChildId; }
            set { this.itemBomChildId = value; }
        }

        /// <summary>
        /// 获取或设置工序ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置状态：0、停用；1、启用
        /// </summary>
        public Int32 State
        {
            get { return this.state; }
            set { this.state = value; }
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
    }
}