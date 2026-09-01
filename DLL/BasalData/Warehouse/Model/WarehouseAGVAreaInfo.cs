using System;

namespace SKT.LeanMES.Warehouse.Model
{
    public class WarehouseAGVAreaInfo
    {
       
        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

       

        /// <summary>
        /// ID
        /// </summary>
        public int ID { get; set; }

       

      


        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// AGV区域名称
        /// </summary>
        public string CategoryName { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }
    }
}
