using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPUser : BaseERPReturn
    {
        //code string 人员编码
        //cuser_id string 操作员编码
        //cuser_name string 操作员名称
        //name string 人员名称
        //cdept_num string 部门编码
        //cdept_name string 部门名称
        //cpsnproperty string 人员属性
        //rsex number      人员性别（1:男 2:女）
        //cpsnmobilephone string 人员手机号
        //cpsnemail string 人员邮箱
        //cjobcode string 职位编码
        //vjobname string 职位名称
        //cpsnpostaddr string 通讯地址
        //rpersontype number      人员类型
        //rpersontypename string 人员类型名称
        //rIDType number      证件类型（0：身份证 1：护照 2：军人证 3：港澳身份证 4：台胞证 9：其他）
        //rEmployState number      雇佣状态（10：在职 20：离退 30：离职）
        //cpsnqqcode number      QQ号
        //vIDNo   string 证件号码
        //bpsnperson string		0=非业务员；1=业务员
        //timestamp   number 时间戳
        //bankaccount string openbank    开户银行账号
        //bankname    string openbank    开户银行名称
        //defaultaccount  string openbank    是否为默认账户（0：否 1：为是）
        //caname string openbank    账户名称
        //cbankname   string openbank    所属银行名称


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
        public string cdept_num { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cdept_name { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rsex { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rpersontype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rpersontypename { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rIDType { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string vIDNo { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string rEmployState { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cpsnmobilephone { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cjobcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bpsnperson { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string JobNumber { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string dEnterUnitDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string dBirthDate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string timestamp { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public List<ERPUser> person { get; set; }
    }
}