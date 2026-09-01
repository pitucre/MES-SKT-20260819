using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Scrap.Model
{
    /// <summary>
    /// 报废申请单主表实例类 add by zhi.li 2018-06-30
    /// </summary>
    /// </summary>
    [Serializable]
    public class ScrapInfo
    {

     
        private Int32 scrapId;
        private String scrapNo;
        private String sourceNo;
        private String depCode;
        private Int32 statue;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 auditing;
        private DateTime auditingDate;
        private String whouse;
        private String endUser;
        private DateTime endDate;


        //GridView List显示
        private String departName;
        private String whName;
        private String statueName;
        private String eName;
        private String auditingName;
        private String auditingStatue;
        private String endUserName;
        private String endDate1;


        /// <summary>
        /// 初始化 SKT.LeanMES.Scrap.Model.ScrapInfo 类的新实例。
        /// </summary>
        public ScrapInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Scrap.Model.ScrapInfo 类的新实例。
        /// </summary>
        /// <param name="scrapId">报废申请单ID</param>
        /// <param name="scrapNo">报废申请单号</param>
        /// <param name="sourceNo">来源单号</param>
        /// <param name="depCode">报废部门</param>
        /// <param name="statue">状态：0-待报废  1-报废中  2-报废完成</param>
        /// <param name="remark">报废原因</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">更新人</param>
        /// <param name="createDateTime">更新时间</param>
        /// <param name="auditing">审核人</param>
        /// <param name="auditingDate">审核时间</param>
        /// <param name="whouse">仓库</param>
        /// <param name="endUser">结束单据人</param>
        /// <param name="endDate">结束时间</param>
        public ScrapInfo(int scrapId, string scrapNo, string sourceNo, string depCode, int statue, string remark, string createBy, DateTime createDateTime, 
            string modifyBy, DateTime modifyDateTime, int auditing, DateTime auditingDate, string whouse, string endUser, DateTime endDate, 
            string eName,string departName,string whName
            )
        {
            this.scrapId = scrapId;
            this.scrapNo = scrapNo;
            this.sourceNo = sourceNo;
            this.depCode = depCode;
            this.statue = statue;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = modifyDateTime;
            this.auditing = auditing;
            this.auditingDate = auditingDate;
            this.whouse = whouse;

            this.endUser = endUser;
            this.endDate = endDate;
            this.eName = eName;
            this.departName = departName;
            this.whName = whName;
        }

        /// <summary>
        /// 报废申请单ID
        /// </summary>
        public int ScrapId
        {
            get
            {
                return scrapId;
            }

            set
            {
                scrapId = value;
            }
        }

        /// <summary>
        /// 报废申请单号
        /// </summary>
        public string ScrapNo
        {
            get
            {
                return scrapNo;
            }

            set
            {
                scrapNo = value;
            }
        }


        /// <summary>
        /// 部门编号
        /// </summary>
        public string DepCode
        {
            get
            {
                return depCode;
            }

            set
            {
                depCode = value;
            }
        }

        /// <summary>
        /// 状态：0-待报废  1-报废中  2-报废完成
        /// </summary>
        public int Statue
        {
            get
            {
                return statue;
            }

            set
            {
                statue = value;
            }
        }

        /// <summary>
        /// 报废原因
        /// </summary>
        public string Remark
        {
            get
            {
                return remark;
            }

            set
            {
                remark = value;
            }
        }

        /// <summary>
        /// 创建人
        /// </summary>
        public string CreateBy
        {
            get
            {
                return createBy;
            }

            set
            {
                createBy = value;
            }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get
            {
                return createDateTime;
            }

            set
            {
                createDateTime = value;
            }
        }

        /// <summary>
        /// 更新人
        /// </summary>
        public string ModifyBy
        {
            get
            {
                return modifyBy;
            }

            set
            {
                modifyBy = value;
            }
        }

        /// <summary>
        /// 更新时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get
            {
                return modifyDateTime;
            }

            set
            {
                modifyDateTime = value;
            }
        }

        /// <summary>
        /// 审核人
        /// </summary>
        public int Auditing
        {
            get
            {
                return auditing;
            }

            set
            {
                auditing = value;
            }
        }

        /// <summary>
        /// 审核时间
        /// </summary>
        public DateTime AuditingDate
        {
            get
            {
                return auditingDate;
            }

            set
            {
                auditingDate = value;
            }
        }

        /// <summary>
        /// 仓库
        /// </summary>
        public string Whouse
        {
            get
            {
                return whouse;
            }

            set
            {
                whouse = value;
            }
        }

        /// <summary>
        /// 结束单据人
        /// </summary>
        public string EndUser
        {
            get
            {
                return endUser;
            }

            set
            {
                endUser = value;
            }
        }

        /// <summary>
        /// 结束时间
        /// </summary>
        public DateTime EndDate
        {
            get
            {
                return endDate;
            }

            set
            {
                endDate = value;
            }
        }


        /// <summary>
        /// 报废明细列表
        /// </summary>
        public string ItemList { get; set; }


        /// <summary>
        /// 仓库
        /// </summary>
        public string WhName
        {
            get
            {
                return whName;
            }

            set
            {
                whName = value;
            }
        }



        /// <summary>
        /// 报废单状态
        /// </summary>
        public string StatueName
        {
            get
            {
                return statueName;
            }

            set
            {
                statueName = value;
            }
        }

        /// <summary>
        /// 制单人
        /// </summary>
        public string EName
        {
            get
            {
                return eName;
            }

            set
            {
                eName = value;
            }
        }


        /// <summary>
        /// 报废审核人
        /// </summary>
        public string AuditingName
        {
            get
            {
                return auditingName;
            }

            set
            {
                auditingName = value;
            }
        }


        /// <summary>
        /// 报废申请审核状态
        /// </summary>
        public string AuditingStatue
        {
            get
            {
                return auditingStatue;
            }

            set
            {
                auditingStatue = value;
            }
        }

        /// <summary>
        /// 结束报废操作人
        /// </summary>
        public string EndUserName
        {
            get
            {
                return endUserName;
            }

            set
            {
                endUserName = value;
            }
        }

        /// <summary>
        /// 报废部门
        /// </summary>
        public string DepartName
        {
            get
            {
                return departName;
            }

            set
            {
                departName = value;
            }
        }

        public string EndDate1
        {
            get
            {
                return endDate1;
            }

            set
            {
                endDate1 = value;
            }
        }

        /// <summary>
        /// 用于报废 PDA扫描GRN信息
        /// </summary>
        public string SerialNumber;
        public string ItemCode;
        public string CBarCode;
        public string BalanceQty;
        public string UserName;
        public string EmployeeCName;
        public string GrnList;
        public string WhList;

        ///// <summary>
        ///// 调入仓库
        ///// </summary>
        //public string InWhouseName
        //{
        //    get
        //    {
        //        return inWhouseName;
        //    }

        //    set
        //    {
        //        inWhouseName = value;
        //    }
        //}

        ///// <summary>
        /////调出仓库
        ///// </summary>
        //public string OutWhouseName
        //{
        //    get
        //    {
        //        return outWhouseName;
        //    }

        //    set
        //    {
        //        outWhouseName = value;
        //    }
        //}
    }
}
