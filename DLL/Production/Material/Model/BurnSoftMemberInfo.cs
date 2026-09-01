using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class BurnSoftMemberInfo
    {
        public int BurnMemberId { get; set; }
        public int BurnId { get; set; }
        public int ItemId { get; set; }
    }
}
