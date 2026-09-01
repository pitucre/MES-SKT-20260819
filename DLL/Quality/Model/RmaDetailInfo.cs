using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class RmaDetailInfo
    {
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RmaInfo 类的新实例。
        /// </summary>
        public RmaDetailInfo()
        {
        }

        public int RmaDetailId { get; set; }

    
        public string SerialNumber { get; set; }

        /// <summary>
        /// Rma单号
        /// </summary>
        public string RmaNo { get; set; }

        /// <summary>
        /// 机种名称
        /// </summary>
        public string RejectsDesc { get; set; }

      

        public string Remark { get; set; }

    }
}