using System;
namespace SKT.LeanMES.Molding.Model
{
    [Serializable]
    public class MaterialMoldingInfo : CommEntity
    {
        /// <summary>
        /// 前加工ID
        /// </summary>
        public int MoldingId { get; set; }

        /// <summary>
        /// 产品ID
        /// </summary>
        public int ItemId { get; set; }

        /*=========注意：以下的实体属性不属于数据表中的物理字段=========↓↓↓*/

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 是否是导入的数据
        /// </summary>
        public int IsImport { get; set; }

        /// <summary>
        /// 明细
        /// </summary>
        public System.Collections.Generic.List<MaterialMoldingMemberInfo> Member { get; set; }
    }
}
