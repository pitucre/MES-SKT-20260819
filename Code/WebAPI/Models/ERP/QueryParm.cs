using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    /// <summary>
    /// 查询仓库信息参数
    /// </summary>
    public class QueryWarehouseParm : BasalERPParm
    {
        /// <summary>
        /// 仓库编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string cwhcode { get { return base.BillNo; } }
    }

    /// <summary>
    /// 查询客户信息参数
    /// </summary>
    public class QueryCustomerParm : BasalERPParm
    {
        /// <summary>
        /// 客户编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_begin { get { return base.BillNo; } }

        /// <summary>
        /// 客户编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_end { get { return base.BillNo; } }
    }


    /// <summary>
    /// 查询供应商信息参数
    /// </summary>
    public class QuerySupplierParm : BasalERPParm
    {
        /// <summary>
        /// 供应商编码
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_begin { get { return base.BillNo; } }

        /// <summary>
        /// 供应商编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_end { get { return base.BillNo; } }

    }



    /// <summary>
    /// 查询部门信息参数
    /// </summary>
    public class QueryDepartmentParm : BasalERPParm
    {
        /// <summary>
        /// 部门编码
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_begin { get { return base.BillNo; } }

        /// <summary>
        /// 部门编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_end { get { return base.BillNo; } }

    }


    /// <summary>
    /// 查询用户信息参数
    /// </summary>
    public class QueryUserParm : BasalERPParm
    {
        /// <summary>
        /// 用户名
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_begin { get { return base.BillNo; } }

        /// <summary>
        /// 用户名
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_end { get { return base.BillNo; } }

    }

    /// <summary>
    /// 查询物料信息参数
    /// </summary>
    public class QueryItemParm : BasalERPParm
    {
        /// <summary>
        /// 物料编码
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_begin { get { return base.BillNo; } }

        /// <summary>
        /// 物料编码
        /// </summary>
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string code_end { get { return base.BillNo; } }
    }


    /// <summary>
    /// 查询物料BOM信息参数
    /// </summary>
    public class QueryItemBomParm : BasalERPParm
    {
        /// <summary>
        /// 产品编码
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public string cinvcode { get { return base.BillNo; } }


        /// <summary>
        /// 状态(1:新建/3:审核/4:停用)
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public int? status { get; set; } = 3;

        /// <summary>
        /// BOM类型(主要/替代)
        /// </summary>
        /// <summary>  
        [ParmsPropertyAttribute(NullIgnore = true)]
        public int? bomtype { get; set; } = 1;
        
    }



    /// <summary>
    /// 查询退料单信息参数
    /// </summary>
    public class QueryReturnOrderParm : BasalERPParm
    {
        
    }


    /// <summary>
    /// 查询退料单及明细信息参数
    /// </summary>
    public class QueryReturnOrderDetailParm : BasalERPParm
    {
        /// <summary>
        /// 退货单号
        /// </summary>
        public string id { get { return base.BillNo; } } 
    }



    /// <summary>
    /// 查询销售出库单信息参数
    /// </summary>
    public class QuerySaleOrderParm : BasalERPParm
    {

    }


}