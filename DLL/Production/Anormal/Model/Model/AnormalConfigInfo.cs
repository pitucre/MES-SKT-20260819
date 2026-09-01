using System;

namespace SKT.LeanMES.ProdAnormal.Model
{
   
    public class AnormalConfigInfo
    {
       public int AnormalConfigID { get; set; }
        public int AnormalTypeId { get; set; }
        public string Receiver { get; set; }
        public string ReceiverName { get; set; }
        public int SendWay { get; set; }
        public DateTime? CreateDateTime { get; set; }
        public string CreateBy { get; set; }
        public DateTime? ModifyDateTime { get; set; }
        public string ModifyBy { get; set; }
        public string AnormalTypeName { get; set; }

    }
}
