using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models
{
    public class BulkInsertInfo
    {
        /// <summary>
        /// 受影响的行数
        /// </summary>
        public int AffectedCount { get; set; }

        /// <summary>
        /// 单据号
        /// </summary>
        public List<string> ListBillNo { get; set; }
    }
}