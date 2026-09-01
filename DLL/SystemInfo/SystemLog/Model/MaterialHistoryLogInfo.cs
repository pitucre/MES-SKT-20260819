using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SystemLog.Model
{
    public class MaterialHistoryLogInfo
    {
        public int MaterialUnitHistoryId { get; set; }
        public int MaterialUnitId { get; set; }
        public int ActionType { get; set; }
        public string ActionDesc { get; set; }
        public string OperateOrder { get; set; }
        public decimal Qty { get; set; }
        public string  Description { get; set; }
        public string  CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime  ModifyDateTime { get; set; }
        public string Remark { get; set; }
        public int  StationId { get; set; }
        public int  ResId { get; set; }
        public string  ContainerCode { get; set; }

    }
}
