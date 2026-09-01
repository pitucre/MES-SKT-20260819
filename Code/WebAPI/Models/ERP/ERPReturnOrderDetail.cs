using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPReturnOrderDetail : BaseERPReturn
    {
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
        //warehousecode string entry   仓库编码
        //warehousename   string entry   仓库名称
        //inventorycode   string entry   存货编码
        //inventoryaddcode    string entry   存货代码
        //inventoryname   string entry   存货名称
        //inventorystd    string entry   规格型号
        //inventoryclasscode  string entry   存货分类编码
        //unitid  string entry   单位编码
        //ccomunitcode    string entry   单位编码
        //cinvm_unit  string entry   主计量
        //cinva_unit  string entry   采购单位
        //iinvexchrate    number entry   换算率
        //serial  string entry   批号
        //closer  string entry   关闭人
        //originaltaxedprice  number entry   含税单价
        //quantity    number entry   主计量数量
        //number  number entry   件数
        //originalprice   number entry   原币单价
        //originalmoney   number entry   原币金额
        //originaltax number entry   原币税额
        //originalsum number entry   原币价税合计
        //price   number entry   本币单价
        //money   number entry   本币金额
        //tax number entry   本币税额
        //sum number entry   本币价税合计
        //cbcloser    string entry   行关闭人
        //free1   string entry   自由项1
        //free2   string entry   自由项2
        //define22    string entry   表体自定义项1
        //define23    string entry   表体自定义项2
        //define24    string entry   表体自定义项3
        //define25    string entry   表体自定义项4
        //define26    number entry   表体自定义项5
        //define27    number entry   表体自定义项6
        //define28    string entry   表体自定义项7
        //define29    string entry   表体自定义项8
        //define30    string entry   表体自定义项9
        //define31    string entry   表体自定义项10
        //define32    string entry   表体自定义项11
        //define33    string entry   表体自定义项12
        //define34    number entry   表体自定义项13
        //define35    number entry   表体自定义项14
        //define36    date entry   表体自定义项15
        //define37    date entry   表体自定义项16
        //taxrate number entry   税率
        //iposid  number entry   订单子表ID
        //free3   string entry   自由项3
        //free4   string entry   自由项4
        //free5   string entry   自由项5
        //free6   string entry   自由项6
        //free7   string entry   自由项7
        //free8   string entry   自由项8
        //free9   string entry   自由项9
        //free10  string entry   自由项10
        //taxrate int entry   税率
        //iposid  string entry   订单子表ID
        //cordercode  string entry   订单号
        //vouchstate  number entry   单据状态
        //ivouchrowno number entry   行号
        //cbmemo  string entry   表体备注
        //cbsysbarcode    string entry   行条码


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
        public string iverifystateex { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string purchasetypecode { get; set; }
        /// <summary>
        /// 普通采购
        /// </summary>
        public string purchasetypename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string vendorcode { get; set; }
        /// <summary>
        /// 深圳市弛鸿创新电子有限公司
        /// </summary>
        public string vendorabbname { get; set; }
        /// <summary>
        /// 深圳市弛鸿创新电子有限公司
        /// </summary>
        public string vendorname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string departmentcode { get; set; }
        /// <summary>
        /// 采购部
        /// </summary>
        public string departmentname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string personcode { get; set; }
        /// <summary>
        /// 吴鹏
        /// </summary>
        public string personname { get; set; }
        /// <summary>
        /// 人民币
        /// </summary>
        public string foreigncurrency { get; set; }
        /// <summary>
        /// 普通采购
        /// </summary>
        public string businesstype { get; set; }
        /// <summary>
        /// 吴鹏
        /// </summary>
        public string maker { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string idiscounttaxtype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cauditdate { get; set; }
        /// <summary>
        /// 吴鹏
        /// </summary>
        public string cverifier { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string csysbarcode { get; set; }


        /// <summary>
        /// 
        /// </summary>
        public ERPReturnOrderDetail purchasereturn { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public List<EntryItem> entry { get; set; }

    }

    public class EntryItem
    {
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
        public string inventorycode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string inventoryname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string inventorystd { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string inventoryclasscode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ccomunitcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvm_unit { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal quantity { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string originalprice { get; set; }
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
        public string price { get; set; }
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
        public string cbcloser { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string taxrate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string vouchstate { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string iposid { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string cordercode { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string ivouchrowno { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cbsysbarcode { get; set; }
    }

}