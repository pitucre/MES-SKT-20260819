using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class MoludApplyInfo
    {
        public int Cid { get; set; }
        public string ApplyNo { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public int EquimentId { get; set; }
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }
        public int DeptId { get; set; }
        public string DepartName { get; set; }

        public string CreateBy { get; set; }
        public string AffirmUserName { get; set; }

        /// <summary>
        /// 换模预计完成时间
        /// </summary>
        public DateTime ChangeoverPlanTime { get; set; }

        /// <summary>
        /// 换模实际开始时间
        /// </summary>
        public DateTime ActualStartTime { get; set; }

       /// <summary>
       /// 换模实际完成时间
       /// </summary>
        public DateTime ActualFinish { get; set; }

        /// <summary>
        /// 需求使用时间
        /// </summary>
        public DateTime NeedTime { get; set; }

        public int Status { get; set; }
        public string ApplyRemark { get; set; }
        public string ChangeOverRemark { get; set; }
        public string ChangeConfirmRemark { get; set; }

        public DateTime CreateTime { get; set; }

       /// <summary>
       /// 换模人
       /// </summary>
        public string Operator { get; set; }

        public string DocXml { get; set; }
        public int Isqualified { get; set; }

        public int MouldBomId { get; set; }
        public string BomName { get; set; }

        /// <summary>
        /// 初始压制数
        /// </summary>
        public int InitialPress { get; set; }
        /// <summary>
        /// 当前压制数
        /// </summary>
        public int CurrentPress { get; set; }
        /// <summary>
        /// 是否整机卸模
        /// </summary>
        public bool IsMouldUnload { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }

    }

    public class MoludApplyDetailInfo
    {
        public int Cd_Id { get; set; }
        public int Cid { get; set; }
        public int CurrentMouldId { get; set; }
        public int CurrentMouldType { get; set; }
        public string CurrentMouldCode { get; set; }
        public string CurrentMouldName { get; set; }
        public int ReplaceMouldId { get; set; }
        public int ReplaceMouldType { get; set; }
        public string ReplaceMouldCode { get; set; }
        public string ReplaceMouldName { get; set; }
    }

    public class EquimentMouldInfo
    {
        public int EmId { get; set; }
        public int EquimentId { get; set; }
        public int MouldId { get; set; }

        public int MouldType { get; set; }

        public string EquipmentTypeCode { get; set; }
        public string EquipmentTypeName { get; set; }
        public string EquipmentCode { get; set; }
        public string EquipmentName { get; set; }
        public string MouldCode { get; set; }
        public string MouldName { get; set; }

        public string CreateBy { get; set; }
        public DateTime CreateTime { get; set; }
    }


    public class MoldFixtureUpLine
    {
        /// <summary>
        /// 机台
        /// </summary>
        public string EquipmentCode { get; set; }

        /// <summary>
        /// ID
        /// </summary>
        public int MoldFixtureUpLineId { get; set; }

        /// <summary>
        /// 上线时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 模具名称
        /// </summary>
        public string MoudleCode { get; set; }

        public string MoudleName { get; set; }

        public string EquipmentName { get; set; }

        public string CreateBy { get; set; }
    }

    public class EquimentMouldBomChild
    {
        public int MouldType { get; set; }
        public int IsAdd { get; set; }
        public string MouldTypeName { get; set; }
        public string ComponentCode { get; set; }
        public string Describe { get; set; }
        public string ReplaceComponentName { get; set; }
    }
}