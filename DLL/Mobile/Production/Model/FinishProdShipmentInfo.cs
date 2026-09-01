using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MobileMat.Model
{
    [Serializable]
    public class FinishProdShipmentInfo
    {
        public FinishProdShipmentInfo()
        {
        }
        public FinishProdShipmentInfo(int ShipmentId, string WorkOrderNo, string ErpCode, string ErpDate, string CusCode, DateTime ModifyDateTime, string ModifyBy, DateTime CreateDateTime, string CreateBy, string Remark, string ItemName)
        {
            this.ShipmentId = ShipmentId;
            this.WorkOrderNo = WorkOrderNo;
            this.ErpCode = ErpCode;
            this.ErpDate = ErpDate;
            this.CusCode = CusCode;
            this.ModifyDateTime = ModifyDateTime;
            this.ModifyBy = ModifyBy;
            this.CreateDateTime = CreateDateTime;
            this.CreateBy = CreateBy;
            this.Remark = Remark;
            this.ItemName = ItemName;
        }
        /// <summary>
        /// 成品出货主表自增Id
        /// </summary>
        private int shipmentId;

        public int ShipmentId
        {
            get { return shipmentId; }
            set { shipmentId = value; }
        }
        /// <summary>
        /// MES出货单据
        /// </summary>
        private string workOrderNo;

        public string WorkOrderNo
        {
            get { return workOrderNo; }
            set { workOrderNo = value; }
        }

        /// <summary>
        /// 出货单据(erp)
        /// </summary>
        private string erpCode;

        public string ErpCode
        {
            get { return erpCode; }
            set { erpCode = value; }
        }

        /// <summary>
        /// 出货日期(erp) 
        /// </summary>
        private string erpDate;

        public string ErpDate
        {
            get { return erpDate; }
            set { erpDate = value; }
        }

        /// <summary>
        /// 客户编码
        /// </summary>
        private string cusCode;

        public string CusCode
        {
            get { return cusCode; }
            set { cusCode = value; }
        }

        /// <summary>
        /// 修改时间（默认值是9999-12-31）
        /// </summary>
        private DateTime modifyDateTime;

        public DateTime ModifyDateTime
        {
            get { return modifyDateTime; }
            set { modifyDateTime = value; }
        }

        /// <summary>
        /// 修改人（默认值是''）
        /// </summary>
        private string modifyBy;

        public string ModifyBy
        {
            get { return modifyBy; }
            set { modifyBy = value; }
        }

        /// <summary>
        /// 创建时间（默认值是当前时间）
        /// </summary>
        private DateTime createDateTime;

        public DateTime CreateDateTime
        {
            get { return createDateTime; }
            set { createDateTime = value; }
        }

        /// <summary>
        /// 创建人(默认值是'')
        /// </summary>
        private string createBy;

        public string CreateBy
        {
            get { return createBy; }
            set { createBy = value; }
        }

        /// <summary>
        /// 备注
        /// </summary>
        private string remark;

        public string Remark
        {
            get { return remark; }
            set { remark = value; }
        }
        /// <summary>
        /// 工单号
        /// </summary>
        private string workOrder;

        public string WorkOrder
        {
            get { return workOrder; }
            set { workOrder = value; }
        }
        /// <summary>
        /// 产品名称
        /// </summary>
        private string itemName;

        public string ItemName
        {
            get { return itemName; }
            set { itemName = value; }
        }
        /// <summary>
        /// 时间格式的字符串
        /// </summary>
        private string shipmentDateStr;

        public string ShipmentDateStr
        {
            get { return shipmentDateStr; }
            set { shipmentDateStr = value; }
        }
        /// <summary>
        /// 所扫的条码
        /// </summary>
        private string sNValue;

        public string SNValue
        {
            get { return sNValue; }
            set { sNValue = value; }
        }
        /// <summary>
        /// ERP出货明细Id
        /// </summary>
        private int autoId;

        public int AutoId
        {
            get { return autoId; }
            set { autoId = value; }
        }
        /// <summary>
        /// ItemId
        /// </summary>
        private int itemId;

        public int ItemId
        {
            get { return itemId; }
            set { itemId = value; }
        }
        /// <summary>
        /// 数量
        /// </summary>
        private int qty;

        public int Qty
        {
            get { return qty; }
            set { qty = value; }
        }
        /// <summary>
        /// 来源工单
        /// </summary>
        private string sourceBillNo;

        public string SourceBillNo
        {
            get { return sourceBillNo; }
            set { sourceBillNo = value; }
        }
        /// <summary>
        /// SOCode
        /// </summary>
        private string sOCode;

        public string SOCode
        {
            get { return sOCode; }
            set { sOCode = value; }
        }
    }
}
