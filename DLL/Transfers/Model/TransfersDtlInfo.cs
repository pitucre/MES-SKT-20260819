using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Transfers.Model
{
    /// <summary>
    /// 调拨明细实例类 add by zhi.li 2018-06-08
    /// </summary>
    [Serializable]
    public class TransfersDtlInfo
    {
        private Int32 transfersDtlId;
        private Int32 transfersId;
        private Int32 sourceDtlId;
        private String itemCode;
        private Decimal applyQty;
        private Decimal finishQty;
        private String remark;
        private Int32 statue;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProdTransfersDtlInfo 类的新实例。
        /// </summary>
        public TransfersDtlInfo()
        {
        }

        /// <summary>
        ///  初始化 SKT.LeanMES.Model.ProdTransfersDtlInfo 类的新实例。
        /// </summary>
        /// <param name="transfersDtlId"></param>
        /// <param name="transfersId"></param>
        /// <param name="sourceDtlId"></param>
        /// <param name="itemCode"></param>
        /// <param name="applyQty"></param>
        /// <param name="finishQty"></param>
        /// <param name="remark"></param>
        /// <param name="statue"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public TransfersDtlInfo(int transfersDtlId, int transfersId, int sourceDtlId, string itemCode, decimal applyQty, decimal finishQty, string remark, int statue, string createBy, DateTime createDateTime, string modifyBy, DateTime modifyDateTime)
        {
            this.TransfersDtlId = transfersDtlId;
            this.TransfersId = transfersId;
            this.SourceDtlId = sourceDtlId;
            this.ItemCode = itemCode;
            this.ApplyQty = applyQty;
            this.FinishQty = finishQty;
            this.Remark = remark;
            this.Statue = statue;
            this.CreateBy = createBy;
            this.CreateDateTime = createDateTime;
            this.ModifyBy = modifyBy;
            this.ModifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 调拨单明细TransfersDtlId
        /// </summary>
        public int TransfersDtlId
        {
            get
            {
                return transfersDtlId;
            }

            set
            {
                transfersDtlId = value;
            }
        }

        /// <summary>
        /// 调拨单ID
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
        /// 来源单明细ID
        /// </summary>
        public int SourceDtlId
        {
            get
            {
                return sourceDtlId;
            }

            set
            {
                sourceDtlId = value;
            }
        }

        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode
        {
            get
            {
                return itemCode;
            }

            set
            {
                itemCode = value;
            }
        }

        /// <summary>
        /// 申请调拨数量
        /// </summary>
        public decimal ApplyQty
        {
            get
            {
                return applyQty;
            }

            set
            {
                applyQty = value;
            }
        }

        /// <summary>
        /// 调拨完成数量
        /// </summary>
        public decimal FinishQty
        {
            get
            {
                return finishQty;
            }

            set
            {
                finishQty = value;
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

    }
}
