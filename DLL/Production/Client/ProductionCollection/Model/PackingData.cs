using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    /// <summary>
    /// 栈板与包装箱关联、产品序列号与包装箱关联
    /// </summary>
    public class PackingData
    {
        public int PackDataId { get; set; }
        /// <summary>
        /// 包装箱号或栈板号
        /// </summary>
        public string ContainerSN { get; set; }
        public string BoxSN { get; set; }
        /// <summary>
        /// SN或者包装箱号
        /// </summary>
        public string SerialNumber { get; set; }
        public int OpeId { get; set; }
        public int ResId { get; set; }
        public int UserId { get; set; }
        public DateTime CreateTime { get; set; }
        public string LocationCode { get; set; }
        public int StorageState { get; set; }
        /// <summary>
        /// 更新日期
        /// </summary>
        public DateTime ModifyDateTime { get; set; }
        /// <summary>
        /// 更新人
        /// </summary>
        public string ModifyBy { get; set; }
    }
}
