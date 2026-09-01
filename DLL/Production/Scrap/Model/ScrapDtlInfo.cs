using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Scrap.Model
{
    /// <summary>
    /// 报废申请单明细表表实例类 add by zhi.li 2018-06-30
    /// </summary>
    [Serializable]
    public class ScrapDtlInfo
    {
        private Int32 scrapDtlId;
        private Int32 scrapId;
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
        /// 初始化 SKT.LeanMES.Scrap.Model.ScrapDtlInfo 类的新实例。
        /// </summary>
        public ScrapDtlInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Scrap.Model.ScrapDtlInfo 类的新实例。
        /// </summary>
        /// <param name="scrapDtlId">报废单申请明细ID</param>
        /// <param name="scrapId">报废申请单ID</param>
        /// <param name="sourceDtlId">来源明细ID</param>
        /// <param name="itemCode">物料编码</param>
        /// <param name="applyQty">申请报废数量</param>
        /// <param name="finishQty">完成报废时间</param>
        /// <param name="remark">报废原因</param>
        /// <param name="statue">状态：0-待报废  1-报废中  2-报废完成</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public ScrapDtlInfo(int scrapDtlId, int scrapId, int sourceDtlId, string itemCode, decimal applyQty, decimal finishQty, string remark, int statue, string createBy, DateTime createDateTime, string modifyBy, DateTime modifyDateTime)
        {
            this.scrapDtlId = scrapDtlId;
            this.scrapId = scrapId;
            this.sourceDtlId = sourceDtlId;
            this.itemCode = itemCode;
            this.applyQty = applyQty;
            this.finishQty = finishQty;
            this.remark = remark;
            this.statue = statue;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 报废单明细ID
        /// </summary>
        public int ScrapDtlId
        {
            get
            {
                return scrapDtlId;
            }

            set
            {
                scrapDtlId = value;
            }
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
        /// 来源明细ID
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
        /// 申请报废数量
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
        /// 完成报废时间
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
