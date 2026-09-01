using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MobileMat.Model
{
    /// <summary>
    /// 出货itemId和条码的对应关系
    /// </summary>
    [Serializable]
    public class ShipmentItemToSNInfo
    {
        public ShipmentItemToSNInfo(int ItemSNId, int ItemId, string SNValue)
        {
            this.ItemSNId = ItemSNId;
            this.ItemId = ItemId;
            this.SNValue = SNValue;
        }
        /// <summary>
        /// itemId和条码的对应关系Id
        /// </summary>
        private int itemSNId;

        public int ItemSNId
        {
            get { return itemSNId; }
            set { itemSNId = value; }
        }
        /// <summary>
        /// 成品出货订单主表
        /// </summary>
        private int itemId;

        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }
        /// <summary>
        /// 所刷的条码
        /// </summary>
        private string sNValue;

        public string SNValue
        {
            get { return sNValue; }
            set { sNValue = value; }
        }
    }
}
