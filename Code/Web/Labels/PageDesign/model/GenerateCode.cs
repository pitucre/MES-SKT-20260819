using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using Newtonsoft.Json;

namespace SKT.LeanMES.Web.Labels
{
    public class GenerateCode
    {
        /// <summary>
        /// 根据控件生成html页面代码
        /// </summary>
        /// <param name="json"></param>
        /// <returns></returns>
        public string ToHtml(string data, string control)
        {
            LayoutControl info = JsonConvert.DeserializeObject<LayoutControl>(data);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("<!DOCTYPE html>");
            sb.AppendLine("<html>");
            sb.AppendLine("<head>");
            sb.AppendLine("<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\"/>");
            sb.AppendLine("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\" />");
            sb.AppendLine("    <title></title>");
            sb.AppendLine("    <script src=\"../Content/js/jquery-2.0.0.min.js\"></script>");
            sb.AppendLine("    <script src=\"../Content/plugin/echarts/echarts.min.js\"></script>");
            sb.AppendLine("    <script src=\"PageDesign/layui/layui.all.js\"></script>");
            sb.AppendLine("    <link href=\"PageDesign/layui/css/layui.css\" rel=\"stylesheet\" />");
            sb.AppendLine("    <link href=\"PageDesign/main.css\" rel=\"stylesheet\" />");
            sb.AppendLine("    <meta charset=\"utf-8\"/>");
            sb.AppendLine("</head>");
            sb.AppendLine("<body id=\"panel1\" class=\"layui-form\">");
            sb.AppendLine("");
            sb.AppendLine("</body>");
            sb.AppendLine("</html>");
            sb.AppendLine("<script type=\"text/javascript\">");
            sb.AppendLine("    var _PageDesignOptions = {");
            sb.AppendLine("        events: {");
            sb.Append(ToEvent(info));
            sb.AppendLine("            resize:function(design){");
            sb.Append(ToResize(info));
            sb.AppendLine("            }");
            sb.AppendLine("        },");
            sb.AppendLine("        ispreview: true,");
            sb.AppendLine("        control:" + control + ",");
            sb.AppendLine("        data:" + data);
            sb.AppendLine("    };");
            sb.AppendLine("</script>");
            sb.AppendLine("<script src=\"PageDesign/main.js\"></script>");
            return sb.ToString();
        }

        private string ToEvent(LayoutControl info)
        {
            string events = null;
            string str = null;
            Type type = Type.GetType(this.GetType().Namespace + ".Ctl_" + info.type, false, true);
            if (type != null)
            {
                info.Control = (ControlInfo)JsonConvert.DeserializeObject(info.contentAttr, type);
                str = info.GetEventCode(info.Control.id);
                if (str != null)
                    events += str;
            }
            if (info.child != null)
            {
                info.child.ForEach(item =>
                {
                    str = ToEvent(item);
                    if (str != null)
                        events += str;
                });
            }
            return events;
        }
        private string ToResize(LayoutControl info)
        {
            StringBuilder sb = new StringBuilder();
            if (info.type == "bar" || info.type == "pie" || info.type == "line")
            {
                sb.AppendLine("                echarts.init(document.getElementById('" + info.Control.id + "')).resize();");
            }
            else if (info.type == "datatable")
            {
                sb.AppendLine("                layui.table.reload('" + info.Control.id + "',{height: design.findItemById('" + info.type + info.id + "').area.heightContent});");
            }
            if (info.child != null)
            {
                info.child.ForEach(item =>
                {
                    string result = ToResize(item);
                    if (!string.IsNullOrWhiteSpace(result))
                        sb.Append(result);
                });
            }
            return sb.ToString();
        }
    }
}