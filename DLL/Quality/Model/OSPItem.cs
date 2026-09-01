using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Quality.Model
{
    public class OSPItem
    {
        public int OSPItemId { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public string OSPItemDtl { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }

        public string ModifyBy { get; set; }
        public DateTime? ModifyDateTime { get; set; }
    }
}
