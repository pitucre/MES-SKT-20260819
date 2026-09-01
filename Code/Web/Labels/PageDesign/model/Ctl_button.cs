using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    /// <summary>
    /// 按钮
    /// </summary>
    public class Ctl_button : ControlInfo
    {
        /// <summary>
        /// 文本
        /// </summary>
        public string text { get; set; }
        /// <summary>
        /// 主题
        /// </summary>
        public string theme { get; set; }
        /// <summary>
        /// 大小
        /// </summary>
        public string size { get; set; }
        /// <summary>
        /// 圆角
        /// </summary>
        public string radius { get; set; }
        /// <summary>
        /// 图标
        /// </summary>
        public string icon { get; set; }
    }
}