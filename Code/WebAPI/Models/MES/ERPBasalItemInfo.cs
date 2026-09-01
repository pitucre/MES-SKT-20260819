using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 产品编码表
    /// </summary>
    public class ERPBasalItemInfo
    {
        ///// <summary>
        ///// ItemID
        ///// </summary>
        //public int ItemID { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemName { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string ItemCode { get; set; }

        ///// <summary>
        ///// 产品版本
        ///// </summary>
        //public string ItemRev { get; set; }

        ///// <summary>
        ///// 产品描述
        ///// </summary>
        //public string Description { get; set; }

        /// <summary>
        /// 客户料号
        /// </summary>
        public string CPN { get; set; }

        ///// <summary>
        ///// 客户ID，对应CUSTOMER.CustomerID
        ///// </summary>
        //public int CustomerID { get; set; }

        ///// <summary>
        ///// 客户料号版本。Customer Part Revision
        ///// </summary>
        //public string CPR { get; set; }

        ///// <summary>
        ///// Releasable = 1,Frozen = 2,Obsolete = 3,Hold = 4,New = 5,Hold_Consec_NC = 6,Hold_SPC_Viol = 7,Hold_SPC_Warn = 8,Hold_Yield_Rate = 9
        ///// </summary>
        //public int Status { get; set; }

        ///// <summary>
        ///// 项目ID。对应PROJECT.ProjectId
        ///// </summary>
        //public int ProjectID { get; set; }

        /// <summary>
        ///// 产品类型 1、（Manufactured（制造产品，如PCBA）, 2、Purchased（购买产品，如元器件等）, 3、Manufactured/Purchased（两种类型兼有） ）
        ///// </summary>
        //public int ItemType { get; set; }

        /// <summary>
        ///// 绑定路由ID，对应ROUTER.RouterId
        ///// </summary>
        //public int RouterID { get; set; }

        ///// <summary>
        ///// 绑定的BOM ID,对应BOM.BomId
        ///// </summary>
        //public int BomId { get; set; }

        /// <summary>
        /// 当产品是Process Lot或者是Panel的时候，需指定Lot Size，也就是同一个条码绑定多少个产品
        ///// </summary>
        //public float LotSize { get; set; }

        ///// <summary>
        ///// 这个是指最多可用次数
        ///// </summary>
        //public float MaxUsageAsComp { get; set; }

        ///// <summary>
        ///// 限定数量
        ///// </summary>
        //public int QtyRestriction { get; set; }

        ///// <summary>
        ///// QtyMultiplier
        ///// </summary>
        //public float QtyMultiplier { get; set; }

        ///// <summary>
        ///// 是否当前版本。
        ///// </summary>
        //public bool IsCurrentRev { get; set; }

        ///// <summary>
        ///// 是否是拼版。
        ///// </summary>
        //public bool IsPanel { get; set; }

        ///// <summary>
        ///// 是否是客户提供SFC。
        ///// </summary>
        //public bool IsCPSFC { get; set; }

        ///// <summary>
        ///// 是否通过无铅认证。
        ///// </summary>
        //public bool IsRoHS { get; set; }

        ///// <summary>
        ///// 组装收集的数据
        ///// </summary>
        //public int DCOAssembly { get; set; }

        ///// <summary>
        ///// 移除时收集数据。
        ///// </summary>
        //public int DCORemoval { get; set; }

        ///// <summary>
        ///// 收货时收集数据
        ///// </summary>
        //public int DCOInveRec { get; set; }

        ///// <summary>
        ///// 收货时收集数据
        ///// </summary>
        //public bool RecInveWhenAss { get; set; }

        ///// <summary>
        ///// 验证规则
        ///// </summary>
        //public int VMGroup { get; set; }

        ///// <summary>
        ///// 是否是可追踪组件。
        ///// </summary>
        //public bool TrackableComp { get; set; }

        ///// <summary>
        ///// 产品组ID
        ///// </summary>
        //public int ItemGroupID { get; set; }

        ///// <summary>
        ///// IQC抽检类型(1,全检，2,抽检，3,免检)
        ///// </summary>
        //public int IQCType { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string Units { get; set; }

        /// <summary>
        /// 创建人。
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间。
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 修改人。
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间。
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        ///// <summary>
        ///// 备注。
        ///// </summary>
        //public string Remark { get; set; }

        /// <summary>
        /// 最小包装数量
        /// </summary>
        public decimal MinPackQty { get; set; }

        /// <summary>
        /// 物料规格
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string ItemSpec { get; set; }

        ///// <summary>
        ///// 工厂代码
        ///// </summary>
        //[MappingPropertyAttribute(AllowEmpty = false)]
        //public string Site { get; set; }

        ///// <summary>
        ///// 钢网id
        ///// </summary>
        //public int SteelId { get; set; }

        ///// <summary>
        ///// 拼板类型Id
        ///// </summary>
        //public int PanelTypeId { get; set; }

        ///// <summary>
        ///// 是否MES添加
        ///// </summary>
        //public bool IsMESadd { get; set; }

        ///// <summary>
        ///// 型号
        ///// </summary>
        //public string ItemModel { get; set; }

        ///// <summary>
        ///// 固件
        ///// </summary>
        //public string Firmware { get; set; }

        ///// <summary>
        ///// 是否要批次管理 1 是 0 否（默认值是-1）
        ///// </summary>
        //public int IsBatchManager { get; set; }

        /// <summary>
        /// 是否要质检 1 是 0 否（默认值是-1）
        /// </summary>
        public int IsPropertyCheck { get; set; }

        ///// <summary>
        ///// 是否需要打印（默认值 1是 0否）
        ///// </summary>
        //public int IsNeedPrint { get; set; }

        ///// <summary>
        ///// 产品是否可超发（默认值是0不是，1是）
        ///// </summary>
        //public bool IsItemOver { get; set; }

        ///// <summary>
        ///// 投入站
        ///// </summary>
        //public int PutStation { get; set; }

        ///// <summary>
        ///// 产出站
        ///// </summary>
        //public int YieldStation { get; set; }

        /// <summary>
        /// 大类
        /// </summary>
        public string CategoryOne { get; set; }

        /// <summary>
        /// 中类
        /// </summary>
        public string CategoryTwo { get; set; }

        /// <summary>
        /// 小类
        /// </summary>
        public string CategoryThree { get; set; }

        ///// <summary>
        ///// 是否MSD物料：  0：否，1：是
        ///// </summary>
        //public bool IsMSD { get; set; }

        /// <summary>
        /// 潮湿敏感度等级
        /// </summary>
        public string MSL { get; set; }

        /// <summary>
        ///// 暴露时长(小时）
        ///// </summary>
        //public int FloorLife { get; set; }

        /// <summary>
        /// 存储期限(天）
        /// </summary>
        public int ShelfLife { get; set; }

        ///// <summary>
        ///// 烘烤次数
        ///// </summary>
        //public int BakeCount { get; set; }

        /// <summary>
        /// 是否有效:0表示无效,1表示有效
        /// </summary>
        public bool IsActive { get; set; }

        /// <summary>
        /// ERP产品表的ID
        /// </summary>
        public string ERPItemID { get; set; }

        ///// <summary>
        ///// 掩码规则ID（用于验证相关条码是否合理）
        ///// </summary>
        //public int MaskId { get; set; }

        ///// <summary>
        ///// ABC等级分类
        ///// </summary>
        //public string ABCClass { get; set; }

        ///// <summary>
        ///// CheckNumber
        ///// </summary>
        //public int CheckNumber { get; set; }

        ///// <summary>
        ///// ExpirationDateId
        ///// </summary>
        //public int ExpirationDateId { get; set; }

        ///// <summary>
        ///// 1、默认发料方式 2、按最小批量发料
        ///// </summary>
        //public int IssueWay { get; set; }

        ///// <summary>
        ///// 是否拼板打印
        ///// </summary>
        //public bool IsPanelPrint { get; set; }

        ///// <summary>
        ///// ERP_ItemID
        ///// </summary>
        //public int ERP_ItemID { get; set; }

        ///// <summary>
        ///// ProductionFace
        ///// </summary>
        //public int ProductionFace { get; set; }

        ///// <summary>
        ///// KFPeriod
        ///// </summary>
        //public decimal KFPeriod { get; set; }

        ///// <summary>
        ///// ItemABC
        ///// </summary>
        //public string ItemABC { get; set; }

        ///// <summary>
        ///// ItemPriority
        ///// </summary>
        //public int ItemPriority { get; set; }

        ///// <summary>
        ///// IsUpTestExport
        ///// </summary>
        //public bool IsUpTestExport { get; set; }

        ///// <summary>
        ///// FAIQty
        ///// </summary>
        //public int FAIQty { get; set; }

        ///// <summary>
        ///// MaxShelfLife
        ///// </summary>
        //public int MaxShelfLife { get; set; }

        ///// <summary>
        ///// AcceptableShelfLife
        ///// </summary>
        //public int AcceptableShelfLife { get; set; }

        ///// <summary>
        ///// 是否上传出货报告
        ///// </summary>
        //public bool IsShipmentReport { get; set; }

        ///// <summary>
        ///// IsSmt
        ///// </summary>
        //public bool IsSmt { get; set; }

        /// <summary>
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }

        ///// <summary>
        ///// 数据插入时间
        ///// </summary>
        //public DateTime ERPInsertDateTime { get; set; }

        ///// <summary>
        ///// 同步表示（0：未同步 1：已同步 2：重复数据，不同步）
        ///// </summary>
        //public int ERPSyncFlag { get; set; }

        ///// <summary>
        ///// 同步到MES正式表时间
        ///// </summary>
        //public DateTime ERPSyncDateTime { get; set; }
        /// <summary>
        /// 颜色
        /// </summary>
        public string Color { get; set; }
        /// <summary>
        /// 材质
        /// </summary>
        public string TextureOfMaterial { get; set; }
        /// <summary>
        /// 阻燃 等级
        /// </summary>
        public string FlameRetardantLevel { get; set; }
        /// <summary>
        /// 可超量完工类型
        /// </summary>
        public int OverFinshType { get; set; }
        /// <summary>
        /// 完工超额数量
        /// </summary>
        public decimal OverQty { get; set; }
        /// <summary>
        /// 完工超额比例
        /// </summary>
        public decimal OverRate { get; set; }
    }
}