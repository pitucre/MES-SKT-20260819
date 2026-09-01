using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MobileMat.Model
{
    [Serializable]
    public class FinishProdShipmentDetailInfo
    {
        public FinishProdShipmentDetailInfo()
        { 
        
        }
        public FinishProdShipmentDetailInfo(int ShipmentDetailId, int ShipmentId, int ItemId)
        {
            this.ShipmentDetailId = ShipmentDetailId;
            this.ShipmentId = ShipmentId;
            this.ItemId = ItemId;
        }
        /// <summary>
        /// 成品出货明细表自增Id
        /// </summary>
        private int shipmentDetailId;

        public int ShipmentDetailId
        {
            get { return shipmentDetailId; }
            set { shipmentDetailId = value; }
        }

        /// <summary>
        /// 成品出货主表自增Id
        /// </summary>
        private int shipmentId;

        public int ShipmentId
        {
            get { return shipmentId; }
            set { shipmentId = value; }
        }

        /// <summary>
        /// 所刷条码
        /// </summary>
        private int itemId;

        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }

        private string itemCode;

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        private int qty;

        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }
        private string sourceBillNo;

        public string SourceBillNo
        {
            get { return sourceBillNo; }
            set { sourceBillNo = value; }
        }
        private string soCode;

        public string SoCode
        {
            get { return soCode; }
            set { soCode = value; }
        }
        private string sN;

        public string SN
        {
            get { return sN; }
            set { sN = value; }
        }
        private int itemSNId;

        public int ItemSNId
        {
            get { return itemSNId; }
            set { itemSNId = value; }
        }    
    }
}
