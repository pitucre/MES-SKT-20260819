using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.DataPush
{
    /// <summary>
    /// 工厂信息表
    /// </summary>
    public class BasalFactoryInfo
    {
        /// <summary>
        /// 主键
        /// </summary>
        public int FactoryID { get; set; }

        /// <summary>
        /// 工厂名
        /// </summary>
        public string FactoryName { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        public string FactoryCode { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// ChkIsDefaultFactory
        /// </summary>
        public int ChkIsDefaultFactory { get; set; }

        /// <summary>
        /// 公司/工厂类型： 1、工厂  2、公司
        /// </summary>
        public int? TypeId { get; set; }

        /// <summary>
        /// 工厂API地址（子工厂才需要设置，由总部WebApi通过定时任务，将数据分发到子工厂）
        /// </summary>
        public string Api { get; set; }
    }

}