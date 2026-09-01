using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPSaleOrder : BaseERPReturn
    {
        //warehousecode string 仓库编码
        //warehousename string 仓库名称
        //date string 单据日期
        //code string 收发单据号
        //receivecode string 收发类别编码
        //receivename string 收发类别名称
        //departmentcode string 部门编码
        //departmentname string 部门名称
        //personcode string 业务员编码
        //personname string 业务员名称
        //saletypecode string 销售类型编码
        //saletypename string 销售类型名称
        //customercode string 客户编码
        //customername string 客户名称
        //quantity number      数量
        //arrivedate  string 到货日期
        //handler string 审核人
        //memory string 备注
        //maker string 制单人
        //define1 string 单据头自定义项1
        //define2 string 单据头自定义项2
        //define3 string 单据头自定义项3
        //define4 date        单据头自定义项4
        //define5 number 单据头自定义项5
        //define6 date        单据头自定义项6
        //define7 number 单据头自定义项7
        //define8 string 单据头自定义项8
        //define9 string 单据头自定义项9
        //define10 string 单据头自定义项10
        //define11 string 单据头自定义项11
        //define12 string 单据头自定义项12
        //define13 string 单据头自定义项13
        //define14 string 单据头自定义项14
        //define15 number      单据头自定义项15
        //define16    number 单据头自定义项16
        //auditdate string 审核日期
        //barcode string 条形码
        //inventorycode string 存货编码
        //free1 string 存货自由项1
        //free2 string 存货自由项2
        //free3 string 存货自由项3
        //free4 string 存货自由项4
        //free5 string 存货自由项5
        //free6 string 存货自由项6
        //free7 string 存货自由项7
        //free8 string 存货自由项8
        //free9 string 存货自由项9
        //free10 string 存货自由项10
        //shouldquantity number      应发数量
        //shouldnumber    number 应发件数
        //cmassunitname string 主计量单位
        //assitantunit string 库存单位码
        //assitantunitname string 库存单位
        //irate number      换算率
        //number  number 件数
        //price number      单价
        //cost    number 金额
        //define22 string 表体自定义项1
        //define23 string 表体自定义项2
        //define24 string 表体自定义项3
        //define25 string 表体自定义项4
        //define26 number      表体自定义项5
        //define27    number 表体自定义项6
        //define28 string 表体自定义项7
        //define29 string 表体自定义项8
        //define30 string 表体自定义项9
        //define31 string 表体自定义项10
        //define32 string 表体自定义项11
        //define33 string 表体自定义项12
        //define34 number      表体自定义项13
        //define35    number 表体自定义项14
        //define36 date        表体自定义项15
        //define37    date 表体自定义项16
        //subconsignmentid number      发货单子表id
        //rowno   number 行号
        //subconsignmentcode string 发货单号
        //suborderid number      订单子表id
        //subordercode    string 订单号
        //orderrowno number      订单行号

        /// <summary>
        /// 
        /// </summary>
        public string businesstype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string warehousecode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string warehousename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string date { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string receivecode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string receivename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string departmentcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string departmentname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string personcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string personname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string saletypecode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string saletypename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string customercode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string customername { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string maker { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string define11 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string inventorycode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string shouldquantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal quantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cmassunitname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string define26 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string define27 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string subconsignmentid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rowno { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string subconsignmentcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string suborderid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string subordercode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string orderrowno { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public List<ERPSaleOrder> saleoutlistall { get; set; }

    }
}