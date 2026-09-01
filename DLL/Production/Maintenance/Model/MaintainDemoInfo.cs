using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Maintenance.Model
{
    public class MaintainDemoInfo
    {
        public int PlanID { get; set; }

        public int DemoID { get; set; }

        public int DemoSubID { get; set; }

        /// <summary>
        /// PDA界面选择的保养方式 1: 时间 2: 次数
        /// </summary>
        public int MaintainWay { get; set; }

        public int IsDone { get; set; }

        public int IsOK { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }
    }
}
