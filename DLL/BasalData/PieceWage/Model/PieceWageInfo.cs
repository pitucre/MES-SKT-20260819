using System;
 
namespace SKT.LeanMES.PieceWage.Model
{ 
    [Serializable]
    public class PieceWageInfo
    {
        private Int32 pieceWageId;
        private Int32 stationId;
        private Int32 equipmentId;
        private Int32 itemId;
        private Decimal price;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;
        private String remark;
        public String Station { get; set; }
        public String EquipmentCode { get; set; }
        public String ItemCode { get; set; }
        public String NO { get; set; }
        public int ID { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PieceWageInfo 类的新实例。
        /// </summary>
        public PieceWageInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PieceWageInfo 类的新实例。
        /// </summary>
        /// <param name="pieceWageId"></param>
        /// <param name="stationId"></param>
        /// <param name="equipmentId"></param>
        /// <param name="itemId"></param>
        /// <param name="price"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="remark"></param>
        public PieceWageInfo(Int32 pieceWageId, Int32 stationId, Int32 equipmentId, Int32 itemId, 
            Decimal price, DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy, 
            String remark)
        {
            this.pieceWageId = pieceWageId;
            this.stationId = stationId;
            this.equipmentId = equipmentId;
            this.itemId = itemId;
            this.price = price;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PieceWageId
        {
            get { return this.pieceWageId; }
            set { this.pieceWageId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal Price
        {
            get { return this.price; }
            set { this.price = value; }
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
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
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
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}