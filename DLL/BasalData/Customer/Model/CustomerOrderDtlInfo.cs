using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Customer.Model
{
    public class CustomerOrderDtlInfo
    {
        /// <summary>
        /// Id
        /// </summary>
        public int CusDtlId { set; get; }
        /// <summary>
        /// 行号
        /// </summary>
        public string AutoID { set; get; }
        /// <summary>
        /// 主表ID
        /// </summary>
        public int CustomerOrderID { set; get; }
        /// <summary>
        /// 订单号
        /// </summary>
        public string CustomerOrder { set; get; }
        /// <summary>
        /// 类型
        /// </summary>
        public int SODType { set; get; }
        /// <summary>
        /// 物料ID
        /// </summary>
        public int ItemID { set; get; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { set; get; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public string ItemName { set; get; }
        /// <summary>
        /// 物料描述
        /// </summary>
        public string ItemDes { set; get; }
        /// <summary>
        /// 物料描述
        /// </summary>
        public string ItemSpec { set; get; }
        /// <summary>
        /// 数量
        /// </summary>
        public int Qty { set; get; }
        /// <summary>
        /// 状态 9为已开启   10为已关闭
        /// </summary>
        public int OpenDataStatus { set; get; }
        /// <summary>
        /// 状态 9为已开启   10为已关闭
        /// </summary>
        public string OpenDataStatusName { set; get; }
        /// <summary>
        /// 工厂编号(MES集团多工厂标示,如ERP无该标示所有表统一传“1”)
        /// </summary>
        public string FactoryCode { set; get; }
        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { set; get; }
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime { set; get; }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { set; get; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDateTime { set; get; }
        /// <summary>
        /// 备注
        /// </summary>
        public string CusDtlRem { set; get; }
    }
}
