using System;

namespace SKT.LeanMES.Customer.Model
{
    [Serializable]
    public class ProjectInfo
    {
        private Int32 projectId;
        private String proName;
        private String proDesc;
        private Int32 customerID;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String customerName;

        public string CustomerOrder { get; set; }
        public string CustomerOrder_LOT { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string ItemSpec { get; set; }
        public int Qty { get; set; }
        public string CustomerCode { get; set; }
        public int CustomerOrderID { get; set; }


        /// <summary>
        /// 单据日期
        /// </summary>
        public DateTime OrderDateTime { get; set; }
        /// <summary>
        /// 状态 9为已开启   10为已关闭
        /// </summary>
        public int OpenDataStatus { get; set; }
        /// <summary>
        /// 状态 9为已开启   10为已关闭
        /// </summary>
        public string OpenDataStatusName { get; set; }
        /// <summary>
        /// 来源
        /// </summary>
        public string SourceType { get; set; }
        /// <summary>
        /// 是否MES添加
        /// </summary>
        public int IsMesAdd { get; set; }
        /// <summary>
        /// 备注
        /// </summary>
        public string OrderRem { get; set; }



        /// <summary>
        /// 初始化 SKT.LeanMES.Customer.Model.ProjectInfo 类的新实例。
        /// </summary>
        public ProjectInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Customer.Model.ProjectInfo 类的新实例。
        /// </summary>
        /// <param name="projectId">Unique Identifier</param>
        /// <param name="proName">项目名称。</param>
        /// <param name="proDesc">项目描述。</param>
        /// <param name="customerID"></param>
        /// <param name="createBy">创建人。</param>
        /// <param name="createDateTime">创建时间。</param>
        /// <param name="modifyBy">修改人。</param>
        /// <param name="modifyDateTime">修改时间。</param>
        /// <param name="remark">备注。</param>
        public ProjectInfo(Int32 projectId, String proName, String proDesc, Int32 customerID,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.projectId = projectId;
            this.proName = proName;
            this.proDesc = proDesc;
            this.customerID = customerID;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 ProjectId
        {
            get { return this.projectId; }
            set { this.projectId = value; }
        }

        /// <summary>
        /// 获取或设置项目名称。
        /// </summary>
        public String ProName
        {
            get { return this.proName; }
            set { this.proName = value; }
        }

        /// <summary>
        /// 获取或设置项目描述。
        /// </summary>
        public String ProDesc
        {
            get { return this.proDesc; }
            set { this.proDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 CustomerID
        {
            get { return this.customerID; }
            set { this.customerID = value; }
        }

        /// <summary>
        /// 获取或设置创建人。
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间。
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人。
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间。
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置备注。
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public String CustomerName
        {
            get { return this.customerName; }
            set { this.customerName = value; }
        }
    }
}