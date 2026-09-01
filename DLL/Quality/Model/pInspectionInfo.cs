using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{

    /// <summary>
    /// 送检批信息
    /// </summary>
    public class pInspectionInfo
    {
        public int InspectionLotId { get; set; }
        public string InspectionLotNo { get; set; }
        public string ItemCode { get; set; }
        public int LotQty { get; set; }
        public string State { get; set; }
        public string SN { get; set; }
        public int ProdOrderId { get; set; }

        //扩展
        public string OrderNO { get; set; }
        public string ItemName { set; get; }
        public string CustomerName { set; get; }
        public int OrderQty { set; get; }
        public int InspectionQty { set; get; }
    }
}
