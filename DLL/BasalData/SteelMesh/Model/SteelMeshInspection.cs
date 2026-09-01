using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    public class SteelMeshInspection
    {
        public int SMIId { set; get; }
        public int SMIEquipmentId { set; get; }
        public string SMIEquipmentCode { set; get; }
        public DateTime SMIStartInspectionDateTime { set; get; }
        public DateTime SMIStopInspectionDateTime { set; get; }
        public int SMIInspectionStatus { set; get; }// 检验状态   0为未检    1为检验中    2为合格  -2为不合格

        public string SMIInspectionStatusString
        {
            get
            {
                if (SMIInspectionStatus == 0)
                {
                    return "未检";
                }
                else if(SMIInspectionStatus == 1)
                {
                    return "检验中";
                }
                else if (SMIInspectionStatus == 2)
                {
                    return "合格";
                }
                else if (SMIInspectionStatus == -2)
                {
                    return "不合格";
                }
                else
                {
                    return "";
                }
            }
        }
        public string SMIInspectionUserName { set; get; }
        public DateTime SMIInspectionDateTime { set; get; }
        public string SMIIAddUserName { set; get; }
        public DateTime SMIIAddDateTime { set; get; }
        public string SMIIUpdateUserName { set; get; }
        public DateTime SMIIUpdateDateTime { set; get; }
        public string SMIInspectionRem { set; get; }
        public string EquipmentCode { set; get; }
        public string EquipmentName { set; get; }
        public string VendorBarcode { set; get; }
        public string VenCode { set; get; }
        public string PCBModel { set; get; }
    }
}
