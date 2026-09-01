using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class RmaInfo
    {
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.RmaInfo 类的新实例。
        /// </summary>
        public RmaInfo()
        {
        }

        public int RmaId { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public int RTypeId { get; set; }

        public string RTypeName { get; set; }

        /// <summary>
        /// Rma单号
        /// </summary>
        public string RmaNo { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public DateTime CancelTime { get; set; }


        /// <summary>
        /// 机种ID
        /// </summary>
        public int MachineTypeId { get; set; }

        /// <summary>
        /// 机种名称
        /// </summary>
        public string MachineTypeName { get; set; }


        public string ItemCode { get; set; }

        /// <summary>
        /// 客户ID
        /// </summary>
        public int CustomerId { get; set; }

        /// <summary>
        /// 客户ID
        /// </summary>
        public string CustomerName { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int Number { get; set; }


        public string Remark { get; set; }

        public string StatusName { get; set; }

        public int Status { get; set; }

        public string CreateBy { get; set; }

        public DateTime CreateTime { get; set; }

        public string FilePath { get; set; }

        public Int32 GoodNum { get; set; }

        public Int32 FailNum { get; set; }

        public Int32 ScrapNum { get; set; }

        public string RmaDetails { get; set; }

        public string ItemSpec { set; get; }



        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }

    }
}