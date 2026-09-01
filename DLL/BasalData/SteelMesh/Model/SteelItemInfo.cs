using System;

namespace SKT.LeanMES.SteelItem.Model
{
    [Serializable]
    public class SteelItemInfo
    {
        private Int32 steelItemId;
        private Int32 itemId;
        private Int32 equipmentId;
        private string layout;
        private String itemCode;
        private String itemName;
        private String equipmentCode;
        private String equipmentName;
        private string itemSpec;
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelItemInfo 类的新实例。
        /// </summary>
        public SteelItemInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelItemInfo 类的新实例。
        /// </summary>
        /// <param name="steelItemId">主键</param>
        /// <param name="itemId">产品id</param>
        /// <param name="steelId">钢网id</param>
        /// <param name="addTime"></param>
        public SteelItemInfo(Int32 steelItemId, Int32 itemId, Int32 equipmentId, string layout)
        {
            this.steelItemId = steelItemId;
            this.itemId = itemId;
            this.equipmentId = equipmentId;
            this.layout = layout;
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.SteelItemInfo 类的新实例。
        /// </summary>
        /// <param name="steelItemId">主键</param>
        /// <param name="itemId">产品id</param>
        /// <param name="steelId">钢网id</param>
        /// <param name="itemCode">产品编号</param>
        /// <param name="itemName">产品名称</param>
        /// <param name="steelCode">钢网编号</param>
        /// <param name="steelName">钢网名称</param>
        public SteelItemInfo(Int32 steelItemId, Int32 itemId, Int32 equipmentId, string layout, DateTime addTime, String itemCode, String itemName, String equipmentCode, String equipmentName)
        {
            this.steelItemId = steelItemId;
            this.itemId = itemId;
            this.equipmentId = equipmentId;
            this.layout = layout;
            this.itemCode = itemCode;
            this.itemName = itemName;
            this.equipmentCode = equipmentCode;
            this.equipmentName = equipmentName;
        }
        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 SteelItemId
        {
            get { return this.steelItemId; }
            set { this.steelItemId = value; }
        }

        /// <summary>
        /// 获取或设置产品id
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置钢网id
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }
        /// <summary>
        /// 获取或设置半成品id
        /// </summary>
        public string Layout
        {
            get { return this.layout; }
            set { this.layout = value; }
        }
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        public String EquipmentCode
        {
            get { return this.equipmentCode; }
            set { this.equipmentCode = value; }
        }
        public String EquipmentName
        {
            get { return this.equipmentName; }
            set { this.equipmentName = value; }
        }

        public string ItemSpec
        {
            get { return this.itemSpec; }
            set { this.itemSpec = value; }
        }
    }
}