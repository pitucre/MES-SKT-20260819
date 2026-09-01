using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ProductIPQCInfo
    {
        private Int64 productIPQCId;
        private String productIPQCNo;
        private Int64 itemID;
        private String itemCode;
        private String orderNO;
        private Double orderQty;
        private Double inspectionQty;
        private Double ngQty;
        private Int32 shiftType;
        private String prodUser;
        private String inspectionUser;
        private String auditing;
        private String printLv;
        private DateTime checkDate;
        private Int32 statue;
        private String remark;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductIPQCInfo 类的新实例。
        /// </summary>
        public ProductIPQCInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProductIPQCInfo 类的新实例。
        /// </summary>
        /// <param name="productIPQCId">IPQC巡检单主表</param>
        /// <param name="productIPQCNo">检验单号</param>
        /// <param name="itemID">产品ID</param>
        /// <param name="itemCode">产品编码</param>
        /// <param name="orderNO">工单编号</param>
        /// <param name="orderQty">工单数量</param>
        /// <param name="inspectionQty">检查数量</param>
        /// <param name="ngQty">不良数量</param>
        /// <param name="shiftType">班次类别(0白班，1晚班)</param>
        /// <param name="prodUser">生产确认</param>
        /// <param name="inspectionUser">检验员</param>
        /// <param name="auditing">审核人</param>
        /// <param name="printLv">打印版本</param>
        /// <param name="checkDate">检验日期</param>
        /// <param name="statue">状态</param>
        /// <param name="remark">备注</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ProductIPQCInfo(Int64 productIPQCId, String productIPQCNo, Int64 itemID, String itemCode, 
            String orderNO, Double orderQty, Double inspectionQty, Double ngQty, Int32 shiftType, 
            String prodUser, String inspectionUser, String auditing, String printLv, DateTime checkDate, 
            Int32 statue, String remark, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.productIPQCId = productIPQCId;
            this.productIPQCNo = productIPQCNo;
            this.itemID = itemID;
            this.itemCode = itemCode;
            this.orderNO = orderNO;
            this.orderQty = orderQty;
            this.inspectionQty = inspectionQty;
            this.ngQty = ngQty;
            this.shiftType = shiftType;
            this.prodUser = prodUser;
            this.inspectionUser = inspectionUser;
            this.auditing = auditing;
            this.printLv = printLv;
            this.checkDate = checkDate;
            this.statue = statue;
            this.remark = remark;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置IPQC巡检单主表
        /// </summary>
        public Int64 ProductIPQCId
        {
            get { return this.productIPQCId; }
            set { this.productIPQCId = value; }
        }

        /// <summary>
        /// 获取或设置检验单号
        /// </summary>
        public String ProductIPQCNo
        {
            get { return this.productIPQCNo; }
            set { this.productIPQCNo = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int64 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }

        /// <summary>
        /// 获取或设置产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        /// <summary>
        /// 获取或设置工单编号
        /// </summary>
        public String OrderNO
        {
            get { return this.orderNO; }
            set { this.orderNO = value; }
        }

        /// <summary>
        /// 获取或设置工单数量
        /// </summary>
        public Double OrderQty
        {
            get { return this.orderQty; }
            set { this.orderQty = value; }
        }

        /// <summary>
        /// 获取或设置检查数量
        /// </summary>
        public Double InspectionQty
        {
            get { return this.inspectionQty; }
            set { this.inspectionQty = value; }
        }

        /// <summary>
        /// 获取或设置不良数量
        /// </summary>
        public Double NgQty
        {
            get { return this.ngQty; }
            set { this.ngQty = value; }
        }

        /// <summary>
        /// 获取或设置班次类别(0白班，1晚班)
        /// </summary>
        public Int32 ShiftType
        {
            get { return this.shiftType; }
            set { this.shiftType = value; }
        }

        /// <summary>
        /// 获取或设置生产确认
        /// </summary>
        public String ProdUser
        {
            get { return this.prodUser; }
            set { this.prodUser = value; }
        }

        /// <summary>
        /// 获取或设置检验员
        /// </summary>
        public String InspectionUser
        {
            get { return this.inspectionUser; }
            set { this.inspectionUser = value; }
        }

        /// <summary>
        /// 获取或设置审核人
        /// </summary>
        public String Auditing
        {
            get { return this.auditing; }
            set { this.auditing = value; }
        }

        /// <summary>
        /// 获取或设置打印版本
        /// </summary>
        public String PrintLv
        {
            get { return this.printLv; }
            set { this.printLv = value; }
        }

        /// <summary>
        /// 获取或设置检验日期
        /// </summary>
        public DateTime CheckDate
        {
            get { return this.checkDate; }
            set { this.checkDate = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
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