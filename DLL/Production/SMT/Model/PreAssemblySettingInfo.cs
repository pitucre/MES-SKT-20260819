using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class PreAssemblySettingInfo
    {
        private Int32 iD;
        private Int32 modelID;
        private String modelNo;
        private Int32 partID;
        private String partNo;
        private String use_QTY;
        private String location;
        private String station;
        private Int32 stationID;
        private String line;
        private Int32 lineID;
        public string ItemName { get; set; }
        private String itemCode;
        private String itemDesc;
        private Decimal grnQty;
        private String lotNo;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PreAssemblySettingInfo 类的新实例。
        /// </summary>
        public PreAssemblySettingInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PreAssemblySettingInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="modelID"></param>
        /// <param name="modelNo"></param>
        /// <param name="partID"></param>
        /// <param name="partNo"></param>
        /// <param name="use_QTY"></param>
        /// <param name="location"></param>
        /// <param name="station"></param>
        /// <param name="stationID"></param>
        /// <param name="line"></param>
        /// <param name="lineID"></param>
        public PreAssemblySettingInfo(Int32 iD, Int32 modelID, String modelNo, Int32 partID,
            String partNo, String use_QTY, String location, String station, Int32 stationID,
            String line, Int32 lineID)
        {
            this.iD = iD;
            this.modelID = modelID;
            this.modelNo = modelNo;
            this.partID = partID;
            this.partNo = partNo;
            this.use_QTY = use_QTY;
            this.location = location;
            this.station = station;
            this.stationID = stationID;
            this.line = line;
            this.lineID = lineID;
        }


        public String LotNo
        {
            get { return this.lotNo; }
            set { this.lotNo = value; }
        }

        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        public String ItemDesc
        {
            get { return this.itemDesc; }
            set { this.itemDesc = value; }
        }
        public Decimal GrnQty
        {
            get { return this.grnQty; }
            set { this.grnQty = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ModelID
        {
            get { return this.modelID; }
            set { this.modelID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModelNo
        {
            get { return this.modelNo; }
            set { this.modelNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PartID
        {
            get { return this.partID; }
            set { this.partID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PartNo
        {
            get { return this.partNo; }
            set { this.partNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Use_QTY
        {
            get { return this.use_QTY; }
            set { this.use_QTY = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Location
        {
            get { return this.location; }
            set { this.location = value; }
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
        public Int32 StationID
        {
            get { return this.stationID; }
            set { this.stationID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Line
        {
            get { return this.line; }
            set { this.line = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LineID
        {
            get { return this.lineID; }
            set { this.lineID = value; }
        }
    }
}