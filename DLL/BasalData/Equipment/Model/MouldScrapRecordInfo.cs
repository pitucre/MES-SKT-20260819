using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class MouldScrapRecordInfo
    {


        public int Id { get; set; }
        public int MouldId { get; set; }
        public string MouldName { get; set; }
        public int EquipmentId { get; set; }
        
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }

        public string ScrapType { get; set; }
        /// <summary>
        /// 创建人
        /// </summary>
        public String CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public String Remark { get; set; }
        public string PersonInCharge { get; set; }
        public int DepartmentId { get; set; }



    }
}