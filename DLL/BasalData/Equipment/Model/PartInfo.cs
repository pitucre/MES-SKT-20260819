using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class PartInfo
    {
        private Int32 partId;
        private String partName;
        private String partCode;
        private String partStand;
        private String partBrand;
        private Int32 partSupplierId;
        private DateTime factoryDate;
        private String partLive;
        private Int32 partStatus;
        private Int32 equimentId;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String supplierName;
        private String equimentName;
        private String equimentCode;
        private string equipmentTypeName;
        private string factoryName;
        private int optType;
        private string operationType;
        private int rid;


        public int Rid
        {
            get { return this.rid; }
            set { this.rid = value; }
        }

        public int OptType
        {
            get { return this.optType; }
            set { this.optType = value; }
        }
        public string OperationType
        {
            get { return this.operationType; }
            set { this.operationType = value; }
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PartInfo 类的新实例。
        /// </summary>
        public PartInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PartInfo 类的新实例。
        /// </summary>
        /// <param name="partId">部件id</param>
        /// <param name="partName">部件名称</param>
        /// <param name="partCode">部件编号</param>
        /// <param name="partStand">部件规格</param>
        /// <param name="partBrand">品牌</param>
        /// <param name="partSupplierId">供应商</param>
        /// <param name="factoryDate"></param>
        /// <param name="partLive"></param>
        /// <param name="partStatus">部件状态,0新购买、1维修中、2保养中、3故障中、4报废</param>
        /// <param name="equimentId">设备编号</param>
        /// <param name="remark">备注</param>
        public PartInfo(Int32 partId, String partName, String partCode, String partStand,
            String partBrand, Int32 partSupplierId, DateTime factoryDate, String partLive, Int32 partStatus,
            Int32 equimentId, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.partId = partId;
            this.partName = partName;
            this.partCode = partCode;
            this.partStand = partStand;
            this.partBrand = partBrand;
            this.partSupplierId = partSupplierId;
            this.factoryDate = factoryDate;
            this.partLive = partLive;
            this.partStatus = partStatus;
            this.equimentId = equimentId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PartInfo 类的新实例。
        /// </summary>
        /// <param name="partId">部件id</param>
        /// <param name="partName">部件名称</param>
        /// <param name="partCode">部件编号</param>
        /// <param name="partStand">部件规格</param>
        /// <param name="partBrand">品牌</param>
        /// <param name="partSupplierId">供应商</param>
        /// <param name="factoryDate"></param>
        /// <param name="partLive"></param>
        /// <param name="partStatus">部件状态,0新购买、1维修中、2保养中、3故障中、4报废</param>
        /// <param name="equimentId">设备编号</param>
        /// <param name="remark">备注</param>
        public PartInfo(Int32 partId, String partName, String partCode, String partStand,
            String partBrand, Int32 partSupplierId, DateTime factoryDate, String partLive, Int32 partStatus,
            Int32 equimentId, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark, String supplierName, String equimentName, String equimentCode)
        {
            this.partId = partId;
            this.partName = partName;
            this.partCode = partCode;
            this.partStand = partStand;
            this.partBrand = partBrand;
            this.partSupplierId = partSupplierId;
            this.factoryDate = factoryDate;
            this.partLive = partLive;
            this.partStatus = partStatus;
            this.equimentId = equimentId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.supplierName = supplierName;
            this.equimentName = equimentName;
            this.equimentCode = equimentCode;
        }

        
        /// <summary>
        /// 获取或设置部件id
        /// </summary>
        public Int32 PartId
        {
            get { return this.partId; }
            set { this.partId = value; }
        }

        /// <summary>
        /// 获取部件类别信息
        /// </summary>
        public string EquipmentTypeName
        {
            get { return this.equipmentTypeName; }
            set { this.equipmentTypeName = value; }
        }

        private int equipmentTypeId;
        /// <summary>
        /// 获取部件类别Id
        /// </summary>
        public int EquipmentTypeId
        {
            get { return this.equipmentTypeId; }
            set { this.equipmentTypeId = value; }
        }


        /// <summary>
        /// 获取工厂名称
        /// </summary>
        public string FactoryName
        {
            get { return this.factoryName; }
            set { this.factoryName = value; }
        }

        
        /// <summary>
        /// 获取或设置部件名称
        /// </summary>
        public String PartName
        {
            get { return this.partName; }
            set { this.partName = value; }
        }

        /// <summary>
        /// 获取或设置部件编号
        /// </summary>
        public String PartCode
        {
            get { return this.partCode; }
            set { this.partCode = value; }
        }

        /// <summary>
        /// 获取或设置部件规格
        /// </summary>
        public String PartStand
        {
            get { return this.partStand; }
            set { this.partStand = value; }
        }

        /// <summary>
        /// 获取或设置品牌
        /// </summary>
        public String PartBrand
        {
            get { return this.partBrand; }
            set { this.partBrand = value; }
        }

        /// <summary>
        /// 获取或设置供应商
        /// </summary>
        public Int32 PartSupplierId
        {
            get { return this.partSupplierId; }
            set { this.partSupplierId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime FactoryDate
        {
            get { return this.factoryDate; }
            set { this.factoryDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PartLive
        {
            get { return this.partLive; }
            set { this.partLive = value; }
        }

        /// <summary>
        /// 获取或设置部件状态,0新购买、1维修中、2保养中、3故障中、4报废
        /// </summary>
        public Int32 PartStatus
        {
            get { return this.partStatus; }
            set { this.partStatus = value; }
        }

        /// <summary>
        /// 获取或设置设备编号
        /// </summary>
        public Int32 EquimentId
        {
            get { return this.equimentId; }
            set { this.equimentId = value; }
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
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置供应商名
        /// </summary>
        public String SupplierName
        {
            get { return this.supplierName; }
            set { this.supplierName = value; }
        }
        /// <summary>
        /// 获取或设置设备名
        /// </summary>
        public String EquimentName
        {
            get { return this.equimentName; }
            set { this.equimentName = value; }
        }
        /// <summary>
        /// 获取或设置设备编号
        /// </summary>
        public String EquimentCode
        {
            get { return this.equimentCode; }
            set { this.equimentCode = value; }
        }

        /// <summary>
        /// 获取或设置设备编号
        /// </summary>
        public String EquipmentCode { get; set; }

        /// <summary>
        /// 获取或设置设备名
        /// </summary>
        public String EquipmentName { get; set; }
        /// <summary>
        /// 排序Id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// 最小库存
        /// </summary>
        public int MinStock { get; set; }

        /// <summary>
        /// 最大库存
        /// </summary>
        public int MaxStock { get; set; }
        /// <summary>
        /// 当前库存
        /// </summary>
        public int CurrentStock { get; set; }

        /// <summary>
        /// 已用库存
        /// </summary>
        public int UseStock { get; set; }

        /// <summary>
        /// 存放位置
        /// </summary>
        public int Position { get; set; }


        /// <summary>
        /// 存放位置
        /// </summary>
        public string PositionName { get; set; }
        /// <summary>
        /// 工厂Id
        /// </summary>
        public int FactoryId { get; set; }

        /// <summary>
        /// 计量单位
        /// </summary>
        public string UnitName { get; set; }

        /// <summary>
        /// 可用数量
        /// </summary>
        public int Qty { get; set; }
    }
}