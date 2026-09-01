using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SerialNumber.Model
{
    public enum EnumItemType
    {
        Manufactured = 1,
        Purchased = 2,
        Manufactured_Purchased = 3
    }

    public enum EnumNextNumberResetType
    {
        Never = 1,
        Daily = 2,
        Weekly = 3,
        Monthly = 4,
        Yearly = 5
    }

    /// <summary>
    /// 序列号产生类型
    /// </summary>
    public enum EnumNextNumberType
    {
        SFC_Release = 1,
        Material_GRN = 2,
        Container_Number = 3,
        IQC_Number = 4,
        Receipt_Number =5,
        Pallet_Number =6
    }
}
