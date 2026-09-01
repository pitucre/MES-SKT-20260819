using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MsdEncapInfo
    {


        /// <summary>
        /// 物料编号
        /// </summary>
        public string SerialNumber { get; set; }


        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemCode { get; set; }


        /// <summary>
        /// 产品名称
        /// </summary>
        public string ItemName { get; set; }

        /// <summary>
        /// 产品规格
        /// </summary>
        public string ItemSpec { get; set; }
        
      

        /// <summary>
        /// 暴露总时长
        /// </summary>
        public decimal TotalExposeMinute { get; set; }

        /// <summary>
        /// 状态  1=已开封   2=已封装  3=恒温箱中  4=烘烤中 
        /// </summary>
        public string EncapStatus { get; set; }

      

        /// <summary>
        /// 允许暴露时长
        /// </summary>
        public Int32 FloorLife { get; set; }

        /// <summary>
        /// MSD等级
        /// </summary>
        public string Msl { get; set; }

        /// <summary>
        /// 烘烤次数
        /// </summary>
        public int BakeCount { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 剩余时长
        /// </summary>
        private decimal remainMinute;

        public decimal RemainMinute
        {
            get { return remainMinute; }
            set { remainMinute = value; }
        }

    }
}
