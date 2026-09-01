using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Labels.Pdf
{
    /// <summary>
    /// 创建pdf参数
    /// </summary>
    public class PdfCreateContent
    {
        public PdfCreateContent() { }
        /// <summary>
        /// 创建时的参数
        /// </summary>
        /// <param name="width"></param>
        /// <param name="height"></param>
        /// <param name="url"></param>
        /// <param name="font"></param>
        /// <param name="list"></param>
        /// <param name="data"></param>
        public PdfCreateContent(float width, float height, string url, Dictionary<string, string> font, List<PrintTemplateDtl> list, List<PrintDataInfo> data)
        {
            this.Width = width;
            this.Height = height;
            this.PdfUrl = url;
            this.FontFamilys = font;
            this.List = list;
            this.Data = data;
        }

        /// <summary>
        /// 纸宽
        /// </summary>
        public float Width { get; set; }
        /// <summary>
        /// 纸高
        /// </summary>
        public float Height { get; set; }
        /// <summary>
        ///  获取打印模板明细信息
        /// </summary>
        public List<PrintTemplateDtl> List { get; set; }
        /// <summary>
        /// 打印内容
        /// </summary>
        public List<PrintDataInfo> Data { get; set; }
        /// <summary>
        /// Pdf生成地址
        /// </summary>
        public string PdfUrl { get; set; }
        /// <summary>
        /// 字体
        /// </summary>
        public Dictionary<string, string> FontFamilys { get; set; }
        /// <summary>
        /// 数量
        /// </summary>
        public int Count { get; set; }

        /// <summary>
        /// 打印份数（页数）
        /// </summary>
        public int PrintQty { get; set; }
    }
    /// <summary>
    /// 打印pdf参数
    /// </summary>
    public class PdfPrintContent : PdfCreateContent
    {
        /// <summary>
        ///打印参数 0无插件打印 , 1 adobe插件打印  2 zpl
        /// </summary>
        public int Type { get; set; }
        /// <summary>
        /// 如果包含lab文件，则用lab文件打印
        /// </summary>
        public string LabFileName { get; set; }
        /// <summary>
        /// 版本号，主要是区分客户端是什么版本
        /// </summary>
        public string Version { get; set; }
        /// <summary>
        /// 打印参数 打印机名称
        /// </summary>
        public string PrintName { get; set; }
        /// <summary>
        /// Domain + Url 就是接口地址，Domain+标签图片Url就是图片地址
        /// </summary>
        public string Domain { get; set; }
        /// <summary>
        /// 一般处理程序地址
        /// </summary>
        public string Url { get; set; }
        /// <summary>
        /// MES系统版本号：1：MES_8.5 2：MOM_9.0
        /// </summary>
        public string MesVersion { get; set; }

    }
    /// <summary>
    /// 打印pdf参数,从数据库取数
    /// </summary>
    public class PdfPrintDBContent : PdfPrintContent
    {
        /// <summary>
        /// 数据id
        /// </summary>
        public string DataId { get; set; }
        /// <summary>
        /// 模板id
        /// </summary>
        public string TempId { get; set; }
    }
    /// <summary>
    ///模板标签信息
    /// </summary>
    public class PrintTemplateDtl
    {
        /// <summary>
        ///行高
        /// </summary>
        public float lineHeight { get; set; }
        /// <summary>
        /// 宽度
        /// </summary>
        public float width { get; set; }
        /// <summary>
        /// 高度
        /// </summary>
        public float height { get; set; }
        /// <summary>
        /// y轴
        /// </summary>
        public float top { get; set; }
        /// <summary>
        /// x轴
        /// </summary>
        public float left { get; set; }
        /// <summary>
        /// 类型
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// 层级
        /// </summary>
        public int zIndex { get; set; }
        /// <summary>
        /// 文本
        /// </summary>
        public string text { get; set; }
        /// <summary>
        /// 边框颜色
        /// </summary>
        public string borderColor { get; set; }
        /// <summary>
        /// 边宽度
        /// </summary>
        public float borderWidth { get; set; }
        /// <summary>
        /// 边框样式
        /// </summary>
        public string borderStyle { get; set; }
        /// <summary>
        /// key
        /// </summary>
        public string key { get; set; }
        /// <summary>
        /// 字体类型
        /// </summary>
        public string fontFamily { get; set; }
        /// <summary>
        /// 自动换行
        /// </summary>
        public string wordBreak { get; set; }
        /// <summary>
        /// 换行后不超出区域
        /// </summary>
        public string overflow { get; set; }
        /// <summary>
        /// 下划线
        /// </summary>
        public bool underline { get; set; }
        /// <summary>
        /// 删除线
        /// </summary>
        public bool linethrough { get; set; }
        /// <summary>
        /// 背景颜色
        /// </summary>
        public string backgroundColor { get; set; }
        /// <summary>
        /// 字体大小
        /// </summary>
        public float fontSize { get; set; }
        /// <summary>
        /// 字间距
        /// </summary>
        public float fontSpace { get; set; }
        /// <summary>
        /// 字体颜色
        /// </summary>
        public string color { get; set; }
        /// <summary>
        /// 粗体
        /// </summary>
        public string fontWeight { get; set; }
        /// <summary>
        /// 对齐方式
        /// </summary>
        public string textAlign { get; set; }
        /// <summary>
        /// 字体样式
        /// </summary>
        public string fontStyle { get; set; }
        /// <summary>
        /// 密度
        /// </summary>
        public int version { get; set; }
        /// <summary>
        /// 清晰度
        /// </summary>
        public int scale { get; set; }
        /// <summary>
        /// 地址
        /// </summary>
        public string url { get; set; }
        /// <summary>
        /// 圆角
        /// </summary>
        public float radius { get; set; }
        /// <summary>
        /// 旋转度数
        /// </summary>
        public float rote { get; set; }
        /// <summary>
        /// 旋转基点
        /// </summary>
        public string origin { get; set; }
        /// <summary>
        /// 线宽
        /// </summary>
        public float lineWidth { get; set; }
        /// <summary>
        /// 线条颜色
        /// </summary>
        public string strokeStyle { get; set; }
        /// <summary>
        /// 线条起点x轴
        /// </summary>
        public float line_bx { get; set; }
        /// <summary>
        /// 线条起点y轴
        /// </summary>
        public float line_by { get; set; }
        /// <summary>
        /// 线条终点x轴
        /// </summary>
        public float line_ex { get; set; }
        /// <summary>
        /// 线条终点y轴
        /// </summary>
        public float line_ey { get; set; }
        /// <summary>
        /// 虚线长
        /// </summary>
        public float unitsOn { get; set; }
        /// <summary>
        /// 虚线间隙
        /// </summary>
        public float unitsOff { get; set; }
        /// <summary>
        /// 左内距
        /// </summary>
        public float paddingLeft { get; set; }
        /// <summary>
        /// 右内距
        /// </summary>
        public float paddingRight { get; set; }
        /// <summary>
        /// 分组
        /// </summary>
        public int group { get; set; }

        private bool _includeLabel = false;
        /// <summary>
        /// 是否包含标签
        /// </summary>
        public bool includeLabel
        {
            get
            {
                return _includeLabel;
            }
            set
            {
                _includeLabel = value;
            }
        }

        private bool _includeBorder = false;
        /// <summary>
        /// 是否包含边框（用于Barcode）
        /// </summary>
        public bool includeBorder
        {
            get
            {
                return _includeBorder;
            }
            set
            {
                _includeBorder = value;
            }
        }
        private bool _enaleAutoTextSize = false;
        /// <summary>
        /// 是否启用文本自适应模式（Text标签）
        /// </summary>
        public bool enaleAutoTextSize
        {
            get
            {
                return _enaleAutoTextSize;
            }
            set
            {
                _enaleAutoTextSize = value;
            }
        }
        /// <summary>
        /// 条形码模块的宽度（300DPI为列子，1px = 3.333mil = 0.0846582mm）
        /// </summary>
        public int? barWidth { get; set; }

    }
    public class PrintDataInfo
    {
        public List<PrintKeyValue> LabelContent { get; set; }
    }
    public class PrintKeyValue
    {
        public string name { get; set; }
        public string value { get; set; }
        public string OriginalName { set; get; }
    }
    public class RoteRectangle
    {
        public float top { get; set; }
        public float left { get; set; }
        public float width { get; set; }
        public float height { get; set; }
    }

    /// <summary>
    /// 字体信息
    /// </summary>
    public class FontInfo
    {
        /// <summary>
        /// 字体名称
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// 字体文件路径
        /// </summary>
        public string FileName { get; set; }

        /// <summary>
        /// 字体文件索引(包含多个字体时对应的路径)
        /// </summary>
        public int Index { get; set; }

    }
}
