using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class StockCarInfo
    {
        private Int32 stockCarId;
        private String stockCarNumber;
        private Int32 stockTypeId;
        private Byte status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 minQty;
        private Int32 maxQty;
        private String stockTypeName;
        private String statusName;
        private String remark;

        /// <summary>
        /// 初始化 SKT.MES.Model.StockCarInfo 类的新实例。
        /// </summary>
        public StockCarInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.StockCarInfo 类的新实例。
        /// </summary>
        /// <param name="stockCarId"></param>
        /// <param name="stockCarNumber">备料车编码</param>
        /// <param name="stockTypeId">备料车类型</param>
        /// <param name="status">状态标识</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime">('9999-12-31')</param>
        public StockCarInfo(Int32 stockCarId, String stockCarNumber, Int32 stockTypeId, Byte status, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.stockCarId = stockCarId;
            this.stockCarNumber = stockCarNumber;
            this.stockTypeId = stockTypeId;
            this.status = status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public  String StatusName
        {
            get { return this.statusName; }
            set { this.statusName = value; }
        }

        public String StockTypeName
        {
            get { return this.stockTypeName; }
            set { this.stockTypeName = value; }
        }

        public  Int32 MinQty
        {
            get { return this.minQty; }
            set { this.minQty = value; }
        }

        public Int32 MaxQty
        {
            get { return this.maxQty; }
            set { this.maxQty = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StockCarId
        {
            get { return this.stockCarId; }
            set { this.stockCarId = value; }
        }

        /// <summary>
        /// 获取或设置备料车编码
        /// </summary>
        public String StockCarNumber
        {
            get { return this.stockCarNumber; }
            set { this.stockCarNumber = value; }
        }

        /// <summary>
        /// 获取或设置备料车类型
        /// </summary>
        public Int32 StockTypeId
        {
            get { return this.stockTypeId; }
            set { this.stockTypeId = value; }
        }

        /// <summary>
        /// 获取或设置状态标识
        /// </summary>
        public Byte Status
        {
            get { return this.status; }
            set { this.status = value; }
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
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置('9999-12-31')
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}