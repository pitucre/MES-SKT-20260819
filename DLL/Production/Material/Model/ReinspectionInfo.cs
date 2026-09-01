using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    public class ReinspectionInfo
    {
        public Int64 MaterialUnitId { get; set; }
        public int ReinspectionId { get; set; }
        public int ReinspectionDtlId { get; set; }
        public string ReinspectionNo { get; set; }
        public decimal Quantity { get; set; }
        public string CheckResultName { get; set; }
        public int Status { get; set; }
        public int ProdOrderID { get; set; }
        public string Remark { get; set; }
        public string OrderNO { get; set; }
        public string CreateBy { get; set; }
        public string VendorName { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string SerialNumber { get; set; }
        public decimal BalanceQty { get; set; }
        public string LotCode { get; set; }
        public string ExpiredDate { get; set; }
        public string DateCode { get; set; }
        public int CheckNumber { get; set; }
        public DateTime CreateDateTime { get; set; }
        /// <summary>
        /// 剩余过期日期
        /// </summary>
        public int SurplusExpiredDate { get; set; }

        public string ItemSpec { get; set; }

        public string CWhName { get; set; }

        public string CBarCode { get; set; }

        public string DeliverBy { get; set; }
        public DateTime DeliverDateTime { get; set; }
        public string FinishBy { get; set; }
        public DateTime FinishDateTime { get; set; }

        public decimal ReceiveQty { get; set; }

        //add by zhi.li 20180621

        /// <summary>
        /// 不合格数量
        /// </summary>
        public decimal NgQty { get; set; }

        /// <summary>
        /// 合格数量
        /// </summary>
        public decimal OkQty { get; set; }

        public string CWhCode { get; set; }

        public string ApplyNo { get; set; }

        public string OrderItemCode { get; set; }
        public string OrderItemName { get; set; }
        public string TbDtl { get; set; }
        public string UserName { get; set; }
        public string ProdOrderNo { get; set; }
        public int DeptId { get; set; }
        public int WhId { get; set; }

        public int RemainingShelfLife { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }
    }
}
