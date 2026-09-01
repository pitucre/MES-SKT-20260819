using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 设备表
    /// </summary>
    public class ERPBasalEquipmentInfo
    {
        ///// <summary>
        ///// EquipmentId
        ///// </summary>
        //public int EquipmentId { get; set; }

        /// <summary>
        /// 设备编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string EquipmentCode { get; set; }

        /// <summary>
        /// 设备名称
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string EquipmentName { get; set; }

        ///// <summary>
        ///// 设备类型ID
        ///// </summary>
        //public int? EquipmentTypeId { get; set; }

        /// <summary>
        /// 设备型号
        /// </summary>
        public string EquipmentModel { get; set; }

        ///// <summary>
        ///// 生产设备日期
        ///// </summary>
        //public DateTime? ProduceDate { get; set; }

        /// <summary>
        /// 状态（0:新购买 1:生产中 2:待机中 3:换线中 4:维修中 5:已报废 6:故障中）
        /// </summary>
        public int? Status { get; set; }

        ///// <summary>
        ///// 线别ID
        ///// </summary>
        //public int? LineId { get; set; }

        ///// <summary>
        ///// 站位ID
        ///// </summary>
        //public int? StationId { get; set; }

        /// <summary>
        /// 入厂日期。
        /// </summary>
        public DateTime? FactoryDate { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        ///// <summary>
        ///// Remark
        ///// </summary>
        //public string Remark { get; set; }

        /// <summary>
        /// 供应商编码
        /// </summary>
        public string VenCode { get; set; }

        ///// <summary>
        ///// SequenceNo
        ///// </summary>
        //public int SequenceNo { get; set; }

        /// <summary>
        /// 存放位置（关联Basal_EquipmentPosition表）
        /// </summary>
        public string Position { get; set; }

        ///// <summary>
        ///// VendorBarcode
        ///// </summary>
        //public string VendorBarcode { get; set; }

        ///// <summary>
        ///// Thick
        ///// </summary>
        //public decimal Thick { get; set; }

        ///// <summary>
        ///// WarningCount
        ///// </summary>
        //public int WarningCount { get; set; }

        ///// <summary>
        ///// UseCount
        ///// </summary>
        //public int UseCount { get; set; }

        ///// <summary>
        ///// StandarLive
        ///// </summary>
        //public int StandarLive { get; set; }

        ///// <summary>
        ///// CurPosition
        ///// </summary>
        //public string CurPosition { get; set; }

        ///// <summary>
        ///// InOrOut
        ///// </summary>
        //public int InOrOut { get; set; }

        ///// <summary>
        ///// IsClear
        ///// </summary>
        //public int IsClear { get; set; }

        ///// <summary>
        ///// Purchase
        ///// </summary>
        //public int? Purchase { get; set; }

        ///// <summary>
        ///// UnitName
        ///// </summary>
        //public string UnitName { get; set; }

        ///// <summary>
        ///// CareDepNo
        ///// </summary>
        //public string CareDepNo { get; set; }

        /// <summary>
        /// 保管人
        /// </summary>
        public string CareBy { get; set; }

        ///// <summary>
        ///// PictureName
        ///// </summary>
        //public string PictureName { get; set; }

        ///// <summary>
        ///// SupplierCode
        ///// </summary>
        //public string SupplierCode { get; set; }

        ///// <summary>
        ///// MKSpec
        ///// </summary>
        //public string MKSpec { get; set; }

        ///// <summary>
        ///// MKQTY
        ///// </summary>
        //public string MKQTY { get; set; }

        ///// <summary>
        ///// MKUsingTechnology
        ///// </summary>
        //public string MKUsingTechnology { get; set; }

        ///// <summary>
        ///// MKUsingType
        ///// </summary>
        //public string MKUsingType { get; set; }

        ///// <summary>
        ///// MKTechnologyAsk
        ///// </summary>
        //public string MKTechnologyAsk { get; set; }

        ///// <summary>
        ///// MKLand
        ///// </summary>
        //public string MKLand { get; set; }

        ///// <summary>
        ///// GuaranteeDay
        ///// </summary>
        //public int? GuaranteeDay { get; set; }

        ///// <summary>
        ///// OverGuaranteeTime
        ///// </summary>
        //public DateTime? OverGuaranteeTime { get; set; }

        ///// <summary>
        ///// AssetNumber

        ///// </summary>
        //public string AssetNumber { get; set; }

        ///// <summary>
        ///// PCBModel
        ///// </summary>
        //public string PCBModel { get; set; }

        ///// <summary>
        ///// InspectionStatus
        ///// </summary>
        //public int? InspectionStatus { get; set; }

        ///// <summary>
        ///// InspectionUserName
        ///// </summary>
        //public string InspectionUserName { get; set; }

        ///// <summary>
        ///// InspectionDateTime
        ///// </summary>
        //public DateTime? InspectionDateTime { get; set; }

        ///// <summary>
        ///// StartInspectionDateTime
        ///// </summary>
        //public DateTime? StartInspectionDateTime { get; set; }

        ///// <summary>
        ///// InspectionMesId
        ///// </summary>
        //public int? InspectionMesId { get; set; }

        ///// <summary>
        ///// EquNoodles
        ///// </summary>
        //public string EquNoodles { get; set; }

        ///// <summary>
        ///// Attribute
        ///// </summary>
        //public string Attribute { get; set; }

        ///// <summary>
        ///// ComponentId
        ///// </summary>
        //public int? ComponentId { get; set; }

        ///// <summary>
        ///// AssetCode
        ///// </summary>
        //public string AssetCode { get; set; }

        ///// <summary>
        ///// 初始压制数
        ///// </summary>
        //public int? InitialPress { get; set; }

        ///// <summary>
        ///// 当前压制数
        ///// </summary>
        //public int? CurrentPress { get; set; }

        ///// <summary>
        ///// WarehouseLocationId
        ///// </summary>
        //public int? WarehouseLocationId { get; set; }

        ///// <summary>
        ///// OutStockType
        ///// </summary>
        //public string OutStockType { get; set; }

        ///// <summary>
        ///// Consignee
        ///// </summary>
        //public string Consignee { get; set; }

        /// <summary>
        /// 所属公司
        /// </summary>
        public string Company { get; set; }

        ///// <summary>
        ///// Price
        ///// </summary>
        //public decimal? Price { get; set; }

        ///// <summary>
        ///// DeliveryTime
        ///// </summary>
        //public decimal? DeliveryTime { get; set; }

        ///// <summary>
        ///// StationName
        ///// </summary>
        //public string StationName { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }


        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }


        /// <summary>
        /// 设备类型编码
        /// </summary>
        public string EquipmentTypeCode { get; set; }

        /// <summary>
        /// 设备类型名称
        /// </summary>
        public string EquipmentTypeName { get; set; }


        /// <summary>
        /// 品牌
        /// </summary>
        public string Brand { get; set; }
        

    }
}