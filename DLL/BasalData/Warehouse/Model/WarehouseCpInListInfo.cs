using System;

namespace SKT.LeanMES.Warehouse.Model
{
    [Serializable]
    public class WarehouseCpInListInfo
    {
        private Int32 warehouseCpInListId;
        private String inStockNo;
        private String workOrderNo;
        private String materialId;
        private Int32 warehouseId;
        private Int32 inQty;
        private String createBy;
        private DateTime createDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseCpInListInfo 类的新实例。
        /// </summary>
        public WarehouseCpInListInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Warehouse.Model.WarehouseCpInListInfo 类的新实例。
        /// </summary>
        /// <param name="warehouseCpInListId"></param>
        /// <param name="inStockNo"></param>
        /// <param name="workOrderNo"></param>
        /// <param name="materialId"></param>
        /// <param name="warehouseId"></param>
        /// <param name="inQty"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        public WarehouseCpInListInfo(Int32 warehouseCpInListId, String inStockNo, String workOrderNo, String materialId,
            Int32 warehouseId, Int32 inQty, String createBy, DateTime createDateTime)
        {
            this.warehouseCpInListId = warehouseCpInListId;
            this.inStockNo = inStockNo;
            this.workOrderNo = workOrderNo;
            this.materialId = materialId;
            this.warehouseId = warehouseId;
            this.inQty = inQty;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarehouseCpInListId
        {
            get { return this.warehouseCpInListId; }
            set { this.warehouseCpInListId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String InStockNo
        {
            get { return this.inStockNo; }
            set { this.inStockNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String WorkOrderNo
        {
            get { return this.workOrderNo; }
            set { this.workOrderNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MaterialId
        {
            get { return this.materialId; }
            set { this.materialId = value; }
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
        public Int32 InQty
        {
            get { return this.inQty; }
            set { this.inQty = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }
        /// <summary>
        /// 物料ID
        /// </summary>
        public int ItemID { get; set; }
        /// <summary>
        /// 物料编码
        /// </summary>
        public string ItemCode { get; set; }
        /// <summary>
        /// 物料名称
        /// </summary>
        public String ItemName { get; set; }
        /// <summary>
        /// 仓库名称
        /// </summary>
        public string CWhName { get; set; }
        /// <summary>
        /// 用户名
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// SN
        /// </summary>
        public String SNId { get; set; }
        /// <summary>
        /// 工单状态
        /// </summary>
        public String Status { get; set; }
        /// <summary>
        /// SN状态
        /// </summary>
        public Int32 SNStatusID { get; set; }
        /// <summary>
        /// 工单数量
        /// </summary>
        public int Value { get; set; }
        /// <summary>
        /// 已入库数量
        /// </summary>
        public int StorageQty { get; set; }
        /// <summary>
        /// 栈板编码
        /// </summary>
        public string PalletCode { get; set; }
        /// <summary>
        /// 卡通箱编码
        /// </summary>
        public string ContainerCode { get; set; }
        public string BarCode { get; set; }

        public string ErpStatus { get; set; }
        public int StatusId { get; set; }
        /// <summary>
        /// 
        /// </summary>
        public string QcLotNo { get; set; }
        /// <summary>
        /// 客户编码
        /// </summary>
        public string CustomerSN { get; set; }

        public string CWhCode { get; set; }
        /// <summary>
        /// 批次条码数量
        /// </summary>
        public decimal BatchQty { get; set; }



        /// <summary>
        /// 入库单号
        /// </summary>
        public string StorageNo { get; set; }

        /// <summary>
        /// 库位条码
        /// </summary>
        public string cBarCode { get; set; }

        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 工单号
        /// </summary>
        public string OrderNO { get; set; }

        /// <summary>
        /// 报废数量
        /// </summary>
        public int ScrapQty { get; set; }

        /// <summary>
        /// ERP入库单别
        /// </summary>
        public string ERPDocCode { get; set; }

        /// <summary>
        /// 线别
        /// </summary>
        public string LineName { get; set; }

        /// <summary>
        /// 客户料号
        /// </summary>
        public string CPN { get; set; }  

    }
}