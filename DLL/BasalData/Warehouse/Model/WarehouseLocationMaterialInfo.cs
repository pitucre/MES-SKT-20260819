using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseLocationMaterialInfo
    {

        /// <summary>
        /// 获取或设置主键ID
        /// </summary>
        public Int32 WarehouseLocationMaterialId { get; set; }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int32 ItemId { get; set; }

        /// <summary>
        /// 获取或设置物料编码
        /// </summary>
        public String ItemCode { get; set; }
        /// <summary>
        /// 获取或设置仓库ID
        /// </summary>
        public Int32 CWhId { get; set; }

        /// <summary>
        /// 获取或设置仓库编码
        /// </summary>
        public String CWhCode { get; set; }

        /// <summary>
        /// 获取或设置货位ID
        /// </summary>
        public Int32 CWlId { get; set; }

        /// <summary>
        /// 获取或设置货位条码
        /// </summary>
        public String CBarCode { get; set; }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy { get; set; }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy { get; set; }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime { get; set; }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark { get; set; }

        
    }
}
