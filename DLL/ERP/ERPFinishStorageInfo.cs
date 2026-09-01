using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.ERP
{
    public class ERPFinishStorageInfo
    {
        /// <summary>
        /// 
        /// </summary>
        public string Token { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public Login login { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public ERPFinishStorageHeadInfo head { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public List<ERPFinishStorageBodyInfo> body { get; set; }
    }

    public class ERPFinishStorageHeadInfo
    {
        /*
        crdcode	是	string	收发类别编码
        dnmaketime	否	datetime	制单时间（不传默认当前时间）
        ddate	是	datetime	入库日期（不传默认当前日期）
        cwhcode	是	string	仓库编码
        cmpocode	否	string	生产订单号（订单来源为’生产订单’时必传）
        iproorderid	否	string	生产订单ID（订单来源为’生产订单’时必传）
        csource	否	string	订单来源
        cdepcode	是	decimal	部门编码
        cmemo	否	string	备注
        cmaker	是	string	制单人
        cmodifier	否	string	审核人（不传则为默认的审核人）
        bcalculationmode	否	string	计算模式（0. 不计算【不计算需传0】 1. 以总金额为主【不传，则默认已总金额为主】 2. 以含税单价为主）
        bauditmode	是	string	是否审核（0.代表不审【不传默认不审核】 1.代表审核 ） 
        */
        /// <summary>
        /// 收发类别编码
        /// </summary>
        public string crdcode { get; set; }

        /// <summary>
        /// 制单时间（不传默认当前时间）
        /// </summary>
        public string dnmaketime { get; set; }

        /// <summary>
        /// 入库日期（不传默认当前日期）
        /// </summary>
        public string ddate { get; set; }

        /// <summary>
        /// 仓库编码
        /// </summary>
        public string cwhcode { get; set; }

        /// <summary>
        /// 生产订单号（订单来源为’生产订单’时必传）
        /// </summary>
        public string cmpocode { get; set; }

        /// <summary>
        /// 生产订单ID（订单来源为’生产订单’时必传）
        /// </summary>
        public string iproorderid { get; set; }

        /// <summary>
        /// 订单来源
        /// </summary>
        public string csource { get; set; }

        /// <summary>
        /// 部门编码
        /// </summary>
        public string cdepcode { get; set; }

        /// <summary>
        /// 备注
        /// </summary>
        public string cmemo { get; set; }

        /// <summary>
        /// 制单人
        /// </summary>
        public string cmaker { get; set; }

        /// <summary>
        /// 审核人（不传则为默认的审核人）
        /// </summary>
        public string cmodifier { get; set; }

        /// <summary>
        /// 计算模式（0. 不计算【不计算需传0】 1. 以总金额为主【不传，则默认已总金额为主】 2. 以含税单价为主）
        /// </summary>
        public string bcalculationmode { get; set; }

        /// <summary>
        /// 审核（0.代表不审【不传默认不审核】 1.代表审核 ）
        /// </summary>
        public string bauditmode { get; set; }

    }

    public class ERPFinishStorageBodyInfo
    {
        /// <summary>
        /// 行号
        /// </summary>
        public string ivouchrowno { get; set; }

        /// <summary>
        /// 生产订单ID
        /// </summary>
        public string impoids { get; set; }

        /// <summary>
        /// 生产订单号
        /// </summary>
        public string cmocode { get; set; }

        /// <summary>
        /// 生产订单序号
        /// </summary>
        public string imoseq { get; set; }

        /// <summary>
        /// 存货编码
        /// </summary>
        public string cinvcode { get; set; }

        /// <summary>
        /// 存货名称
        /// </summary>
        public string cinvname { get; set; }

        /// <summary>
        /// 下单数量
        /// </summary>
        public string iquantity { get; set; }

        /// <summary>
        /// 单价
        /// </summary>
        public string iUnitCost { get; set; }

        /// <summary>
        /// 金额
        /// </summary>
        public string iPrice { get; set; }

        /// <summary>
        /// 标识【默认A：新增】
        /// </summary>
        public string editprop { get; set; }

    }

}
