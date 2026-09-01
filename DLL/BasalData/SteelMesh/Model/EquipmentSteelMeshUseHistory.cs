using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    public class EquipmentSteelMeshUseHistory
    {
        public int EquipmentUseHistoryId { set; get; }
        public int EquipmentId { set; get; }
        public int ProdOrderId { set; get; }
        public int LineId { set; get; }
        public int ResourceId { set; get; }
        public string TxnCode { set; get; }
        public string Status { set; get; }
        public string InOrOut { set; get; }
        public string IsClear { set; get; }
        public string Status_TO { set; get; }
        public string InOrOut_TO { set; get; }
        public string IsClear_TO { set; get; }
        public string Operator { set; get; }
        public DateTime OperatorTime { set; get; }
        public string Remark { set; get; }
        public string DataTypeName { set; get; }
        public string UpdateUserName { set; get; }
        public DateTime UpdateDateTime { set; get; }
        public string EquipmentCode { set; get; }
        public string EquipmentName { set; get; }
        public string EquipmentTypeNameone { set; get; }
        public string EquipmentTypeNametwo { set; get; }
        public string OrderNO { set; get; }
        public int Qty_to_Build { set; get; }
        public string LineName { set; get; }
        public string ResName { set; get; }
        public string Tension { set; get; }
        public string CheckResult { set; get; }
    }
}
