using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    /// <summary>
    /// 复选框
    /// </summary>
    public class Ctl_checkbox : ControlInfo
    {
        /// <summary>
        /// 风格
        /// </summary>
        public string skin { get; set; }
        /// <summary>
        /// 文本内容
        /// </summary>
        public string title { get; set; }
    }
}