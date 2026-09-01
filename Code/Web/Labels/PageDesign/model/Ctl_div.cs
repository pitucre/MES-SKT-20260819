using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    public class Ctl_div : ControlInfo
    {
        /// <summary>
        /// 文本
        /// </summary>
        public string text { get; set; }
        /// <summary>
        /// 跑马灯
        /// </summary>
        public bool marquee { get; set; }
        /// <summary>
        /// 滚动方向
        /// </summary>
        public string direction { get; set; }
        /// <summary>
        /// 滚动方式
        /// </summary>
        public string behavior { get; set; }
        /// <summary>
        /// 滚动速度
        /// </summary>
        public string scrollamount { get; set; }

    }
}