using System;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class OutStorageInfo
    {
        private int itemId;
        private String itemCode;
        private String itemName;
        private String orderNo;
        private String lotCode;
        private String turnNumber;
        private int turnQty;
        private int outQty;
        private string description;
        private string createBy;
        private String createTime;

        public int ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        public string ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        public string ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public string OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }

        public string LotCode
        {
            get { return this.lotCode; }
            set { this.lotCode = value; }
        }

        public int TurnQty
        {
            get { return this.turnQty; }
            set { this.turnQty = value; }
        }

        public int OutQty
        {
            get { return this.outQty; }
            set { this.outQty = value; }
        }

        public string Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
        public string TurnNumber
        {
            get { return this.turnNumber; }
            set { this.turnNumber = value; }
        }
        public string CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        public String CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
    }
}
