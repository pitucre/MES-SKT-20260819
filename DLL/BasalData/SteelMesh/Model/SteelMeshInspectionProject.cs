using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    public class SteelMeshInspectionProject
    {
        public int SMIPId { set; get; }
        public int SMIPType { set; get; }
        public string SMIPCode { set; get; }
        public string SMIPName { set; get; }
        public string SMIPEntryMode { set; get; }
        public string SMIPCriterion { set; get; }
        public string SMIPUnit { set; get; }
        public int SMIPStatus { set; get; }
        public string SMIPUserName { set; get; }
        public DateTime SMIPDateTime { set; get; }
        public string SMIPUpdateUserName { set; get; }
        public DateTime SMIPUpdateDateTime { set; get; }
        public string SMIPRem { set; get; }

        public string SMIPTypeName { set; get; }
    }
}
