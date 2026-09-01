using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace SKT.LeanMES.Material.Model
{
    [Serializable]
    public class ApplyInfo
    {
        private Int64 applyId;
        private String applyNo;
        private Int32 applyType;
        private String mOCode;
        private String depCode;
        private String depName;
        private String whCode;
        private String whName;
        private DateTime useDateTime;
        private String remark;
        private Int32 statue;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public Int64 ItemID { set; get; }
        public String ItemCode { set; get; }
        public String ItemName { set; get; }
        public string applyDtl { get; set; }
        public Int64 MOID { set; get; }
        public Int64 MODtlID { set; get; }
        public Int64 MODtlNO { set; get; }
        public Int64 AutoIdStr { set; get; }
        public String StartTime { set; get; }
        public Double AuxQtyMust { set; get; }
        public Double AuxStockQty { set; get; }
        public Int64 RequestId { set; get; }
        public String userName { set; get; }
        public String tbDtl { set; get; }
        public Double Qty { set; get; }
        public Double ApplyQtySum { set; get; }//已领未备料数量
        public String FactoryCode { set; get; }
        public dynamic AutoID { set; get; }
        public dynamic POID { set; get; }

        public Int64 ApplyDtlId { set; get; }
        public string SrcOrderType { set; get; }
        public string ApplyTypeDesc { set; get; }
        public string ItemSpec { set; get; }
        public Decimal LeftQty { set; get; }
        public Decimal ApplyQty { set; get; }
        public Decimal StockQty { set; get; }
        public string StatueDesc { set; get; }
        public Int32 PrepareMaterialId { set; get; }
        public String PrepareMaterialNo { set; get; }
        public String SerialNumber { set; get; }
        public Decimal BalanceQty { set; get; }
        public string MergeApplyNo { set; get; }
        public int MergeId { set; get; }
        public int RowId { set; get; }
        public int ApplyClass { set; get; }
        public int ItemQty { set; get; }
        

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ApplyInfo 类的新实例。
        /// </summary>
        public ApplyInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ApplyInfo 类的新实例。
        /// </summary>
        /// <param name="applyId">领料申请主表</param>
        /// <param name="applyNo">申请单号</param>
        /// <param name="applyType">类型(0:工单领料 1:手工增加)</param>
        /// <param name="mOCode">生产投料单</param>
        /// <param name="depCode">生产部门编码</param>
        /// <param name="depName">生产部门名称</param>
        /// <param name="whCode">仓库编码</param>
        /// <param name="whName">仓库名称</param>
        /// <param name="useDateTime">使用日期</param>
        /// <param name="remark">备注</param>
        /// <param name="statue">状态：0未备料，1已备料，2已接收，3已退料</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public ApplyInfo(Int64 applyId, String applyNo, Int32 applyType, String mOCode,
            String depCode, String depName, String whCode, String whName, DateTime useDateTime,
            String remark, Int32 statue, String createBy, DateTime createDateTime, String modifyBy,
            DateTime modifyDateTime)
        {
            this.applyId = applyId;
            this.applyNo = applyNo;
            this.applyType = applyType;
            this.mOCode = mOCode;
            this.depCode = depCode;
            this.depName = depName;
            this.whCode = whCode;
            this.whName = whName;
            this.useDateTime = useDateTime;
            this.remark = remark;
            this.statue = statue;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置领料申请主表
        /// </summary>
        public Int64 ApplyId
        {
            get { return this.applyId; }
            set { this.applyId = value; }
        }

        /// <summary>
        /// 获取或设置申请单号
        /// </summary>
        public String ApplyNo
        {
            get { return this.applyNo; }
            set { this.applyNo = value; }
        }

        /// <summary>
        /// 获取或设置类型(0:工单领料 1:手工增加)
        /// </summary>
        public Int32 ApplyType
        {
            get { return this.applyType; }
            set { this.applyType = value; }
        }

        /// <summary>
        /// 获取或设置生产投料单
        /// </summary>
        public String MOCode
        {
            get { return this.mOCode; }
            set { this.mOCode = value; }
        }

        /// <summary>
        /// 获取或设置生产部门编码
        /// </summary>
        public String DepCode
        {
            get { return this.depCode; }
            set { this.depCode = value; }
        }

        /// <summary>
        /// 获取或设置生产部门名称
        /// </summary>
        public String DepName
        {
            get { return this.depName; }
            set { this.depName = value; }
        }

        /// <summary>
        /// 获取或设置仓库编码
        /// </summary>
        public String WhCode
        {
            get { return this.whCode; }
            set { this.whCode = value; }
        }

        /// <summary>
        /// 获取或设置仓库名称
        /// </summary>
        public String WhName
        {
            get { return this.whName; }
            set { this.whName = value; }
        }

        /// <summary>
        /// 获取或设置使用日期
        /// </summary>
        public DateTime UseDateTime { get; set; }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置状态：0未备料，1已备料，2已接收，3已退料
        /// </summary>
        public Int32 Statue
        {
            get { return this.statue; }
            set { this.statue = value; }
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

        /// <summary>
        /// 订单
        /// </summary>
        public string SourceBillNo { get; set; }

        /// <summary>
        /// 发料项次（仓库备料看板用到）
        /// </summary>
        public int SendQty { get; set; }

        /// <summary>
        /// 发料GRN数量（仓库备料看板用到）
        /// </summary>
        public decimal GRNQty { get; set; }

        /// <summary>
		/// 其它领料类别
		/// </summary>
		public string OtherApplyType { set; get; }
        /// <summary>
        /// 接收人
        /// </summary>
        public string PrepareName { set; get; }
        /// <summary>
        /// 接收日期
        /// </summary>
        public DateTime PrepareDateTime { set; get; }
    }
}
