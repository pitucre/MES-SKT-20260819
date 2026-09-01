using System;

namespace SKT.LeanMES.MaterialDelivery.Model
{
    [Serializable]
    public class PickMaterialsInfo
    {
        private Int32 pickSubId;
        private Int32 pickId;
        private Int32 itemId;
        private Int32 quantity;

        private String itemName;
        private String itemCode;
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PickMaterialsInfo 类的新实例。
        /// </summary>
        public PickMaterialsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.PickMaterialsInfo 类的新实例。
        /// </summary>
        /// <param name="pickSubId">主键编号</param>
        /// <param name="pickId">分捡单主表id</param>
        /// <param name="itemId">物料id</param>
        /// <param name="quantity">数量</param>
        public PickMaterialsInfo(Int32 pickSubId, Int32 pickId, Int32 itemId, Int32 quantity)
        {
            this.pickSubId = pickSubId;
            this.pickId = pickId;
            this.itemId = itemId;
            this.quantity = quantity;
        }

        /// <summary>
        /// 获取或设置主键编号
        /// </summary>
        public Int32 PickSubId
        {
            get { return this.pickSubId; }
            set { this.pickSubId = value; }
        }

        /// <summary>
        /// 获取或设置分捡单主表id
        /// </summary>
        public Int32 PickId
        {
            get { return this.pickId; }
            set { this.pickId = value; }
        }

        /// <summary>
        /// 获取或设置物料id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public Int32 Quantity
        {
            get { return this.quantity; }
            set { this.quantity = value; }
        }
        /// <summary>
        /// 获取或设置物料名称
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        /// <summary>
        /// 获取或设置物料编号
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
    }
}