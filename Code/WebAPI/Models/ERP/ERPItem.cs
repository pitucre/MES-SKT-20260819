using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPItem : BaseERPReturn
    {
        //code string 存货编码
        //name string 存货名称
        //invaddcode string 存货代码
        //specs string 规格型号
        //sort_code string 所属分类码
        //main_measure string 主计量单位
        //puunit_code string 采购默认单位编码
        //puunit_name string 采购默认单位名称
        //puunit_ichangrate number      采购默认单位换算率
        //saunit_code string 销售默认单位编码
        //saunit_name string 销售默认单位名称
        //saunit_ichangrate number      销售默认单位换算率
        //stunit_code string 库存默认单位编码
        //stunit_name string 库存默认单位名称
        //stunit_ichangrate number      库存默认单位换算率
        //unitgroup_code  string 计量单位组编码
        //unitgroup_type number      计量单位组类型(0=无换算;1=固定;2=浮动)
        //bbarcode boolean     条形码管理
        //barcode string 条形码
        //ref_sale_price number      参考售价
        //bsuitretail boolean 适用零售(0:否 1：是)
        //bottom_sale_price number      最低售价
        //start_date  date 启用日期
        //end_date date        停用日期
        //ModifyDate  date 变更日期
        //defwarehouse string 默认仓库
        //defwarehousename string 默认仓库名称
        //iSupplyType string 供应类型
        //drawtype string 领料方式
        //iimptaxrate number      进项税率
        //tax_rate    number 销项税率
        //self_define1 string 自定义项1
        //self_define2 string 自定义项2
        //self_define3 string 自定义项3
        //self_define4 string 自定义项4
        //self_define5 string 自定义项5
        //self_define6 string 自定义项6
        //self_define7 string 自定义项7
        //self_define8 string 自定义项8
        //self_define9 string 自定义项9
        //self_define10 string 自定义项10
        //self_define11 string 自定义项11
        //self_define12 string 自定义项12
        //self_define13 string 自定义项13
        //self_define14 string 自定义项14
        //self_define15 string 自定义项15
        //self_define16 string 自定义项16
        //invcode string entry   存货编码
        //free1   string entry   自由项1
        //free2   string entry   自由项2
        //free3   string entry   自由项3
        //free4   string entry   自由项4
        //free5   string entry   自由项5
        //free6   string entry   自由项6
        //free7   string entry   自由项7
        //free8   string entry   自由项8
        //free9   string entry   自由项9
        //free10  string entry   自由项10

        /// <summary>
        /// 
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 单面PCB
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string invaddcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string specs { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sort_code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sort_name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string main_measure { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ccomunitname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string unitgroup_type { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string unitgroup_code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string start_date { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string defwarehouse { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string defwarehousename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string iSupplyType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define1 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define2 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define3 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define5 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define8 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string self_define9 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string iimptaxrate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string tax_rate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ModifyDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bbarcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sale_flag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bexpsale { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string timestamp { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<ERPItem> inventory { get; set; }
    }
}