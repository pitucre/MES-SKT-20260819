using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Labels.Model
{
    /// <summary>
    /// 打印模板
    /// </summary>
    public class PrintTemplateInfo
    {
        public int TempId { get; set; }
        public string TempSet { get; set; }
        public float PanelWidth { get; set; }
        public float PanelHeight { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateDateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public string TempName { get; set; }

        /// <summary>
        /// 如果包含lab文件，则用lab文件打印
        /// </summary>
        public string LabFileName { get; set; }
    }
}
