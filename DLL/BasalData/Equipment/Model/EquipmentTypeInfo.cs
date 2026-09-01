using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentTypeInfo
    {
        private Int32 equipmentTypeId;
        private String equipmentTypeCode;
        private String equipmentTypeName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private int pId;
        private int level;
        private int isSystem;
        private string parentTypeName;
        private Boolean _isLoading;
        private Boolean _isOffLine;
        private Boolean _isScanPos;
        /// <summary>
        /// 初始化 SKT.MES.Model.TYPEInfo 类的新实例。
        /// </summary>
        public EquipmentTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.TYPEInfo 类的新实例。
        /// </summary>
        /// <param name="eQPTTypeID"></param>
        /// <param name="eQPTTypeCode">设备类型编码</param>
        /// <param name="eQPTTypeName">设备类型名称</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public EquipmentTypeInfo(Int32 eQPTTypeID, String eQPTTypeCode, String eQPTTypeName, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark, int pID,
            int iLenvel, int issystem, string sParentTypename, Boolean isLoading, Boolean isOffLine, Boolean isScanPos)
        {
            this.equipmentTypeId = eQPTTypeID;
            this.equipmentTypeCode = eQPTTypeCode;
            this.equipmentTypeName = eQPTTypeName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.pId = pID;
            this.level = iLenvel;
            this.isSystem = issystem;
            this.parentTypeName = sParentTypename;
            this._isLoading = isLoading;
            this._isOffLine = isOffLine;
            this._isScanPos = isScanPos;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string ParentTypeName
        {
            get { return this.parentTypeName; }
            set { this.parentTypeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 IsSystem
        {
            get { return this.isSystem; }
            set { this.isSystem = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Level
        {
            get { return this.level; }
            set { this.level = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PID
        {
            get { return this.pId; }
            set { this.pId = value; }
            
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentTypeId
        {
            get { return this.equipmentTypeId; }
            set { this.equipmentTypeId = value; }
        }

        /// <summary>
        /// 获取或设置设备类型编码
        /// </summary>
        public String EquipmentTypeCode
        {
            get { return this.equipmentTypeCode; }
            set { this.equipmentTypeCode = value; }
        }

        /// <summary>
        /// 获取或设置设备类型名称
        /// </summary>
        public String EquipmentTypeName
        {
            get { return this.equipmentTypeName; }
            set { this.equipmentTypeName = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
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
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 是否上料
        /// </summary>
        public Boolean IsLoading
        {
            get { return this._isLoading; }
            set { this._isLoading = value; }
        }

        /// <summary>
        /// 是否离线备料
        /// </summary>
        public Boolean IsOffLine
        {
            get { return this._isOffLine; }
            set { this._isOffLine = value; }
        }

        public Boolean IsScanPos
        {
            get { return this._isScanPos; }
            set { this._isScanPos = value; }
        }

        /*树形图显示作用*/
        public string name { get { return EquipmentTypeName; } }

        public int id { get { return EquipmentTypeId; } }
        public Boolean isParent { get; set; }

    }
}