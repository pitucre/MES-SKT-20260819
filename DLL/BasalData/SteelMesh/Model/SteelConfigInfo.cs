using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SteelMesh.Model
{
    [Serializable]
    public class SteelConfigInfo
    {
        public SteelConfigInfo() { }

        public SteelConfigInfo(string _SteelConfigCode, string _SteelConfig,string _Result,string _IsGlobal,string _Remark)
        {
            SteelConfigCode = _SteelConfigCode;
            SteelConfig = _SteelConfig;
            Result = _Result;
            IsGlobal = _IsGlobal;
            Remark = _Remark;
        }

        public string SteelConfigCode { set; get; }

        public string SteelConfig { set; get; }
        public string Result { set; get; }
        public string IsGlobal { set; get; }
        public string Remark { set; get; }

        public string ModifyBy { get; set; }

        public DateTime? ModifyDate { get; set; }
    }
}
