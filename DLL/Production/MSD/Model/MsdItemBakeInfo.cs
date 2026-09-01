using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdItemBakeInfo
    {
        public MsdItemBakeInfo() { }




        /// <summary>
        /// 物料编号
        /// </summary>
        public string SerialNumber { get; set; }


        /// <summary>
        /// MSD等级
        /// </summary>
        public string MSL { get; set; }
   
        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 物料编号
        /// </summary>
        public string ItemCode { get; set; }

        /// <summary>
        /// 产品规格
        /// </summary>
        public string ItemSpec { get; set; }


        /// <summary>
        /// 烘烤时长
        /// </summary>
        public decimal HoursNum { get; set; }
        /// <summary>
        /// 烘烤时长
        /// </summary>
        public string HoursNumStr { get; set; }

        /// <summary>
        /// 扫描时间
        /// </summary>
        public DateTime ScanTime { get; set; }



        /// <summary>
        /// 烘烤次数
        /// </summary>
        public int BakeCount { get; set; }

        /// <summary>
        /// 已烘烤次数
        /// </summary>
        public int AlreadyBakeCount { get; set; }


        /// <summary>
        /// 温度
        /// </summary>
        public int Temperature { get; set; }

  

    }
}
