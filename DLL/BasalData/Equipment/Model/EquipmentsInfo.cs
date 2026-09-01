using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentsInfo
    {
        public string Value01 { get; set; }
        public string Value02 { get; set; }
        public string Value03 { get; set; }
        public string Value04 { get; set; }
        public string ItemCodes { get; set; }
        public string ItemNames { get; set; }

        private Int32 equipmentId;
        private String equipmentCode;
        private String equipmentName;
        private Int32 equipmentTypeId;
        private String equipmentTypeName;
        private String equipmentModel;
        private DateTime produceDate;
        private Int32 status;
        private String statusDesc;
        private Int32 lineId;
        private String lineName;
        private Int32 stationId;
        private String stationName;
        private DateTime factoryDate;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String venCode;

        //add by wenshun,设备兼容钢网，刮刀
        private string _ParentTypeName;
        private string _Position;
        private string _VendorBarcode;
        private decimal _Thick;
        private int _WarningCount;
        private int _UseCount;
        private int _StandarLive;
        private string _CurPosition;
        private int _InOrOut;
        private int _IsClear;
        private string _VendorName;
        private int _ParentTypeId;

        //add by wenshun,增加机器在线别上的序列号，供应商名称
        private Int32 sequenceNo;
        /// <summary>
        /// 上级类型Id
        /// </summary>
        public int ParentTypeId
        {
            get { return this._ParentTypeId; }
            set { this._ParentTypeId = value; }
        }

        /// <summary>
        /// 设备类型名称
        /// </summary>
        public String EquipmentTypeName
        {
            get { return this.equipmentTypeName; }
            set { this.equipmentTypeName = value; }
        }

        /// <summary>
        /// 状态描述
        /// </summary>
        public String StatusDesc
        {
            get { return this.statusDesc; }
            set { this.statusDesc = value; }
        }

        /// <summary>
        /// 产线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 工位名
        /// </summary>
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }

        /// <summary>
        /// 获取或设置 设备id
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }

        /// <summary>
        /// 获取或设置设备编码
        /// </summary>
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }

        /// <summary>
        /// 获取或设置设备名称
        /// </summary>
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        /// <summary>
        /// 获取或设置设备类型ID
        /// </summary>
        public Int32 EquipmentTypeId
        {
            get { return this.equipmentTypeId; }
            set { this.equipmentTypeId = value; }
        }

        /// <summary>
        /// 获取或设置设备型号
        /// </summary>
        public String EquipmentModel
        {
            get { return this.equipmentModel; }
            set { this.equipmentModel = value; }
        }

        /// <summary>
        /// 获取或设置设备生产日期
        /// </summary>
        public DateTime ProduceDate
        {
            get { return this.produceDate; }
            set { this.produceDate = value; }
        }

        /// <summary>
        /// 获取或设置设备状态 标识
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置站位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置入厂日期。
        /// </summary>
        public DateTime FactoryDate
        {
            get { return this.factoryDate; }
            set { this.factoryDate = value; }
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
        /// 厂商编号
        /// </summary>
        public String VenCode
        {
            get { return this.venCode; }
            set { this.venCode = value; }
        }
        /// <summary>
        /// 供应商名称
        /// </summary>
        public string VendorName
        {
            get { return this._VendorName; }
            set { this._VendorName = value; }
        }
        /// <summary>
        /// 机器在线别上的序列号
        /// </summary>
        public Int32 SequenceNo
        {
            get { return this.sequenceNo; }
            set { this.sequenceNo = value; }
        }
        /// <summary>
        /// 上级设备类型名称
        /// </summary>
        public string ParentTypeName
        {
            get { return this._ParentTypeName; }
            set { this._ParentTypeName = value; }
        }
        /// <summary>
        /// 库位
        /// </summary>
        public string Position
        {
            set { this._Position = value; }
            get { return this._Position; }
        }
        /// <summary>
        /// 供应商条码编号
        /// </summary>
        public string VendorBarcode
        {
            set { this._VendorBarcode = value; }
            get { return this._VendorBarcode; }
        }
        /// <summary>
        /// 厚度
        /// </summary>
        public decimal Thick
        {
            set { this._Thick = value; }
            get { return this._Thick; }
        }
        /// <summary>
        /// 预警次数
        /// </summary>
        public int WarningCount
        {
            set { this._WarningCount = value; }
            get { return this._WarningCount; }
        }
        /// <summary>
        /// 使用次数
        /// </summary>
        public int UseCount
        {
            set { this._UseCount = value; }
            get { return this._UseCount; }
        }
        /// <summary>
        /// 标准寿命（次数）
        /// </summary>
        public int StandarLive
        {
            set { this._StandarLive = value; }
            get { return this._StandarLive; }
        }
        /// <summary>
        /// 当前位置
        /// </summary>
        public string CurPosition
        {
            set { this._CurPosition = value; }
            get { return this._CurPosition; }
        }
        //private int InOrOut;
        public int InOrOut
        {
            set { this._InOrOut = value; }
            get { return this._InOrOut; }
        }
        /// <summary>
        /// 是否清洗
        /// </summary>
        public int IsClear
        {
            set { this._IsClear = value; }
            get { return this._IsClear; }
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.EQUIPMENTInfo 类的新实例。
        /// </summary>
        public EquipmentsInfo()
        {
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.EQUIPMENTInfo 类的新实例。
        /// </summary>
        public EquipmentsInfo(int iEquipmentId, string sEquipmentCode, string sEquipmentName, string sEquipmentTypeName, string sEquipmentModel,
         DateTime dProduceDate, string sStatus, string sLineName, string sStation, DateTime dFactoryDate, string sCreateBy, DateTime dCreateDateTime,
         string sModifyBy, DateTime dModifyDateTime, string sRemark, string sVenCode, string sParentTypeName, string sPosition, string sVendorBarcode,
         decimal iThick, int iWarningCount, int iUseCount, int iStandarLive, string sCurPosition, int iInOrOut, int iIsClear, string sVendorName, int iEquipmentTypeId,
         int iLineId, int iStationId)
        {
            this.equipmentId = iEquipmentId;
            this.equipmentCode = sEquipmentCode;
            this.equipmentName = sEquipmentName;
            this.equipmentTypeName = sEquipmentTypeName;
            this.equipmentModel = sEquipmentModel;
            this.produceDate = dProduceDate;
            this.statusDesc = sStatus;
            this.lineName = sLineName;
            this.stationName = sStation;
            this.factoryDate = dFactoryDate;
            this.createBy = sCreateBy;
            this.createDateTime = dCreateDateTime;
            this.modifyBy = sModifyBy;
            this.modifyDateTime = dModifyDateTime;
            this.remark = sRemark;
            this.venCode = sVenCode;
            this._ParentTypeName = sParentTypeName;
            this._Position = sPosition;
            this._VendorBarcode = sVendorBarcode;
            this._Thick = iThick;
            this._WarningCount = iWarningCount;
            this._UseCount = iUseCount;
            this._StandarLive = iStandarLive;
            this.CurPosition = sCurPosition;
            this._InOrOut = iInOrOut;
            this._IsClear = iIsClear;
            this._VendorName = sVendorName;
            this.equipmentTypeId = iEquipmentTypeId;
            this.lineId = iLineId;
            this.stationId = iStationId;
        }

        /// <summary>
        /// 购置方式
        /// </summary>
        public int Purchase { get; set; }
        /// <summary>
        /// 单位
        /// </summary>
        public string UnitName { get; set; }
        /// <summary>
        /// 保管部门
        /// </summary>
        public string CareDepNo { get; set; }
        /// <summary>
        /// 保管人
        /// </summary>
        public string CareBy { get; set; }

        public string DepartName { get; set; }

        /// <summary>
        /// 图片名称
        /// </summary>
        public string PictureName { get; set; }

        public string PositionName { get; set; }

        /// <summary>
        /// 供应商编码
        /// </summary>
        public string SupplierCode { get; set; }

        /// <summary>
        /// 供应商名称
        /// </summary>
        public string SupplierName { get; set; }

        /// <summary>
        /// 保修期
        /// </summary>
        public int GuaranteeDay { get; set; }

        /// <summary>
        /// 过保日期
        /// </summary>
        public DateTime OverGuaranteeTime { get; set; }

        /// <summary>
        /// 资产编号
        /// </summary>
        public string AssetNumber { get; set; }
        /// <summary>
        /// 迈科钢网刮刀规格
        /// </summary>
        public string MKSpec { get; set; }
        /// <summary>
        /// 迈科钢网刮刀数量
        /// </summary>
        public string MKQTY { get; set; }
        /// <summary>
        /// 迈科钢网刮刀使用工艺
        /// </summary>
        public string MKUsingTechnology { get; set; }
        /// <summary>
        /// 迈科钢网刮刀使用类型
        /// </summary>
        public string MKUsingType { get; set; }
        /// <summary>
        /// 迈科钢网刮刀工艺要求
        /// </summary>
        public string MKTechnologyAsk { get; set; }

        /// <summary>
        /// 迈科钢网刮刀工钢网厚度
        /// </summary>
        public string MKLand { get; set; }
        /// <summary>
        /// PCB型号
        /// </summary>
        public string PCBModel { get; set; }


        public int InspectionStatus { get; set; }
        public string InspectionStatusName { get; set; }
        public string InspectionUserName { get; set; }
        public DateTime InspectionDateTime { get; set; }
        public DateTime StartInspectionDateTime { get; set; }
        /// <summary>
        /// 面别
        /// </summary>
        public string EquNoodles { get; set; }
        /// <summary>
        /// 可使用次数 by liwen
        /// </summary>
        public Int32 UsableCount { get; set; }
        /// <summary>
        /// 属性 by liwen
        /// </summary>
        public string Attribute { get; set; }



        /// <summary>
        /// 库位ID
        /// </summary>
        public int WarehouseLocationId { get; set; }
        public DateTime DeliveryTime { get; set; }
        /// <summary>
        /// 库位名称
        /// </summary>
        public string StoreName { get; set; }


        public int MouldBomId { get; set; }

        /// <summary>
        /// 构件ID
        /// </summary>ss
        public int ComponentId { get; set; }
        /// <summary>
        /// 构件名称
        /// </summary>
        public string ComponentName { get; set; }

        /// <summary>
        /// 公司编码
        /// </summary>
        public string CompanyCode { get; set; }
        /// <summary>
        /// 公司名称
        /// </summary>
        public string CompanyName { get; set; }

        public string cBarCode { get; set; }

        public decimal Price { get; set; }

        /// <summary>
        /// 收件人
        /// </summary>
        public string Consignee { get; set; }

        public int ItemId { get; set; }

        public string Company { get; set; }

        /// <summary>
        /// 设备所有者
        /// </summary>
        public string EquipmentOwner { get; set; }
        /// <summary>
        /// 项目名称
        /// </summary>
        public string ProjectName { get; set; }
        /// <summary>
        /// 工段
        /// </summary>
        public string WorkshopSection { get; set; }
        /// <summary>
        /// 设备类别
        /// </summary>
        public string EquipmentCategory { get; set; }

        /// <summary>
        /// 当前增加的设备数量
        /// </summary>
        public int EquipMentCount { get; set; }

        /// <summary>
        /// 是否固定资产(0:否，1:是)
        /// </summary>
        public int IsFixedAssets { get; set; }

        /// <summary>
        /// 最大在线时长（小时）
        /// </summary>
        public decimal MaxOnlineTime { get; set; }

        /// <summary>
        /// 客户系列
        /// </summary>
        public string Customerseries { get; set; }

        /// <summary>
        /// 客户模具编号
        /// </summary>
        public string CustomerCode { get; set; }

        /// <summary>
        /// 产品类型
        /// </summary>
        public string ProductType { get; set; }

        /// <summary>
        /// 模具类型
        /// </summary>
        public string MouldType { get; set; }

        /// <summary>
        /// 水口比重
        /// </summary>
        public decimal Waterinlet { get; set; }

        /// <summary>
        /// BOA Item
        /// </summary>
        public string BOAItem { get; set; }

        /// <summary>
        /// 是否换镶件
        /// </summary>
        public Boolean ReplaceINSERT { get; set; }

        /// <summary>
        /// 是否需要人工摘水口
        /// </summary>
        public Boolean Waterremoval { get; set; }

        /// <summary>
        /// 浇口类型
        /// </summary>
        public string Irrigationtype { get; set; }

        /// <summary>
        /// 原料
        /// </summary>
        public string Rawmaterial { get; set; }

        /// <summary>
        /// 产品单重
        /// </summary>
        public decimal Productweight { get; set; }

        /// <summary>
        /// 水口重
        /// </summary>
        public decimal Waterweight { get; set; }

        /// <summary>
        /// 产品总毛重
        /// </summary>
        public decimal Productallweight { get; set; }

        /// <summary>
        /// 周期
        /// </summary>
        public decimal Cycle { get; set; }

        /// <summary>
        /// 单个毛重
        /// </summary>
        public decimal Singleweight { get; set; }

        /// <summary>
        /// 使用优先级
        /// </summary>
        public int Priority { get; set; }


        // <summary>
        ///  吨位     
        /// </summary>
        public decimal Tonnage { get; set; }

        // <summary>
        ///  BU     
        /// </summary>
        public string BU { get; set; }
        // <summary>
        ///  出模数     
        /// </summary>
        public decimal ModuleProductQty { get; set; }

        /// <summary>
        /// 容量
        /// </summary>
        public decimal Capacity { get; set; }

        public int IsMachinedInjection { get; set; }

        /// <summary>
        /// 是否BOA
        /// </summary>
        public Boolean IsBOA { get; set; }

        public string Area { get; set; }
        /// <summary>
        /// 设备IP
        /// </summary>
        public string EquipmentIP { get; set; }
        /// <summary>
        /// 设备端口
        /// </summary>
        public string EquipmentPort { get; set; }

        /// <summary>
        /// 客户名称
        /// </summary>
        public string CustomName { get; set; }

        /// <summary>
        /// MODEL
        /// </summary>
        public string Model { get; set; }

        /// <summary>
        /// 机台吨位
        /// </summary>
        public string MachineTonnage { get; set; }

        /// <summary>
        /// 尺寸
        /// </summary>
        public string Size { get; set; }

        /// <summary>
        /// 模具形式
        /// </summary>
        public string Matrix { get; set; }

        /// <summary>
        /// 模具吨位
        /// </summary>
        public string MoldTonnage { get; set; }

        /// <summary>
        /// 模穴数
        /// </summary>
        public int Cavity { get; set; }

        /// <summary>
        /// 模具#次
        /// </summary>
        public string MoldTimes { get; set; }

        /// <summary>
        /// 厂家模具编码
        /// </summary>
        public string FactoryMouldCode { get; set; }

        /// <summary>
        /// 厂家模具名称
        /// </summary>
        public string FactoryMouldName { get; set; }

        /// <summary>
        /// 设备机器号
        /// </summary>
        public string EquimentExtNo { get; set; }

        /// <summary>
        /// 关联的工单ID
        /// </summary>
        public int PEId { get; set; }

    }

    public class EquipmentsMoudleInfo
    {
        public string EquipmentCode { get; set; }

        public string EquipmentName { get; set; }

        public string CustomName { get; set; }

        public string SupplierName { get; set; }

        public string WarehouseLocation { get; set; }

        public string Company { get; set; }

        public string FactoryDate { get; set; }

        public string Model { get; set; }

        public int UseCount { get; set; }

        public int StandarLive { get; set; }

        public string MachineTonnage { get; set; }

        public string MoldTonnage { get; set; }

        public string Size { get; set; }

        public string Matrix { get; set; }

        public int Cavity { get; set; }

        public string MoldTimes { get; set; }

        /// <summary>
        /// 厂家模具编码
        /// </summary>
        public string FactoryMouldCode { get; set; }

        /// <summary>
        /// 厂家模具名称
        /// </summary>
        public string FactoryMouldName { get; set; }
       

    }
}