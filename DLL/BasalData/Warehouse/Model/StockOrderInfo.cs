using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Warehouse.Model
{
    public class StockOrderInfo
    {
        public string ERPSalOrderID { get; set; }
        /// <summary>
        /// 标示
        /// </summary>
        public int SalOrderID { get; set; }
        /// <summary>
        /// 销售单号
        /// </summary>
        public string DNCode { get; set; }
        /// <summary>
        /// 销售日期
        /// </summary>
        public string SalOrderDate { get; set; }
        /// <summary>
        /// 客户编码
        /// </summary>
        /// <returns></returns>
        public string CusCode { get; set; }
        /// <summary>
        /// 客户名称
        /// </summary>
        /// <returns></returns>
        public string CusName { get; set; }
        /// <summary>
        /// 地址
        /// </summary>
        /// <returns></returns>
        public string Address { get; set; }
        /// <summary>
        /// --状态 ０末备货１备货中２备货完成３已检验４已出货５取消
        /// </summary>
        public int Status { get; set; }
        public string StatusName { get; set; }
        /// <summary>
        /// --创建人（备货人）
        /// </summary>
        public string CreateBy { get; set; }
        /// <summary>
        /// --创建时间
        /// </summary>
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 确认人
        /// </summary>
        /// <returns></returns>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 确认时间
        /// </summary>
        /// <returns></returns>
        public DateTime ModifyDateTime { get; set; }
        /// <summary>
        /// 完成人（出货人）
        /// </summary>
        /// <returns></returns>
        public string FinishBy { get; set; }
        /// <summary>
        /// 确认人
        /// </完成时间>
        /// <returns></returns>
        public DateTime FinishDateTime { get; set; }
        /// <summary>
        /// 回传ERP状态
        /// </summary>
        public int BackERPStatus { get; set; }
        /// <summary>
        /// 回传ERP时间
        /// </summary>
        public DateTime BackERPDateTime { get; set; }

        public StockOrderInfo()
        {
        }
    }
}
