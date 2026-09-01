using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.Enum
{
    /// <summary>
    /// ERP操作类型
    /// </summary>
    public enum OperateType
    {
        /// <summary>
        /// 新增
        /// </summary>
        Add,
        /// <summary>
        /// 修改
        /// </summary>
        Update,
        /// <summary>
        /// 删除
        /// </summary>
        Delete,
    }
}