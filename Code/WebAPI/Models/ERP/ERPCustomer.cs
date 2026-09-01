using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{

    public class ERPCustomer : BaseERPReturn
    {
        //code string 客户编码
        //name string 客户名称
        //abbrname string 客户简称
        //sort_code string 所属分类码
        //domain_code string 所属地区码
        //industry string 所属行业
        //address string 地址
        //bank_open string 开户银行
        //bank_acc_number string 银行账号
        //contact string 联系人
        //phone string 电话
        //fax string 传真
        //mobile string 手机
        //devliver_site string 发货地址
        //ModifyDate date        变更日期
        //seed_date   date 发展日期
        //end_date date        停用日期
        //memo    string 备注
        //ccusexch_name string 币种
        //bcusdomestic string 国内
        //bcusoverseas string 国外
        //bserviceattribute string 服务
        //ccusmngtypecode string 客户管理类型
        //ccusmngtypename string 客户管理类型名称
        //spec_operator_name string 专管业务员名称
        //timestamp number      时间戳
        //self_define1    string 自定义项1
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

        /// <summary>
        /// 
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string abbrname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sort_code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string address { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bank_open { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bank_acc_number { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string contact { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string phone { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string mobile { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string devliver_site { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string spec_operator { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string spec_operator_name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ccusexch_name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bcusdomestic { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bcusoverseas { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bserviceattribute { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ccusmngtypecode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ccusmngtypename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string super_dept { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string timestamp { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ModifyDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string seed_date { get; set; }

        public List<ERPCustomer> customer { get; set; }
    }

}