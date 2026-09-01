using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Shipment.Model
{
    [Serializable]
    public class ShipmentRecordInfo
    {
        public int OutStorageDetailID { get; set; }
        public int AutoID { get; set; }
        public string Code { get; set; }
        public double PlanQty { get; set; }
        public int OutStorageQty { get; set; }
        public string ShipDate { get; set; }
        public string WhCode { get; set; }
        public string VenCode { get; set; }
        public string CusCode { get; set; }
        public string PersonCode { get; set; }
        public string ChkPerson { get; set; }
        public string Wherson { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string OrderNo { get; set; }
        public string SOCode { get; set; }
        public string SerialNumber { get; set; }
    }
}
