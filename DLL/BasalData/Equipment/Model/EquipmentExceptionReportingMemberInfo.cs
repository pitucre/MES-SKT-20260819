using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentExceptionReportingMemberInfo
    {
        /// <summary>
        /// 异常上报方案明细ID
        /// </summary>
        public int ExceptionReportingMemberId { get; set; }

        /// <summary>
        /// 异常上报方案ID
        /// </summary>
        public int ExceptionReportingId { get; set; }

        /// <summary>
        /// 异常上报等级
        /// </summary>
        public string ExceptionReportingGrade { get; set; }

        /// <summary>
        /// 超时时长
        /// </summary>
        public decimal? TimeOutLength { get; set; }

        /// <summary>
        /// 单位
        /// </summary>
        public string TimeOutUnit { get; set; }

        /// <summary>
        /// 上报人员-用户名
        /// </summary>
        public string ReportingUser { get; set; }

        /// <summary>
        /// 上报人员-中文名
        /// </summary>
        public string ReportingUserName { get; set; }

        /// <summary>
        /// 上报人员-邮箱
        /// </summary>
        public string ReportingUserEmail { get; set; }

        /// <summary>
        /// 模板创建者
        /// </summary>
        public string Creater { get; set; }

        /// <summary>
        /// 模板创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }
    }
}