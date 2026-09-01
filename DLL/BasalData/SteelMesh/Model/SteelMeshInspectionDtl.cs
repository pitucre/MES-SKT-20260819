using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    public class SteelMeshInspectionDtl
    {
        public int SMIDId { set; get; }
        public int SMIDSMIId { set; get; }
        public int SMIDSMIPId { set; get; }
        public string SMIDResult { set; get; }
        public string SMIDUserName { set; get; }
        public DateTime SMIDDateTime { set; get; }
        public string SMIDAddUserName { set; get; }
        public DateTime SMIDAddDateTime { set; get; }
        public string SMIDUpdateUserName { set; get; }
        public DateTime SMIDUpdateDateTime { set; get; }
        public string SMIDRem { set; get; }
        public int SMIPType { set; get; }
        public string SMIPCode { set; get; }
        public string SMIPName { set; get; }
        public string SMIPEntryMode { set; get; }
        public string SMIPCriterion { set; get; }
        public string SMIPUnit { set; get; }
        public string EquipmentCode { set; get; }
        public string EquipmentName { set; get; }

        public string SMIPTypeName { set; get; }
    }
}
