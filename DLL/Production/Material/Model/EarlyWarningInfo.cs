using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class EarlyWarningInfo
    {
        private long id;
        private string itemCode;
        private int libraryCollar;
        private int safetyStock;
        private string itemName;
        private decimal balanceQty;

        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }

        public long ID
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public string ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        public int LibraryCollar
        {
            get { return this.libraryCollar; }
            set { this.libraryCollar = value; }
        }
        public int SafetyStock
        {
            get { return this.safetyStock; }
            set { this.safetyStock = value; }
        }
        public string ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        public decimal BalanceQty
        {
            get { return this.balanceQty; }
            set { this.balanceQty = value; }
        }
    }
}
