using System;

namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class MaterialIQCHandleGrnInfo
    {
        private Int64 iQCGrnId;
        private Int64 inspectionId;
        private Int64 itemId;
        private String gRN;
        private Decimal totalQty;
        private Decimal okQty;
        private Decimal ngQty;
        private Decimal scrapQty;
        private Decimal chooseQty;
        private String remark;
        private String modifyBy;
        private DateTime modifyDate;
        private String createBy;
        private DateTime createDate;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialIQCHandleGrnInfo 类的新实例。
        /// </summary>
        public MaterialIQCHandleGrnInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialIQCHandleGrnInfo 类的新实例。
        /// </summary>
        /// <param name="iQCGrnId"></param>
        /// <param name="inspectionId"></param>
        /// <param name="itemId"></param>
        /// <param name="gRN"></param>
        /// <param name="totalQty"></param>
        /// <param name="okQty"></param>
        /// <param name="ngQty"></param>
        /// <param name="scrapQty"></param>
        /// <param name="chooseQty"></param>
        /// <param name="remark"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDate"></param>
        /// <param name="createBy"></param>
        /// <param name="createDate"></param>
        public MaterialIQCHandleGrnInfo(Int64 iQCGrnId, Int64 inspectionId, Int64 itemId, String gRN, 
            Decimal totalQty, Decimal okQty, Decimal ngQty, Decimal scrapQty, Decimal chooseQty, 
            String remark, String modifyBy, DateTime modifyDate, String createBy, DateTime createDate)
        {
            this.iQCGrnId = iQCGrnId;
            this.inspectionId = inspectionId;
            this.itemId = itemId;
            this.gRN = gRN;
            this.totalQty = totalQty;
            this.okQty = okQty;
            this.ngQty = ngQty;
            this.scrapQty = scrapQty;
            this.chooseQty = chooseQty;
            this.remark = remark;
            this.modifyBy = modifyBy;
            this.modifyDate = modifyDate;
            this.createBy = createBy;
            this.createDate = createDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 IQCGrnId
        {
            get { return this.iQCGrnId; }
            set { this.iQCGrnId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 InspectionId
        {
            get { return this.inspectionId; }
            set { this.inspectionId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int64 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String GRN
        {
            get { return this.gRN; }
            set { this.gRN = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal TotalQty
        {
            get { return this.totalQty; }
            set { this.totalQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal OkQty
        {
            get { return this.okQty; }
            set { this.okQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal NgQty
        {
            get { return this.ngQty; }
            set { this.ngQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal ScrapQty
        {
            get { return this.scrapQty; }
            set { this.scrapQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Decimal ChooseQty
        {
            get { return this.chooseQty; }
            set { this.chooseQty = value; }
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
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
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
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }
    }
}