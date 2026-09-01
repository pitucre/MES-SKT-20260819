using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.MES
{
    /// <summary>
    /// 形态转换单信息
    /// </summary>
    [Serializable]
    public partial class ERPProdFormChangeInfo
    {

        #region Model


        /// <summary>
        /// 形态转换单号
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false, IsBillNo = true)]
        public string FormChangeNo { get; set; }

        /// <summary>
        /// 单据类型
        /// </summary>
        public string DocumentType { get; set; }

        /// <summary>
        /// 组织
        /// </summary>
        public string Organization { get; set; }

        /// <summary>
        /// 项目
        /// </summary>
        public string Project { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string WarehouseCode { get; set; }

        /// <summary>
        /// 仓库名称
        /// </summary>
        public string WarehouseName { get; set; }

        /// <summary>
        /// 日期
        /// </summary>
        public DateTime? FormChangeDate { get; set; }

        /// <summary>
        /// 状态：0待转换，1已转换
        /// </summary>
        public int? Status { get; set; }

        /// <summary>
        /// 工厂代码
        /// </summary>
        [MappingPropertyAttribute(AllowEmpty = false)]
        public string FactoryCode { get; set; }

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
        public int? ERPOperateType { get; set; }


        /// <summary>
        /// 形态转换单明细
        /// </summary>
        [MappingPropertyAttribute(FieldIgnore = true)]
        public List<ERPProdFormChangeDtlInfo> Details { get; set; }



        #endregion Model

    }
}
