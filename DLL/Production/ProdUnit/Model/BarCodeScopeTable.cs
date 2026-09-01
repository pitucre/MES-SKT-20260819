using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProdUnit.Model
{
    [Serializable]
    public class BarCodeScopeTable
    {
        public string NumberType { get; set; }//号码类型
        public string NumberClass { get; set; }//使用状态
        public string Prefix { get; set; }//条码前缀
        public string Suffix { get; set; }//条码后缀
        public int SerialLength { get; set; }//流水号长度
        public string SerialBegin { get; set; }//起始流水号
        public string SerialEnd { get; set; }//结束流水号
        public string SpecialStr { get; set; }//特殊字符
        public int Increase { get; set; }//递增量
        public string NumberBegin { get; set; }//完整起始号码
        public string NumberEnd { get; set; }//完整结束号码
        
        public string IsMain { get; set; }//使用状态
        public string Fixed { get; set; }//使用状态
        

        public BarCodeScopeTable()
        {
        }
    }
}
