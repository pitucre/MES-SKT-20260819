using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class WarehouseCheckOrderInfo
    {
        private Int32 prodWarehouseCheckId;
        private String checkOrder;
        private Int32 checkTypeId;
        private Int32 warehouseId;
        private DateTime beginDate;
        public dynamic Time { get; set; }
        public int CheckOrderStatus { get; set; }
        public string StatusDesc { get; set; }
        private String remark;
        private String createBy;
        private DateTime createTime;
        private String updateBy;
        private DateTime updateTime;
        private String erpCode;
        private String default1;
        private String default2;
        private String default3;
        public string GRN { get; set; }

        public string Warehouse { get; set; }
        public string CheckType { get; set; }
        public dynamic FinishDate { get; set; }
        public int ItemId { get; set; }
        public string Item { get; set; }
        public string ItemCode { get; set; }
        public string WhBarcode { get; set; }//库位
        public decimal StorageQty { get; set; }//库存数量
        public string SN { get; set; }          //SN/GSN
        
        /* ADD CHENGLONG.ZHU */
        public string ItemName { get; set; }//物料名称
        public decimal NowQty { get; set; }//初盘数量
        public decimal BalanceQty { get; set; }//当前数量
        public decimal ReplayQty { get; set; }//复盘数量
        public string ChangeBy { get; set; } //平帐人   
        public dynamic ChangeTime { get; set; }//平帐时间
        public string IsChange { get; set; } //是否平帐  0：否 1：是
        public string BeginTime { get; set; } //计划时间
        public string CheckOrderName { get; set; } //盘点单名称
        public string CheckBy { get; set; } //审核人
        public string CheckTime { get; set; } //审核时间
        public string TbDtl { get; set; }
        public string HandleStyle { get; set; }
        public string ItemSpec { get; set; }
        public string VendorCode { get; set; }
        public string ABCCLass { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.WarehouseCheckOrderInfo 类的新实例。
        /// </summary>
        public WarehouseCheckOrderInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Material.Model.WarehouseCheckOrderInfo 类的新实例。
        /// </summary>
        /// <param name="prodWarehouseCheckId"></param>
        /// <param name="checkOrder"></param>
        /// <param name="checkTypeId"></param>
        /// <param name="warehouseId"></param>
        /// <param name="beginDate"></param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="updateBy"></param>
        /// <param name="updateTime"></param>
        public WarehouseCheckOrderInfo(Int32 prodWarehouseCheckId, String checkOrder, Int32 checkTypeId, Int32 warehouseId, 
            DateTime beginDate, String remark, String createBy, DateTime createTime, 
            String updateBy, DateTime updateTime)
        {
            this.prodWarehouseCheckId = prodWarehouseCheckId;
            this.checkOrder = checkOrder;
            this.checkTypeId = checkTypeId;
            this.warehouseId = warehouseId;
            this.beginDate = beginDate;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
            this.updateBy = updateBy;
            this.updateTime = updateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ProdWarehouseCheckId
        {
            get { return this.prodWarehouseCheckId; }
            set { this.prodWarehouseCheckId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CheckOrder
        {
            get { return this.checkOrder; }
            set { this.checkOrder = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CheckTypeId
        {
            get { return this.checkTypeId; }
            set { this.checkTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarehouseId
        {
            get { return this.warehouseId; }
            set { this.warehouseId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime BeginDate
        {
            get { return this.beginDate; }
            set { this.beginDate = value; }
        }

 
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String UpdateBy
        {
            get { return this.updateBy; }
            set { this.updateBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime UpdateTime
        {
            get { return this.updateTime; }
            set { this.updateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ErpCode
        {
            get { return this.erpCode; }
            set { this.erpCode = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default1
        {
            get { return this.default1; }
            set { this.default1 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default2
        {
            get { return this.default2; }
            set { this.default2 = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Default3
        {
            get { return this.default3; }
            set { this.default3 = value; }
        }
    }
}