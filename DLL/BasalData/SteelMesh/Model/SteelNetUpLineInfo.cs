using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    [Serializable]
    public class SteelNetUpLineInfo
    {
        public SteelNetUpLineInfo()
        {

        }

        public SteelNetUpLineInfo(Int64 historyID, string equipmentName, string equipmentCode, string equipmentType, string orderNO, int qty_to_Build,
            string uPLineUser, DateTime uPLineTime, string status, string downLineUser, string downLineTime, string clearUser, string clearTime, string tension, string checkResult)
        {
            this.HistoryID = historyID;
            this.EquipmentName = equipmentName;
            this.EquipmentCode = equipmentCode;
            this.EquipmentType = equipmentType;
            this.OrderNO = orderNO;
            this.Qty_to_Build = qty_to_Build;
            this.UPLineUser = uPLineUser;
            this.UPLineTime = uPLineTime;
            this.Status = status;
            this.DownLineUser = downLineUser;
            this.DownLineTime = downLineTime;
            this.ClearUser = clearUser;
            this.ClearTime = clearTime;
            this.Tension = tension;
            this.CheckResult = checkResult;
        }

        public Int64 HistoryID { set; get; }
        public string EquipmentName { set; get; }
        public string EquipmentCode { set; get; }
        public string EquipmentType { set; get; }
        public string OrderNO { set; get; }
        public int Qty_to_Build { set; get; }
        public string UPLineUser { set; get; }
        public DateTime UPLineTime { set; get; }
        public string Status { set; get; }
        public string DownLineUser { set; get; }
        public string DownLineTime { set; get; }
        public string ClearUser { set; get; }
        public string ClearTime { set; get; }
        public string Tension { set; get; }
        public string CheckResult { set; get; }

    }
}
