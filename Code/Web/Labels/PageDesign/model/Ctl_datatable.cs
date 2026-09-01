using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;

namespace SKT.LeanMES.Web.Labels
{

    /// <summary>
    /// datatable
    /// </summary>
    public class Ctl_datatable : ControlInfo
    {
        //表头属性
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string headbgcolor { get; set; }
        /// <summary>
        /// 字体颜色
        /// </summary>
        public string headftcolor { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public int headftSize { get; set; }
        /// <summary>
        /// 粗体
        /// </summary>
        public string headftWeight { get; set; }
        //表体属性
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string bodybgcolor { get; set; }
        /// <summary>
        /// 字体颜色
        /// </summary>
        public string bodyftcolor { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public int bodyftSize { get; set; }
        /// <summary>
        /// 粗体
        /// </summary>
        public string bodyftWeight { get; set; }
        //跑马灯
        public bool marquee { get; set; }
        /// <summary>
        /// 滚动方式
        /// </summary>
        public string behavior { get; set; }
        /// <summary>
        /// 隐藏滚动条
        /// </summary>
        public bool hidescrolly { get; set; }
        /// <summary>
        /// 滚动速度
        /// </summary>
        public int scrollamount { get; set; }
    }
}