using System;

namespace SKT.LeanMES.PieceWage.Model
{
    [Serializable]
    public class StationOutputRateInfo
    {
        private Int32 stationOutputRateId;
        private Int32 stationID;
        private Decimal startRate;
        private Decimal endRate;
        private Decimal coefficient;
        private String createBy;
        private DateTime createDateTime;
        private String remark;
        private String productType;
        private String station;
        private Int32 productTypeID;
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationOutputRateInfo 类的新实例。
        /// </summary>
        public StationOutputRateInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.StationOutputRateInfo 类的新实例。
        /// </summary>
        /// <param name="stationOutputRateId"></param>
        /// <param name="stationID"></param>
        /// <param name="startRate"></param>
        /// <param name="endRate"></param>
        /// <param name="coefficient"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="productType"></param>
        public StationOutputRateInfo(Int32 stationOutputRateId, Int32 stationID, Decimal startRate, Decimal endRate, 
            Decimal coefficient, String createBy, DateTime createDateTime, String remark, String productType)
        {
            this.stationOutputRateId = stationOutputRateId;
            this.stationID = stationID;
            this.startRate = startRate;
            this.endRate = endRate;
            this.coefficient = coefficient;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.remark = remark;
            this.productType = productType;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ProductTypeID
        {
            get { return this.productTypeID; }
            set { this.productTypeID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationOutputRateId
        {
            get { return this.stationOutputRateId; }
            set { this.stationOutputRateId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationID
        {
            get { return this.stationID; }
            set { this.stationID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal StartRate
        {
            get { return this.startRate; }
            set { this.startRate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal EndRate
        {
            get { return this.endRate; }
            set { this.endRate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Coefficient
        {
            get { return this.coefficient; }
            set { this.coefficient = value; }
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
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ProductType
        {
            get { return this.productType; }
            set { this.productType = value; }
        }
    }
}