using Antlr.Runtime;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Emit;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// GRN信息表
    /// </summary>
    public class ERPProdMaterialUnit
    {
        // FactoryCode 工厂编码
        /// <summary>
        /// 工厂编码
        /// </summary>
        public string FactoryCode { get; set; }
        //SerialNumber 物料条码
        /// <summary>
        /// 物料条码
        /// </summary>
        public string SerialNumber { get; set; }
        //LotCode 打印批次号
        /// <summary>
        /// 打印批次号
        /// </summary>
        public string LotCode { get; set; }
        //DateCode 日期编码(例2024-04-01)
        /// <summary>
        /// 日期编码(例2024-04-01)
        /// </summary>
        public string DateCode { get; set; }
        //MPN 制造商料号
        /// <summary>
        /// 制造商料号
        /// </summary>
        public string MPN { get; set; }
        //VendorCode 供应商编码
        /// <summary>
        /// 供应商编码
        /// </summary>
        public string VendorCode { get; set; }
        //BalanceQty 数量
        /// <summary>
        /// 数量
        /// </summary>
        public decimal BalanceQty { get; set; }
        //Status 状态  1-在供应商
        /// <summary>
        /// 状态  1-在供应商
        /// </summary>
        public string Status { get; set; }
        //StorageDate   入库日期(例2024-04-01)
        /// <summary>
        /// 入库日期(例2024-04-01)
        /// </summary>
        public DateTime StorageDate { get; set; }
        //Remark          备注
        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
        //WeekCode     周数(例10)
        /// <summary>
        /// 周数(例10)
        /// </summary>
        public string WeekCode { get; set; }
        //ExpiredDate 过期日期(例2024-04-01)
        /// <summary>
        /// 过期日期(例2024-04-01)
        /// </summary>
        public DateTime ExpiredDate { get; set; }
        //DeliveryOrder 送货单号
        /// <summary>
        /// 送货单号
        /// </summary>
        public string DeliveryOrder { get; set; }
        //DeliverRowId 送货单行号
        /// <summary>
        /// 送货单行号
        /// </summary>
        public string DeliverRowId { get; set; }
        //POrder 采购单号
        /// <summary>
        /// 采购单号
        /// </summary>
        public string POrder { get; set; }
        //AutoId 采购单行号
        /// <summary>
        /// 采购单行号
        /// </summary>
        public string AutoId { get; set; }
        //ItemCode 物料编码
        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { get; set; }
        //CWhCode 仓库编码
        /// <summary>
        /// 仓库编码
        /// </summary>
        public string CWhCode { get; set; }
        //BoxSN 包装箱号
        /// <summary>
        /// 包装箱号
        /// </summary>
        public string BoxSN { get; set; }
        //CreateBy 创建人
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }
        //CreateDateTime 创建时间(例2024-04-01)
        /// <summary>
        /// 创建时间(例2024-04-01)
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        //ModifyBy 修改人
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        //ModifyDateTime 修改时间(例2024-04-01)
        /// <summary>
        /// 修改时间(例2024-04-01)
        /// </summary>
        public DateTime ModifyDateTime { get; set; }
        //ERPOperateType ERP操作类型（0：新增 1：修改 2：删除）
        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }
    }
}