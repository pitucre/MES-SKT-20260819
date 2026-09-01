using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 形态转换单明细信息(转换后)
    /// </summary>
    [Serializable]
    public class ERPProdFormChangeDtledInfo
    {

        #region Model


        /// <summary>
        /// 形态转换单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string FormChangeNo { get; set; }

        /// <summary>
        /// 行号(转换前)
        /// </summary>
        public string MainRowNo { get; set; }

        /// <summary>
        /// 行号
        /// </summary>
        public string RowNo { get; set; }

        /// <summary>
        /// 转换类别
        /// </summary>
        public string ChangeType { get; set; }

        /// <summary>
        /// 料号
        /// </summary>
        public string MaterialCode { get; set; }

        /// <summary>
        /// 品名
        /// </summary>
        public string MaterialName { get; set; }

        /// <summary>
        /// 存储类型
        /// </summary>
        public string StorageType { get; set; }

        /// <summary>
        /// 数量
        /// </summary>
        public decimal? Quantity { get; set; }

        /// <summary>
        /// 成本数量
        /// </summary>
        public decimal? CostQuantity { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string Unit { get; set; }

        /// <summary>
        /// 成本单位
        /// </summary>
        public string CostUnit { get; set; }

        /// <summary>
        /// 成本
        /// </summary>
        public decimal? Cost { get; set; }

        /// <summary>
        /// 单价
        /// </summary>
        public decimal? UnitPrice { get; set; }

        /// <summary>
        /// 存储地点
        /// </summary>
        public string StorageLocation { get; set; }

        /// <summary>
        /// 库位
        /// </summary>
        public string WarehouseLocation { get; set; }

        /// <summary>
        /// 规格型号
        /// </summary>
        public string SpecificationModel { get; set; }

        /// <summary>
        /// 状态：0待转换，1已转换
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

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

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int? ERPOperateType { get; set; }

        #endregion Model

    }
}
