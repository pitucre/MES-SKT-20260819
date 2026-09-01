using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Transfers.Model
{
    /// <summary>
    /// 调拨单主表实例类 add by zhi.li 2018-06-08
    /// </summary>
    [Serializable]
    public class TransfersInfo
    {
        private Int32 transfersId;
        private String transfersNo;
        private Int32 transfersType;
        private String sourceNo;
        private Int32 statue;
        private String remark;
        private Int32 saleType;
        private Int32 vendorId;
        private Int32 transportType;
        private String depCode;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private DateTime arrivalDate;
        private Int32 auditing;
        private DateTime auditingDate;
        private Int32 financeAuditing;
        private DateTime financeDate;
        private String inWhouse;
        private String outWhouse;
        private String endUser;
        private DateTime endDate;
        private String transfersTypeName;

        private String inWhouseName;
        private String outWhouseName;
        private Int32 flage;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProdTransfersInfo 类的新实例。
        /// </summary>
        public TransfersInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProdTransfersInfo 类的新实例。
        /// </summary>
        /// <param name="transfersId"></param>
        /// <param name="transfersNo"></param>
        /// <param name="transfersType"></param>
        /// <param name="sourceNo"></param>
        /// <param name="statue"></param>
        /// <param name="remark"></param>
        /// <param name="saleType"></param>
        /// <param name="vendorId"></param>
        /// <param name="transportType"></param>
        /// <param name="depCode"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="arrivalDate"></param>
        /// <param name="auditing"></param>
        /// <param name="auditingDate"></param>
        /// <param name="financeAuditing"></param>
        /// <param name="financeDate"></param>
        /// <param name="inWhouse"></param>
        /// <param name="outWhouse"></param>
        /// <param name="endUser"></param>
        public TransfersInfo(int transfersId, string transfersNo, int transfersType, string sourceNo, int statue, string remark,
            int saleType, int vendorId, int transportType, string depCode, string createBy, DateTime createDateTime, string modifyBy, 
            DateTime modifyDateTime, DateTime arrivalDate, int auditing, DateTime auditingDate, int financeAuditing, DateTime financeDate, 
            string inWhouse, string outWhouse, string endUser, DateTime endDate)
        {
            this.transfersId = transfersId;
            this.transfersNo = transfersNo;
            this.transfersType = transfersType;
            this.sourceNo = sourceNo;
            this.statue = statue;
            this.remark = remark;
            this.saleType = saleType;
            this.vendorId = vendorId;
            this.transportType = transportType;
            this.depCode = depCode;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.arrivalDate = arrivalDate;
            this.auditing = auditing;
            this.auditingDate = auditingDate;
            this.financeAuditing = financeAuditing;
            this.financeDate = financeDate;
            this.inWhouse = inWhouse;
            this.outWhouse = outWhouse;
            this.endUser = endUser;
            this.endDate = endDate;
        }
        /// <summary>
        /// 先进先出标记
        /// </summary>
        public int Flage
        {
            get
            {
                return flage;
            }

            set
            {
                flage = value;
            }
        }
        /// <summary>
        /// 调拨单TransfersId
        /// </summary>
        public int TransfersId
        {
            get
            {
                return transfersId;
            }

            set
            {
                transfersId = value;
            }
        }

        /// <summary>
        /// 调拨单号
        /// </summary>
        public string TransfersNo
        {
            get
            {
                return transfersNo;
            }

            set
            {
                transfersNo = value;
            }
        }

        /// <summary>
        /// 调拨类型(0-无单据调拨，1-委外调拨，2-销售调拨，3-超期不良调拨)
        /// </summary>
        public int TransfersType
        {
            get
            {
                return transfersType;
            }

            set
            {
                transfersType = value;
            }
        }

        public string TransfersTypeName
        {
            get
            {
                return transfersTypeName;
            }

            set
            {
                transfersTypeName = value;
            }
        }

        /// <summary>
        /// 来源单号
        /// </summary>
        public string SourceNo
        {
            get
            {
                return sourceNo;
            }

            set
            {
                sourceNo = value;
            }
        }

        /// <summary>
        /// 调拨状态(0-待调拨，1-调拨中，2-调拨完成)
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
        /// 备注
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
        /// 销售订单类型
        /// </summary>
        public int SaleType
        {
            get
            {
                return saleType;
            }

            set
            {
                saleType = value;
            }
        }

        /// <summary>
        /// 承运商ID
        /// </summary>
        public int VendorId
        {
            get
            {
                return vendorId;
            }

            set
            {
                vendorId = value;
            }
        }

        /// <summary>
        /// 运输方式
        /// </summary>
        public int TransportType
        {
            get
            {
                return transportType;
            }

            set
            {
                transportType = value;
            }
        }

        /// <summary>
        /// 部门编码
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
        /// 修改人
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
        /// 修改时间
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
        /// 预计到货日期
        /// </summary>
        public DateTime ArrivalDate
        {
            get
            {
                return arrivalDate;
            }

            set
            {
                arrivalDate = value;
            }
        }

        /// <summary>
        /// 调拨单审核人ID
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
        /// 调拨单审核时间
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
        /// 财务记账审核人ID
        /// </summary>
        public int FinanceAuditing
        {
            get
            {
                return financeAuditing;
            }

            set
            {
                financeAuditing = value;
            }
        }

        /// <summary>
        /// 财务记账审核时间
        /// </summary>
        public DateTime FinanceDate
        {
            get
            {
                return financeDate;
            }

            set
            {
                financeDate = value;
            }
        }

        /// <summary>
        /// 调入仓库编码
        /// </summary>
        public string InWhouse
        {
            get
            {
                return inWhouse;
            }

            set
            {
                inWhouse = value;
            }
        }

        /// <summary>
        /// 调出仓库编码
        /// </summary>
        public string OutWhouse
        {
            get
            {
                return outWhouse;
            }

            set
            {
                outWhouse = value;
            }
        }

        /// <summary>
        /// 结束调拨申请人
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
        /// 结束调拨时间
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
        /// 调入仓库
        /// </summary>
        public string InWhouseName
        {
            get
            {
                return inWhouseName;
            }

            set
            {
                inWhouseName = value;
            }
        }

        /// <summary>
        ///调出仓库
        /// </summary>
        public string OutWhouseName
        {
            get
            {
                return outWhouseName;
            }

            set
            {
                outWhouseName = value;
            }
        }

        public int WarehouseId
        {
            get
            {
                return warehouseId;
            }

            set
            {
                warehouseId = value;
            }
        }

        public string CWhCode
        {
            get
            {
                return cWhCode;
            }

            set
            {
                cWhCode = value;
            }
        }

        public string CWhName
        {
            get
            {
                return cWhName;
            }

            set
            {
                cWhName = value;
            }
        }

        public string CWhPos
        {
            get
            {
                return cWhPos;
            }

            set
            {
                cWhPos = value;
            }
        }

        public Boolean BWhPos
        {
            get
            {
                return bWhPos;
            }

            set
            {
                bWhPos = value;
            }
        }

        /// <summary>
        /// 用于调拨PDA扫描GRN信息
        /// </summary>
        public string SerialNumber;
        public string ItemCode;
        public string CBarCode;
        public string BalanceQty;


        /// <summary>
        /// 无单调拨入库（选择的仓库）
        /// </summary>
        private int warehouseId;
        private string cWhCode;
        private string cWhName;
        private string cWhPos;
        private Boolean bWhPos;

        /// <summary>
        /// 是否货位管理
        /// </summary>
        public String IsBin { get; set; }
    }

}
