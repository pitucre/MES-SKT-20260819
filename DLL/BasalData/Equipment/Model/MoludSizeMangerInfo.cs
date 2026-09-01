using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class MoludSizeMangerInfo
    {
        public int MsmId { get; set; }
        public int MouldId { get; set; }
        public string MouldeCode { get; set; }
        public int MouldBomId { get; set; }
        public string BomName { get; set; }
        public int MouldTypeId { get; set; }

        public string MouldTypeName { get; set; }
        public string MouldTypeCode { get; set; }
        public decimal ExternalDiameter1 { get; set; }
        public decimal ExternalDiameter2 { get; set; }
        public decimal ExternalDiameter3 { get; set; }
        public decimal ExternalDiameterAvg { get; set; }
        public decimal InternalDiameter1 { get; set; }
        public decimal InternalDiameter2 { get; set; }
        public decimal InternalDiameter3 { get; set; }
        public decimal InternalDiameterAvg { get; set; }
        public int Hardness { get; set; }
        public int Result { get; set; }
        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
        public string Remark { get; set; }
        public decimal ExternalDiameterMin { get; set; }
        public decimal ExternalDiameterMax { get; set; }
        public decimal InternalDiameterMin { get; set; }
        public decimal InternalDiameterMax { get; set; }
        public decimal TestItem3_1 { get; set; }
        public decimal TestItem3_2 { get; set; }
        public decimal TestItem3_3 { get; set; }
        public decimal TestItem3Avg { get; set; }
        public decimal TestItem3Min { get; set; }
        public decimal TestItem3Max { get; set; }
        public string Units { get; set; }
        public string ComponentName { get; set; }
        public int TestCount { get; set; }
        public int UseCount { get; set; }
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