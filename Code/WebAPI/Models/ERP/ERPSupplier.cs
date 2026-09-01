using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPSupplier : BaseERPReturn
    {
        //errcode string 错误码，0 为正常。
        //errmsg string 错误信息。
        //page_index string 页号
        //rows_per_page string 每页行数
        //row_count string 总行数
        //page_count string 页数
        //code string 供应商编码
        //name string 供应商名称
        //abbrname string 供应商简称
        //sort_code string 所属分类码
        //industry string 所属行业
        //address string 地址
        //bank_open string 开户银行
        //bank_acc_number string 银行帐号
        //phone string 电话
        //fax string 传真
        //email string Email地址
        //contact string 联系人
        //mobile string 手机
        //receive_site string 到货地址
        //end_date date        停用日期
        //memo    string 备注
        //timestamp number      时间戳

        ///// <summary>
        ///// 
        ///// </summary>
        //public string row_count { get; set; }
        ///// <summary>
        ///// 
        ///// </summary>
        //public string RowNum { get; set; }
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
        public string phone { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string fax { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string contact { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string modify_date { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string timestamp { get; set; }


        public List<ERPSupplier> vendor { get; set; }

    }
}