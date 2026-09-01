using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class OfflineGRNInfo
    {
       
        public int SignId { get; set; }
        public decimal Qty { get; set; }
        public int RowId { get; set; }
        public String PoCode { get; set; }
        public String SerialNumber { get; set; }
        public String VendorCode { get; set; }
        public String VendorName { get; set; }
        public String ItemCode { get; set; }
        public String LotCode { get; set; }
        public String DateCode { get; set; }
        public String WeekCode { get; set; }
        public String MPN { get; set; }
        public String States { get; set; }
        public String ErrorMessage { get; set; }

        /// <summary>
        /// 初始化 SKT.MES.Model.UNITInfo 类的新实例。
        /// </summary>
        public OfflineGRNInfo()
        {
        }
    }
}
