using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Resource.Model
{
    /// <summary>
    /// Resource状态 枚举类
    /// </summary>
    public enum EnumResourceStatus
    {
        Enabled = 1,
        Disabled = 2,
        Hold = 3,
        Scheduled_Down = 4,
        Unscheduled_Down = 5,
        Non_scheduled = 6,
        Hold_Consec_NC = 7,
        Hold_SPC_Viol = 8,
        Hold_SPC_Warn = 9,
        Hold_Yield_Rate = 10,
        Unknown = 11,
        Productive = 12,
        Standby = 13,
        Engineering = 14
    }
}
