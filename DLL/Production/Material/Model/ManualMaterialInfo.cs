using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ManualMaterialInfo
    {
        private int id;
        public int ID
        {
            get { return id; }
            set { id = value; }
        }
        private int prodOrderID;
        public int ProdOrderID
        {
            get { return prodOrderID; }
            set { prodOrderID = value; }
        }
        private string orderNO;//工单

        public string OrderNO
        {
            get { return orderNO; }
            set { orderNO = value; }
        }
        private string lineName;//线别

        public string LineName
        {
            get { return lineName; }
            set { lineName = value; }
        }
        private string itemCode;//物料编号

        public string ItemCode
        {
            get { return itemCode; }
            set { itemCode = value; }
        }
        private double needQty;//需求数量

        public double NeedQty
        {
            get { return needQty; }
            set { needQty = value; }
        }
        private string smtMachinePos;//SMT站位

        public string SmtMachinePos
        {
            get { return smtMachinePos; }
            set { smtMachinePos = value; }
        }
        private int itemID;//物料ID
        public int ItemID
        {
            get { return itemID; }
            set { itemID = value; }
        }
        private int lineID;//线别ID
        public int LineID
        {
            get { return lineID; }
            set { lineID = value; }

        }
    }
}
