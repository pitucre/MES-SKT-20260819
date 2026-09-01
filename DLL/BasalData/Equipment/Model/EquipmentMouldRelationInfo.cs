using System;

namespace SKT.LeanMES.Equipment.Model
{
    public class EquipmentMouldRelationInfo
    {

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentMouldRelationId { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public int EquimentId { get; set; }
        public string EquimentCode { get; set; }
        public string EquimentName { get; set; }


        public int MouldId { get; set; }
        public string BomName { get; set; }
        public string BomCode { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy { get; set; }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime { get; set; }

        public int IsDelete { get; set; }
        public string ItemSpec { get; set; }

        public string CreateBy2 { get; set; }

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