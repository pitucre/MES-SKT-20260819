using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class KanBanChartInfo
    { 
        public object Legen { get; set; }
        public object Axis { get; set; }
        public object Contrast { get; set; }
        public object Series { get; set; }
        public int AxisIndex { get; set; }
    }
}
