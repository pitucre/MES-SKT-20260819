using System;

namespace SKT.LeanMES.Turnover.Model
{
    [Serializable]
    public class StockCarTypeInfo
    {
        private Int32 stockTypeId;
        private String stockTypeCode;
        private String stockTypeName;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.MES.Model.StockCarTypeInfo 类的新实例。
        /// </summary>
        public StockCarTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.StockCarTypeInfo 类的新实例。
        /// </summary>
        /// <param name="stockTypeId"></param>
        /// <param name="stockTypeCode">备料车类型Code</param>
        /// <param name="stockTypeName">备料车名称</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public StockCarTypeInfo(Int32 stockTypeId, String stockTypeCode, String stockTypeName, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.stockTypeId = stockTypeId;
            this.stockTypeCode = stockTypeCode;
            this.stockTypeName = stockTypeName;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StockTypeId
        {
            get { return this.stockTypeId; }
            set { this.stockTypeId = value; }
        }

        /// <summary>
        /// 获取或设置备料车类型Code
        /// </summary>
        public String StockTypeCode
        {
            get { return this.stockTypeCode; }
            set { this.stockTypeCode = value; }
        }

        /// <summary>
        /// 获取或设置备料车名称
        /// </summary>
        public String StockTypeName
        {
            get { return this.stockTypeName; }
            set { this.stockTypeName = value; }
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
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}