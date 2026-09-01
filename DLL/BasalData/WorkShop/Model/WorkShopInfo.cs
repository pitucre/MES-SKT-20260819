using System;

namespace SKT.LeanMES.WorkShop.Model
{

    [Serializable]
    public class WorkShopInfo
    {
        private Int32 workShopID;
        private String workShopName;
        private String workShopCode;
        private Int32 factoryId;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private String factoryName;
        public int ShiftId { get; set; }
        public string ShiftName { get; set; }
        public int Principal { get; set; }
        public string CName { get; set; }
        public string Temperature { get; set; }
        public string Humidity { get; set; }

        public string Line { get; set; }
        //抛料率
        public string RejectRate1 { get; set; }
        public string RejectRate2 { get; set; }
        public string RejectRate3 { get; set; }
        //利用率
        public string WorkRatio1 { get; set; }
        public string WorkRatio2 { get; set; }
        public string WorkRatio3 { get; set; }
        //生产效率
        public string ProdRatio1 { get; set; }
        public string ProdRatio2 { get; set; }
        public string ProdRatio3 { get; set; }



        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.WorkShopInfo 类的新实例。
        /// </summary>
        public WorkShopInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.WorkShopInfo 类的新实例。
        /// </summary>
        /// <param name="workShopID">主键</param>
        /// <param name="workShopName">车间名称</param>
        /// <param name="workShopCode">车间编号</param>
        /// <param name="factoryCode">工厂编号</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WorkShopInfo(Int32 workShopID, String workShopName, String workShopCode, Int32 factoryId,
            String createBy, DateTime createTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.workShopID = workShopID;
            this.workShopName = workShopName;
            this.workShopCode = workShopCode;
            this.factoryId = factoryId;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.WorkShopInfo 类的新实例。
        /// </summary>
        /// <param name="workShopID">主键</param>
        /// <param name="workShopName">车间名称</param>
        /// <param name="workShopCode">车间编号</param>
        /// <param name="factoryCode">工厂编号</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public WorkShopInfo(Int32 workShopID, String workShopName, String workShopCode, Int32 factoryId,
            String createBy, DateTime createTime, String modifyBy, DateTime modifyDateTime, String remark, String FactoryName)
        {
            this.workShopID = workShopID;
            this.workShopName = workShopName;
            this.workShopCode = workShopCode;
            this.factoryId = factoryId;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.factoryName = FactoryName;
        }
        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 WorkShopID
        {
            get { return this.workShopID; }
            set { this.workShopID = value; }
        }

        /// <summary>
        /// 获取或设置车间名称
        /// </summary>
        public String WorkShopName
        {
            get { return this.workShopName; }
            set { this.workShopName = value; }
        }

        /// <summary>
        /// 获取或设置车间编号
        /// </summary>
        public String WorkShopCode
        {
            get { return this.workShopCode; }
            set { this.workShopCode = value; }
        }

        /// <summary>
        /// 获取或设置工厂编号
        /// </summary>
        public Int32 FactoryId
        {
            get { return this.factoryId; }
            set { this.factoryId = value; }
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
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 工厂名称
        /// </summary>
        public String FactoryName
        {
            get { return this.factoryName; }
            set { this.factoryName = value; }
        }
        public string LotIdentity { get; set; }

        public int UserId { get; set; }
        public string UserName { get; set; }
    }
}