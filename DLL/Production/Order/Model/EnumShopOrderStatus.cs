using System;

namespace SKT.LeanMES.Order.Model
{
    /// <summary>
    /// Resource状态 枚举类
    /// </summary>
    public enum EnumShopOrderStatus
    {
        Releasable = 0,
        Planned = 1,
        Hold = 2,
        Done = 3,
        Closed = 4
    }
}
