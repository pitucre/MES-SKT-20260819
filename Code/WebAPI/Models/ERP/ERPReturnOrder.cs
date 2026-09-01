using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPReturnOrder : BaseERPReturn
    {
        //code string 单据号
        //purchasetypecode string 采购类型编码
        //purchasetypename string 采购类型
        //vendorcode string 供货单位编号
        //vendorabbname string 供应商
        //vendorname string 供应商全称
        //departmentcode string 部门编号
        //departmentname string 部门
        //personcode string 业务员编码
        //personname string 业务员
        //payconditioncode string 付款条件编码
        //payconditionname string 付款条件
        //foreigncurrency string 币种
        //cexch_code string 币种编码
        //foreigncurrencyrate number      汇率
        //memory  string 备注
        //businesstype string 业务类型
        //maker string 制单人
        //ccloser string 关闭人
        //idiscounttaxtype number      扣税类别
        //define1 string 表头自定义项1
        //define2 string 表头自定义项2
        //define3 string 表头自定义项3
        //define4 date        表头自定义项4
        //define5 number 表头自定义项5
        //define6 date        表头自定义项6
        //define7 number 表头自定义项7
        //define8 string 表头自定义项8
        //define9 string 表头自定义项9
        //define10 string 表头自定义项10
        //define11 string 表头自定义项11
        //define12 string 表头自定义项12
        //define13 string 表头自定义项13
        //define14 string 表头自定义项14
        //define15 number      表头自定义项15
        //define16    number 表头自定义项16
        //shipcode string 运输方式编码
        //shipname string 运输方式
        //ibilltype int (0到货单,1退货单,2拒收单)
        //cvouchtype string 单据类型
        //cmodifydate date        修改日期
        //creviser    string 修改人
        //cauditdate date        审核日期
        //cverifier   string 审核人
        //cvenpuomprotocol string 收付款协议编码
        //cvenpuomprotocolname string 收付款协议名称
        //csysbarcode string 单据条码
        //originalmoney string 原币金额
        //originaltax string 原币税额
        //originalsum string 原币价税合计
        //money string 本币金额
        //tax string 本币税额
        //SUM string 本币价税合计


        /// <summary>
        /// 
        /// </summary>
        public string date { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string state { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string purchasetypecode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string purchasetypename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string vendorcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string vendorname { get; set; }
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
        public string foreigncurrency { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string foreigncurrencyrate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string businesstype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string maker { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string idiscounttaxtype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string csysbarcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string originalmoney { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string originaltax { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string originalsum { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string money { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string tax { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sum { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public List<ERPReturnOrder> purchasereturnlist { get; set; }

    }
}
