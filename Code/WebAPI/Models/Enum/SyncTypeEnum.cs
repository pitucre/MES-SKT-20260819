using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.Enum
{
    public enum SyncTypeEnum
    {
        /// <summary>
        /// 按单号同步
        /// </summary>
        BillNoSync,

        /// <summary>
        /// 全表同步
        /// </summary>
        FullSync,

        /// <summary>
        /// 增量同步
        /// </summary>
        DateTimeSync,
    }


}