using System;

namespace SKT.LeanMES.Product.Model
{
    [Serializable]
    public class StationMaterielInfo
    {
        private Int32 stationMatId;
        private String organizationCode;
        private String itemCode;
        private Int32 stationId;
        private Int32 state;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public string Station { get; set; }
        public string ItemName { get; set; }
        public string CategoryOne { get; set; }
        public string CategoryTwo { get; set; }
        public string CategoryThree { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationMaterielInfo 类的新实例。
        /// </summary>
        public StationMaterielInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationMaterielInfo 类的新实例。
        /// </summary>
        /// <param name="stationMatId">工序与物料关系表ID</param>
        /// <param name="organizationCode">ERP组织代码</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="state">状态：0、停用；1、启用</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public StationMaterielInfo(Int32 stationMatId, String organizationCode, String itemCode, Int32 stationId, 
            Int32 state, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.stationMatId = stationMatId;
            this.organizationCode = organizationCode;
            this.itemCode = itemCode;
            this.stationId = stationId;
            this.state = state;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置工序与物料关系表ID
        /// </summary>
        public Int32 StationMatId
        {
            get { return this.stationMatId; }
            set { this.stationMatId = value; }
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
        /// 获取或设置物料编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
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