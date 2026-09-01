using System;

namespace SKT.LeanMES.CapacityVerfyRecord.Model
{
    [Serializable]
    public class CapacityVerfyRecordInfo
    {
        private Int32 iD;
        private Int32 verfyType;
        private Int32 operateId;
        private Int32 equipmentId;
        private Int32 itemId;
        private Decimal salary;
        private Decimal qty;
        private Decimal nGQty;
        private DateTime createTime;
        private String createBy;
        private Int32 userID;
        private DateTime queryDate;
        private String remark;
        private Int32 pieceWageID;
        private Decimal price;
        private Int32 state;
        private DateTime modifyDateTime;
        private String modifyby;
        public String UserName { get; set; }
        public String NO { get; set; }
        public String Station { get; set; }
        public String EquipmentCode { get; set; }
        public String ItemCode { get; set; }
        public String ItemName { get; set; }
        public Decimal AuditingSalary { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.CapacityVerfyRecordInfo 类的新实例。
        /// </summary>
        public CapacityVerfyRecordInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.CapacityVerfyRecordInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="verfyType">类别  0:产能确认  1:物料使用确认</param>
        /// <param name="operateId">工序</param>
        /// <param name="equipmentId">设备id</param>
        /// <param name="itemId">物料ID</param>
        /// <param name="salary">工资</param>
        /// <param name="qty">数量</param>
        /// <param name="nGQty">不良数量</param>
        /// <param name="createTime">创建时间</param>
        /// <param name="createBy">创建人</param>
        /// <param name="userID">用户ID</param>
        /// <param name="queryDate"></param>
        /// <param name="remark"></param>
        /// <param name="pieceWageID"></param>
        /// <param name="price"></param>
        /// <param name="state">状态(0:添加  1:审核)</param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyby"></param>
        public CapacityVerfyRecordInfo(Int32 iD, Int32 verfyType, Int32 operateId, Int32 equipmentId,
            Int32 itemId, Decimal salary, Decimal qty, Decimal nGQty, DateTime createTime,
            String createBy, Int32 userID, DateTime queryDate, String remark, Int32 pieceWageID,
            Decimal price, Int32 state, DateTime modifyDateTime, String modifyby)
        {
            this.iD = iD;
            this.verfyType = verfyType;
            this.operateId = operateId;
            this.equipmentId = equipmentId;
            this.itemId = itemId;
            this.salary = salary;
            this.qty = qty;
            this.nGQty = nGQty;
            this.createTime = createTime;
            this.createBy = createBy;
            this.userID = userID;
            this.queryDate = queryDate;
            this.remark = remark;
            this.pieceWageID = pieceWageID;
            this.price = price;
            this.state = state;
            this.modifyDateTime = modifyDateTime;
            this.modifyby = modifyby;
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
        /// 获取或设置类别  0:产能确认  1:物料使用确认
        /// </summary>
        public Int32 VerfyType
        {
            get { return this.verfyType; }
            set { this.verfyType = value; }
        }

        /// <summary>
        /// 获取或设置工序
        /// </summary>
        public Int32 OperateId
        {
            get { return this.operateId; }
            set { this.operateId = value; }
        }

        /// <summary>
        /// 获取或设置设备id
        /// </summary>
        public Int32 EquipmentId
        {
            get { return this.equipmentId; }
            set { this.equipmentId = value; }
        }

        /// <summary>
        /// 获取或设置物料ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置工资
        /// </summary>
        public Decimal Salary
        {
            get { return this.salary; }
            set { this.salary = value; }
        }

        /// <summary>
        /// 获取或设置数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 获取或设置不良数量
        /// </summary>
        public Decimal NGQty
        {
            get { return this.nGQty; }
            set { this.nGQty = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置用户ID
        /// </summary>
        public Int32 UserID
        {
            get { return this.userID; }
            set { this.userID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime QueryDate
        {
            get { return this.queryDate; }
            set { this.queryDate = value; }
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
        public Int32 PieceWageID
        {
            get { return this.pieceWageID; }
            set { this.pieceWageID = value; }
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
        /// 获取或设置状态(0:添加  1:审核)
        /// </summary>
        public Int32 State
        {
            get { return this.state; }
            set { this.state = value; }
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
        public String Modifyby
        {
            get { return this.modifyby; }
            set { this.modifyby = value; }
        }
    }
}