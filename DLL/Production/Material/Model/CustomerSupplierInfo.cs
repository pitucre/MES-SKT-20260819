using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class CustomerSupplierInfo
    {
        /// <summary>
        /// 供应商ID
        /// </summary>
        public int SupplierId { set; get; }
        /// <summary>
        /// 供应商代码
        /// </summary>
        public string VendorCode { set; get; }
        /// <summary>
        /// 供应商名称
        /// </summary>
        public string VendorName { set; get; }
    }
}
