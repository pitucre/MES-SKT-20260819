using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Equipment.Model
{
    /// <summary>
    /// 设备维修人员信息表
    /// </summary>
    [Serializable]
    public class EquipmentRepairUserInfo
    {
        /// <summary>
        /// 设备维修人员信息表Id
        /// </summary>
        public int EquipmentRepairUserId { get; set; }

        /// <summary>
        /// 用户Id
        /// </summary>
        public int? UserId { get; set; }

        /// <summary>
        /// 异常类型Id（关联Basal_Anormal_Type表AnormalTypeId）
        /// </summary>
        public int? AnormalTypeId { get; set; }

        /// <summary>
        /// 班次(0:无,1:甲班,2:乙班)
        /// </summary>
        public int? WorkShift { get; set; }

        /// <summary>
        /// Email
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        /// 部门Id
        /// </summary>
        public int? DepartId { get; set; }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDateTime { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyDateTime { get; set; }

        /// <summary>
        /// 电话
        /// </summary>
        public string Phone { get; set; }


        /// <summary>
        /// 班别描述
        /// </summary>
        public string WorkShiftName { get; set; }

        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }

        /// <summary>
        /// 用户中文名
        /// </summary>
        public string CName { get; set; }

        /// <summary>
        /// 工号
        /// </summary>
        public string EmployeeNo { get; set; }

        /// <summary>
        /// 部门编码
        /// </summary>
        public string DepartNo { get; set; }

        /// <summary>
        /// 部门名称
        /// </summary>
        public string DepartName { get; set; }

        ///// <summary>
        ///// 异常类型代码
        ///// </summary>
        //public string AnormalTypeCode { get; set; }

        ///// <summary>
        ///// 异常类型名称
        ///// </summary>
        //public string AnormalTypeName { get; set; }

        ///// <summary>
        ///// 异常类型Id
        ///// </summary>
        //public string AnormalTypeIds { get; set; }

        ///// <summary>
        ///// 维修人员对应异常类型信息
        ///// </summary>
        //public List<EquipmentRepairUserAnormalTypeInfo> EquipmentRepairUserAnormalTypeList { get; set; }


        /// <summary>
        /// Id
        /// </summary>
        public long Id { get; set; }

        /// <summary>
        /// 工序Id
        /// </summary>
        public int StationId { get; set; }

        /// <summary>
        /// 工序
        /// </summary>
        public string Station { get; set; }

        /// <summary>
        /// 工序Id
        /// </summary>
        public string StationIds { get; set; }

        /// <summary>
        /// 维修人员对应工序信息
        /// </summary>
        public List<EquipmentRepairUserStationInfo> EquipmentRepairUserStationList { get; set; }
    }
}
