using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.HWLicense
{
    public class BaseLicenseInfo
    {
        /// <summary>
        /// BaseLicenseInfo
        /// </summary>
        public string activity { set; get; }
        /// <summary>
        /// 授权码
        /// </summary>
        public string license { set; get; }
        /// <summary>
        /// 变更状态： FREEZE：冻结  UNFREEZE：解冻
        /// </summary>
        public string status { set; get; }
        /// <summary>
        /// 云商店订单ID
        /// </summary>
        public string orderId { set; get; }
        /// <summary>
        /// 云商店订单ID
        /// </summary>
        public string orderLineId { set; get; }
        /// <summary>
        /// 过期时间  格式：yyyyMMddHHmmss
        /// </summary>
        public string expireTime { set; get; }
        /// <summary>
        /// 产品标识，租户续费或转正产品授权码时，如果订购周期类型发生变化，会传入变化后的产品类型对应的productId
        /// </summary>
        public string productId { set; get; }
        /// <summary>
        /// 场景，触发授权码变更的场景： RENEWAL：续费    UNSUBSCRIBE_RENEWAL_PERIOD：退续费"
        /// </summary>
        public string scene { set; get; }
        /// <summary>
        /// 是否为调试请求。1：调试请求  0：非调试请求  默认取值为“0”。
        /// </summary>
        public string testFlag { set; get; }
    }
}