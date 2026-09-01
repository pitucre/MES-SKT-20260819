using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 自定义属性特性
    /// </summary>
    [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false)]
    public sealed class MappingPropertyAttribute : Attribute
    {
        /// <summary>
        /// 实体类映射到表时，是否对应忽略字段
        /// </summary>
        public bool FieldIgnore { get; set; } = false;

        /// <summary>
        /// 是否必填字段
        /// </summary>
        public bool AllowEmpty { get; set; } = true;

        /// <summary>
        /// 是否为单号（如果为实时同步，则需要根据单号进行同步）
        /// </summary>
        public bool IsBillNo { get; set; }
    }
}