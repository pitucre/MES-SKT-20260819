using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public  class MsdMeterielInfo
    {
        /// <summary>
        /// 产品ID
        /// </summary>
        public int ItemId { get; set; }

        /// <summary>
     /// 产品名称
     /// </summary>
       public string ItemName { get; set; }

        /// <summary>
        /// 产品编码
        /// </summary>
        public string ItemCode { get;set; }

        /// <summary>
        /// MSD 等级
        /// </summary>
        public string MsdLevel { get; set; }

        /// <summary>
        /// 烘烤次数
        /// </summary>
        public int BakeCount { get; set; }

        /// <summary>
        /// 暴露时长
        /// </summary>
        public int FloorLife { get; set; }


        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

    }
}
