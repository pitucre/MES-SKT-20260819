using System;

namespace SKT.LeanMES.MaterialConfig.Model
{
    [Serializable]
    public class MaterialIQCConfigInfo
    {
        private Int32 iD;
        private Int32 checkTypeId;
        private String checkType;
        private Int32 materialStatusId;
        private String materialStatus;
        private String remark;
        private Boolean isGlobal;

        private Int32 iQCStatusId;
        private String iQCStatus;
        private Boolean isStorage;

        public String CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public String ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialIQCConfigInfo 类的新实例。
        /// </summary>
        public MaterialIQCConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialIQCConfigInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="checkTypeId">检验类型id</param>
        /// <param name="checkType">检验类型</param>
        /// <param name="materialStatusId">物料状态id(对应Prod_MateirialStatus)</param>
        /// <param name="materialStatus"></param>
        /// <param name="remark">备注</param>
        public MaterialIQCConfigInfo(Int32 iD, Int32 checkTypeId, String checkType, Int32 materialStatusId,
            String materialStatus, String remark, Boolean isGlobal, Boolean isStorage)
        {
            this.iD = iD;
            this.checkTypeId = checkTypeId;
            this.checkType = checkType;
            this.materialStatusId = materialStatusId;
            this.materialStatus = materialStatus;
            this.remark = remark;
            this.isGlobal = isGlobal;
            this.isStorage = isStorage;
        }

        public Boolean IsStorage
        {
            get { return this.isStorage; }
            set { this.isStorage = value; }
        }

        public  Boolean IsGlobal
        {
            get { return this.isGlobal; }
            set { this.isGlobal = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IQCStatusId
        {
            get { return this.iQCStatusId; }
            set { this.iQCStatusId = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String IQCStatus
        {
            get { return this.iQCStatus; }
            set { this.iQCStatus = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置检验类型id
        /// </summary>
        public Int32 CheckTypeId
        {
            get { return this.checkTypeId; }
            set { this.checkTypeId = value; }
        }

        /// <summary>
        /// 获取或设置检验类型
        /// </summary>
        public String CheckType
        {
            get { return this.checkType; }
            set { this.checkType = value; }
        }

        /// <summary>
        /// 获取或设置物料状态id(对应Prod_MateirialStatus)
        /// </summary>
        public Int32 MaterialStatusId
        {
            get { return this.materialStatusId; }
            set { this.materialStatusId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MaterialStatus
        {
            get { return this.materialStatus; }
            set { this.materialStatus = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}