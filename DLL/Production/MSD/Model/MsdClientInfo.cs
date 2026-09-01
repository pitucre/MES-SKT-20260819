using System;

namespace SKT.LeanMES.MSD.Model
{
     [Serializable]
    public class MsdClientInfo
    {       
        public string GRN { get; set; }
        public string ResName { get; set; }
        public string Station { get; set; }
        public string ContainerCode { get; set; }
        public string CreateBy { get; set; }
        public string ActionDesc { get; set; }
        public string CreateDateTime { get; set; }
    }
}
