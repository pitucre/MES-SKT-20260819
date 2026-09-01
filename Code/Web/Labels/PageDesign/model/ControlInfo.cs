using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;

namespace SKT.LeanMES.Web.Labels
{
    public class Ctl_panel: ControlInfo { }
    /// <summary>
    /// 控件信息
    /// </summary>
    public class ControlInfo
    {
        /// <summary>
        /// id
        /// </summary>
        public string id { get; set; }
        /// <summary>
        /// 控件名称
        /// </summary>
        public string labname { get; set; }
    }
    public class ControlEvent
    {
        public string name { get; set; }
        public string remark { get; set; }
        public string code { get; set; }
    }
    /// <summary>
    /// 布局控件信息
    /// </summary>
    public class LayoutControl
    {
        /// <summary>
        /// id   type+id才是界面控件的id
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// 层级
        /// </summary>
        public int index { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 私有属性
        /// </summary>
        public string contentAttr { get; set; }
        /// <summary>
        /// 子集
        /// </summary>
        public List<LayoutControl> child { get; set; }
        /// <summary>
        /// 通用属性
        /// </summary>
        public Commonattribute attr { get; set; }
        /// <summary>
        /// 控件
        /// </summary>
        public ControlInfo Control { get; set; }
        /// <summary>
        /// 事件
        /// </summary>
        public List<ControlEvent> events { get; set; }
        /// <summary>
        /// 获取事件代码
        /// </summary>
        /// <param name="cid"></param>
        /// <returns></returns>
        public string GetEventCode(string cid)
        {
            if (events == null || events.Count == 0)
                return null;
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("            " + cid + ":{");
            for (int i = 0; i < events.Count; i++)
            {
                sb.AppendLine("                " + events[i].name + ":" + events[i].remark);
                sb.AppendLine("                {");
                sb.AppendLine("                    " + events[i].code.Replace("\n", "\n                    "));
                sb.AppendLine("                }" + ((i < events.Count - 1) ? "," : ""));
            }
            sb.AppendLine("            },");
            return sb.ToString();
        }
    }
    /// <summary>
    /// 通用属性
    /// </summary>
    public class Commonattribute
    {
        /// <summary>
        /// 允许内容超出区域高度  auto
        /// </summary>
        public string overflowY { get; set; }
        /// <summary>
        /// 宽度
        /// </summary>
        public float width { get; set; }
        /// <summary>
        /// 高度
        /// </summary>
        public float height { get; set; }
        /// <summary>
        ///宽度单位 0px   1%   2自适应  3填充
        /// </summary>
        public int widthUnit { get; set; }
        /// <summary>
        ///高度单位 0px   1%   2自适应  3填充
        /// </summary>
        public int heightUnit { get; set; }
        /// <summary>
        /// 宽度是否显示
        /// </summary>
        public bool wShow { get; set; }
        /// <summary>
        /// 高度是否显示
        /// </summary>
        public bool hShow { get; set; }
        /// <summary>
        /// 字体类型
        /// </summary>
        public string fontFamily { get; set; }
        /// <summary>
        /// 颜色
        /// </summary>
        public string color { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public int fontSize { get; set; }
        /// <summary>
        /// 行高
        /// </summary>
        public int lineHeight { get; set; }
        /// <summary>
        /// 字间距
        /// </summary>
        public int letterSpacing { get; set; }
        /// <summary>
        /// 对齐方式 left center right
        /// </summary>
        public string textAlign { get; set; }
        /// <summary>
        /// 粗体 bold
        /// </summary>
        public string fontWeight { get; set; }
        /// <summary>
        /// 斜体 italic
        /// </summary>
        public string fontStyle { get; set; }
        /// <summary>
        /// 上划线
        /// </summary>
        public int overline { get; set; }
        /// <summary>
        /// 贯穿线
        /// </summary>
        public int linethrough { get; set; }
        /// <summary>
        /// 下划线
        /// </summary>
        public int underline { get; set; }
        /// <summary>
        /// 阴影位置
        /// </summary>
        public string textShadowMargin { get; set; }
        /// <summary>
        /// 阴影颜色
        /// </summary>
        public string textShadowColor { get; set; }
        /// <summary>
        /// 边宽度
        /// </summary>
        public string borderWidth { get; set; }
        /// <summary>
        /// 边框颜色
        /// </summary>
        public string borderColor { get; set; }
        /// <summary>
        /// 边框虚线 dashed
        /// </summary>
        public string borderStyle { get; set; }
        /// <summary>
        /// 内边距 
        /// </summary>
        public string padding { get; set; }
        /// <summary>
        /// 外边距
        /// </summary>
        public string margin { get; set; }
        /// <summary>
        /// 阴影位置
        /// </summary>
        public string boxShadowMargin { get; set; }
        /// <summary>
        /// 阴影颜色
        /// </summary>
        public string boxShadowColor { get; set; }
        /// <summary>
        /// 阴影透明度   
        /// </summary>
        public decimal boxShadowOpacity { get; set; }
        /// <summary>
        /// 圆角
        /// </summary>
        public int borderRadius { get; set; }
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string backgroundColor { get; set; }
        /// <summary>
        /// 背景透明度
        /// </summary>
        public string bgOpacity { get; set; }
    }

}