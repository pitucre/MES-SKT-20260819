using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SDP.Model
{
    public class ProcParamsInfo
    {
        /// <summary>
        /// 参数名称
        /// </summary>
        public string ParamName { get; set; }
        /// <summary>
        /// 参数类型
        /// </summary>
        public string DataType { get; set; }
        /// <summary>
        /// 参数长度
        /// </summary>
        public int Length { get; set; }
        /// <summary>
        /// 小数位长度
        /// </summary>
        public int Scale { get; set; }
        /// <summary>
        /// 参数顺序号
        /// </summary>
        public int SortId { get; set; }
        /// <summary>
        /// 是否输出参数
        /// </summary>
        public bool IsOutput { get; set; }
    }
    public class ParamsInfo
    {
        public string name { get; set; }
        public string value { get; set; }
    }
}
