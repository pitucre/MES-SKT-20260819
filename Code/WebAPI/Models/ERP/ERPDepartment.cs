using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPDepartment : BaseERPReturn
    {

        //code string 部门编码
        //name string 部门名称
        //endflag boolean     是否末级
        //rank    number 编码级次
        //manager string 负责人
        //managername string 负责人名称
        //cdepleader string 分管领导编码
        //cdepleadername string 分管领导名称
        //timestamp number      时间戳
        //remark  string 备注
        //ddependdate date        撤销日期

        /// <summary>
        /// </summary>
        public string code { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string endflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rank { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string ddepbegindate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string timestamp { get; set; }

        public List<ERPDepartment> department { get; set; }
    }
}