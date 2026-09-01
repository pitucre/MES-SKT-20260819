using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class BurnSoftInfo
    {
        public int BurnId { get; set; }
        public string SoftName { get; set; }
        public string TestMachine { get; set; }
        public string Customer { get; set; }
        public string SoftMan { get; set; }
        public DateTime ReceiveDate { get; set; }
        public string UpdateContent { get; set; }
        public string SoftPath { get; set; }
        public string VerifyCode { get; set; }
        public string DownloadDir { get; set; }
        public string Remark { get; set; }
        public int CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public int ModifyBy { get; set; }
        public DateTime ModifyTime { get; set; }
    }
}
