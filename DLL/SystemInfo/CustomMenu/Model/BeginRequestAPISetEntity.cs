using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.CustomMenu.Model
{
    public class BeginRequestAPISetEntity
    {
        public int Id { get; set; }
        public string RequestUrl { get; set; }
        public string Deal_Param_Proc { get; set; }
        public string APIUrl { get; set; }
        /// <summary>
        /// API请求方式
        /// Get,post
        /// </summary>
        public string APIMethod { get; set; }
        public string Deal_Result_Proc { get; set; }
        public string Remark { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public string CreateBy { get; set; }
        /// <summary>
        /// 返回类型
        ///0 JSON  1  字符串  2 文件流
        /// </summary>
        public int ResultType { get; set; }
        /// <summary>
        /// 异常处理
        /// 0抛出异常  1继续执行
        /// </summary>
        public int DealError { get; set; }
        /// <summary>
        /// 请求节点
        /// 0开始请求前  1请求结束后
        /// </summary>
        public int Application { get; set; }
        /// <summary>
        /// 参数提交方式
        /// 0JSON提交 1FORM提交 2URL提交
        /// </summary>
        public int ContentType { get; set; }
    }
}
