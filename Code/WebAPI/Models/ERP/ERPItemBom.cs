using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI.Models.ERP
{
    public class ERPItemBom : BaseERPReturn
    {
        //bomid number      主键ID
        //bomtype number BOM类型(主要/替代)
        //version number      版本号
        //versiondesc string 版本说明
        //versioneffdate date        版本生效日
        //versionenddate  date 版本失效日
        //identcode string 替代标识
        //identdesc string 替代说明
        //parentid number      母件物料Id
        //cinvcode    string 存货编码
        //cinvname string 存货名称
        //cinvstd string 规格型号
        //cinvccode string 存货大类编码
        //cinvcname string 存货名称
        //free1 string 自由项1
        //free2 string 自由项2
        //free3 string 自由项3
        //free4 string 自由项4
        //free5 string 自由项5
        //free6 string 自由项6
        //free7 string 自由项7
        //free8 string 自由项8
        //free9 string 自由项9
        //free10 string 自由项10
        //parentscrap number      母件损耗率
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
        //status number      状态(1:新建/3:审核/4:停用)
        //createuser string 创建人
        //createdate date        创建日期
        //closeuser   string 关闭人
        //closedate date        关闭日期
        //opcomponentid   number entry   子件ID
        //bomid   number entry   主键ID
        //sortseq number entry   序号
        //opseq   string entry   工序代号
        //componentid number entry   子件物料Id
        //effbegdate  date entry   子件生效日
        //effenddate  date entry   子件失效日
        //fvflag  number entry   固定/变动批量(0/1)
        //baseqtyn number  entry 基本用量-分子
        //baseqtyd    number entry   基本用量-分母
        //compscrap   number entry   子件损耗率
        //byproductflag   boolean entry   是否联副产品
        //auxunitcode string entry   辅助计量单位
        //changerate  number entry   换算率
        //auxbaseqtyn number entry   辅助基本用量
        //producttype number entry   产出类型(1:空/2:联产品/3:副产品)
        //define22 string entry   表体自定义项1
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
        //remark  string entry   备注
        //recursiveflag   boolean entry   是否循环
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
        //cinvcode    string entry   存货编码
        //cinvname    string entry   存货名称
        //cinvstd string entry   规格型号
        //cinvccode   string entry   存货大类编码
        //cinvcname   string entry   存货名称
        //offset  number entry   偏置期
        //wiptype number entry   WIP属性(1入库/2工序/3领料/4虚拟)
        //accucostflag boolean entry 是/否累计成本（1/0）
        //drawdeptcode string entry   领料部门
        //cdepname    string entry   部门
        //whcode  string entry   仓库代号
        //cwhname string entry   仓库
        //optionalflag    boolean entry   是否可选(1/0)
        //mutexrule number  entry 互斥原则(1-ONE/2-ALL/3-ANY/4-AL0)
        //planfactor number  entry 计划比例
        //costwiprel boolean entry 成本投产推算
        //dsubflag number  entry 替代标识
        
        /// <summary>
        /// 
        /// </summary>
        public int bomid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string bomtype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string version { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string versiondesc { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime versioneffdate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public DateTime versionenddate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string parentid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvcode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvstd { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvccode { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvcname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free1 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free2 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free3 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free4 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free5 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free6 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free7 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free8 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free9 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free10 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string parentscrap { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int status { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string createuser { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string createdate { get; set; }

        /// <summary>
        /// BOM信息
        /// </summary>
        public List<ERPItemBom> bom { get; set; }

        /// <summary>
        /// BOM明细
        /// </summary>
        public List<ERPItemBomChild> entry { get; set; }
    }

    public class ERPItemBomChild
    {
        ///// <summary>
        ///// 
        ///// </summary>
        //public List<entry> entry { get; set; }

        /// <summary>
        /// 
        /// </summary>
        public string opcomponentid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public int bomid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string sortseq { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string opseq { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string componentid { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string effbegdate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string effenddate { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string fvflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal baseqtyn { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public decimal baseqtyd { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string compscrap { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string byproductflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string producttype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string recursiveflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free1 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free2 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free3 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free4 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free5 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free6 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free7 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free8 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free9 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string free10 { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvcode { get; set; }
        /// <summary>
        /// 测试程序
        /// </summary>
        public string cinvname { get; set; }
        /// <summary>
        /// 0122095661_测试使用_SSPM_FactoryTest_Nomal_191025.hex;0x00164A50
        /// </summary>
        public string cinvstd { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string cinvccode { get; set; }
        /// <summary>
        /// 退税软件
        /// </summary>
        public string cinvcname { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string offset { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string wiptype { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string accucostflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string optionalflag { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string mutexrule { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string planfactor { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string costwiprel { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string dsubflag { get; set; }

    }

}