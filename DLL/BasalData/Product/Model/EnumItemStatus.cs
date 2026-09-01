using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Product.Model
{
    /// <summary>
    /// 产品状态 枚举类
    /// </summary>
    public enum EnumItemStatus
    {
        Releasable = 1,
        Frozen = 2,
        Obsolete = 3,
        Hold = 4,
        New = 5,
        Hold_Consec_NC = 6,
        Hold_SPC_Viol = 7,
        Hold_SPC_Warn = 8,
        Hold_Yield_Rate = 9
    }
    public enum EnumNextNumberResetType
    {
        Never = 1,
        Daily = 2,
        Weekly = 3,
        Monthly = 4,
        Yearly = 5
    }
}
