using System;
namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class MaterialProcessInfo : CommEntity
    {
        /// <summary>
        /// 流水号
        /// </summary>
        public int ProcessNo { get; set; }

        /// <summary>
        /// 成型ID
        /// </summary>
        public int MoldingId { get; set; }

        /// <summary>
        /// 成型明细ID
        /// </summary>
        public int MoldingMemberId { get; set; }

        /// <summary>
        /// 班组
        /// </summary>
        public string Group { get; set; }

        /// <summary>
        /// 设别编码
        /// </summary>
        public string EquipmentNo { get; set; }

        /// <summary>
        /// 治具编码
        /// </summary>
        public string FixtureNo { get; set; }

        /// <summary>
        /// 生产日期
        /// </summary>
        public DateTime ProdDate { get; set; }

        /// <summary>
        /// 重量
        /// </summary>
        public Decimal Weight { get; set; }

        /// <summary>
        /// 状态
        /// </summary>
        public string Status { get; set; }

        /// <summary>
        /// 库位
        /// </summary>
        public string StorageLocation { get; set; }

        /// <summary>
        /// 打印后的GRN
        /// </summary>
        public string UseGRN { get; set; }

        /// <summary>
        /// 工单
        /// </summary>
        public int ProdOrderID { get; set; }

        /// <summary>
        /// 加工人
        /// </summary>
        public string CName { get; set; }

        /*=========注意：以下的实体属性不属于数据表中的物理字段=========↓↓↓*/

        /// <summary>
        /// 原成型明细
        /// </summary>
        public MaterialMoldingMemberInfo SourceMoldingMember { get; set; }

    }
}
