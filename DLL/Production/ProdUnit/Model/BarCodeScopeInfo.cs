using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdUnit.Model
{
    [Serializable]
    public class BarCodeScopeInfo
    {
        
        public int ScopeId { get; set; }//主键ID
        public string OrderNo { get; set; }//工单号
        public string CustomerOrder { get; set; }//订单号
        public string NumberType { get; set; }//号码类型
        public string MaskNo { get; set; }//掩码
        public string Hexadecimal { get; set; }//进制
        public string SerialBegin { get; set; }//起始流水号
        public string SerialEnd { get; set; }//结束流水号
        public int SerialLength { get; set; }//流水号长度
        public int Qty { get; set; }//数量
        public string NumberBegin { get; set; }//完整起始号码
        public string NumberEnd { get; set; }//完整结束号码
        public string SpecialStr { get; set; }//特殊字符
        public string CreateBy { get; set; }//建立人
        public DateTime CreateDateTime { get; set; }//建立日期

        public int MacQty { get; set; }//数量
        public int Increase { get; set; }//递增量
        public string Prefix { get; set; }//条码前缀
        public string Suffix { get; set; }//条码后缀
        public string SerialNumber { get; set; }//条码
        public int SerialNumberID { get; set; }//主键ID
        public int NumberID { get; set; }//工单内序号
        public string Status { get; set; }//使用状态
        public string IsMain { get; set; }//使用状态
        public string Fixed { get; set; }//使用状态
        public string NumberClass { get; set; }//使用状态

        public string SerialNumber1 { get; set; }//条码

        public int ProdOrderID { get; set; }//工单ID
        public int ItemId { get; set; }//产品ID
        public string ErrorMessage { get; set; }//错误信息
        

        public BarCodeScopeInfo()
        {
        }

        /// <summary>
        /// 最后修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 组别
        /// </summary>
        public int GroupNumber { get; set; }

        /// <summary>
        /// 工单数量
        /// </summary>
        public int OrderQty { get; set; }

        /// <summary>
        /// 最后修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}
