using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentChildInfo
    {


        /// <summary>
        /// 设备Id
        /// </summary>
        public int EquipmentChildId { get; set; }


        /// <summary>
        /// 上级设备Id
        /// </summary>
        public int ParentEquipmentId { get; set; }


        /// <summary>
        /// 设备名称
        /// </summary>
        public String EquipmentNameChild { get; set; }


        /// <summary>
        /// 设备编码
        /// </summary>
        public String EquipmentCodeChild { get; set; }


        /// <summary>
        /// 父设备名称
        /// </summary>
        public string EquipmentName { get; set; }


        /// <summary>
        /// 父设备编码
        /// </summary>
        public string EquipmentCode { get; set; }



        /// <summary>
        /// 型号规格
        /// </summary>
        public string TypeSpec { get; set; }


        /// <summary>
        /// 型号规格
        /// </summary>
        public string EquipmentModel { get; set; }

        /// <summary>
        /// 型号规格
        /// </summary>
        public string ChildEquimentModel { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public String CreateBy { get; set; }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime { get; set; }


        /// <summary>
        /// 备注
        /// </summary>
        public String Remark { get; set; }

        public bool IsDelete { get; set; }


        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
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