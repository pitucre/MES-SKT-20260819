using System;

namespace SKT.LeanMES.MaterialConfig.Model
{
    [Serializable]
    public class ItemContainerInfo
    {
        public int ContainerId { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string Remark { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string UpdateBy { get; set; }
        public DateTime UpdateDateTime { get; set; }
    }
}