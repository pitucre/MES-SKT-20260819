using System;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// 模具Bom实体
    /// </summary>
    [Serializable]
    public class MoludBomInfo
    {
        public int MouldBomId { get; set; }
        public string BomName { get; set; }
        public decimal InternalDiameter { get; set; }
        public decimal ExternalDiameter { get; set; }
        public decimal Acreage { get; set; }
        public int MaxPressure { get; set; }
        public string Describe { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public string ModifyBy { get; set; }
        public DateTime? ModifyTime { get; set; }

    }

    public class MoludBomChildInfo
    {
        public int MouldBomChildId { get; set; }
        public int MouldBomId { get; set; }
        public int MouldTypeId { get; set; }
        public string ComponentCode { get; set; }
        public string Describe { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }

        public string EquipmentTypeCode { get; set; }
        public string EquipmentTypeName { get; set; }

        /// <summary>
        /// 替代构件
        /// </summary>
        public string ReplaceComponentName { get; set; }
    }

   
}