using System;

namespace SKT.LeanMES.Equipment.Model
{
    [Serializable]
    public class EquipmentExceptionReportingInfo
    {
        /// <summary>
        /// 异常上报方案ID
        /// </summary>
        public int ExceptionReportingId { get; set; }

        /// <summary>
        /// 异常上报方案编码
        /// </summary>
        public string ExceptionReportingCode { get; set; }

        /// <summary>
        /// 异常上报方案名称
        /// </summary>
        public string ExceptionReportingName { get; set; }
        /// <summary>
        /// 异常类型
        /// </summary>
        public string ExceptionType { get; set; }

        /// <summary>
        /// 模板创建者
        /// </summary>
        public string Creater { get; set; }

        /// <summary>
        /// 模板创建时间
        /// </summary>
        public DateTime CreateTime { get; set; }

        /// <summary>
        /// 模板说明
        /// </summary>
        public string Description { get; set; }

        /// <summary>
        /// 此模板已应用的预警方案ID清单
        /// </summary>
        public string ExceptionReportingItemIdList { get; set; }

        /// <summary>
        /// 检验模板的状态，默认为启用 1, 禁用为0
        /// </summary>
        public bool Status { get; set; }

        /// <summary>
        /// 异常上报方案版本号
        /// </summary>
        public string Version { get; set; }

        /// <summary>
        /// ModifyBy
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// ModifyTime
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}