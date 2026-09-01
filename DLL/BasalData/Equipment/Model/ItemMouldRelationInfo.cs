using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class ItemMouldRelationInfo
    {
      
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemMouldRelationId{ get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public int ItemId { get; set; }
        public String ItemCode { get; set; }
        public string ItemName { get; set; }


        public int MouldId { get; set; }
        public string BomName { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        public int IsDelete { get; set; }
        public string ItemSpec { get; set; }
    }
}