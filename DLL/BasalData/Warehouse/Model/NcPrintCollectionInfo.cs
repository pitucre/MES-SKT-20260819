using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    public class NcPrintCollectionInfo
    {
        public int ProdOrderId { get; set; }    
        public int StationId { get; set; }

        public int ResId { get; set; }
        public string Remark { get; set; }
        public int NCCodeIdFailure {  get; set; }
        public int NCCodeIdDefect {  get; set; }
        public int NgQty { get; set; }
        public string UserName { get; set; }
        public int ItemId { get; set; }

        public string SN { get; set; }
    }

    public class LineMaterialSNInfo
    {
        public int ProdOrderId { get; set; }
        public int ItemId { get; set; }
        public decimal GRNQty { get; set; }
        public string UserName { get; set; }
        public int ResId { get; set; }
        public int OpenId {  get; set; }
        public string Remark { get; set; }
    }
}
