using System;
namespace SKT.LeanMES.Molding.Model
{
    /// <summary>
    /// Des:物料烧录关系实体
    /// Author:Hanson.Lei
    /// Date:2017.8.14
    [Serializable]
    public class MaterialBurnMemberInfo
    {
        /// <summary>
        /// 烧录明细ID
        /// </summary>
        public int BurnMemberId { get; set; }

        /// <summary>
        /// 烧录ID
        /// </summary>
        public int BurnId { get; set; }

        /// <summary>
        /// 物料ID
        /// </summary>
        public int ItemId { get; set; }
        /// <summary>
        /// 产品关联物料ID
        /// </summary>
        public int MaterialItemId { get; set; }

        /*=========注意：以下的实体属性不属于数据表中的物理字段=========↓↓↓*/

        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }
        public string MItemCode { get; set; }
        public string MItemName { get; set; }

        public MaterialBurnMemberInfo() { }

        public MaterialBurnMemberInfo(Int32 burnMemberId, Int32 burnId, Int32 itemId,string itemCode,string itemName,string MItemCode,string MItemName,Int32 MaterialItemId)
        {
            this.BurnMemberId = burnMemberId;
            this.BurnId = burnId;
            this.ItemId = itemId;
            this.ItemCode = itemCode;
            this.ItemName = itemName;
            this.MItemCode = MItemCode;
            this.MItemName = MItemName;
            this.MaterialItemId = MaterialItemId;
        }
    }
}
