using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 产品类别表
    /// </summary>
    public class ERPBasalItemCategoryInfo
    {
        /// <summary>
        /// 产品/物料管理分类表 ID
        /// </summary>
        //public int ItemCategoryId { get; set; }

        /// <summary>
        /// 上级ID, -1表示当前为最顶级（大类）
        /// </summary>
        public string ParentId { get; set; }

        /// <summary>
        /// CategoryCode
        /// </summary>
        public string CategoryCode { get; set; }

        /// <summary>
        /// 分类名称
        /// </summary>
        public string CategoryName { get; set; }

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
        /// ERP操作类型（0：新增 1：修改 2：删除）
        /// </summary>
        public int ERPOperateType { get; set; }
    }
}