using System;

namespace SKT.LeanMES.Resource.Model
{
    [Serializable]
    public class LineInfo
    {
        private Int32 lineId;
        private String lineName;
        private String lineDescription;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private int p;
        private string p_2;
        private Decimal limitValue;
        private Decimal ecPatch;

        private String serialNumber;
        private decimal balanceQuatity;
        public string PrincipalName { get; set; }
        public decimal StandardHuman { get; set; }
        public decimal ActualNumber { get; set; }
        public int Principal { get; set; }
        public int WorkShopId { get; set; }
        public string WorkShopName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Resource.Model.LineInfo 类的新实例。
        /// </summary>
        public LineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Resource.Model.LineInfo 类的新实例。
        /// </summary>
        /// <param name="lineId">Unique Identifier</param>
        /// <param name="lineName">线名</param>
        /// <param name="lineDescription">线描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public LineInfo(Int32 lineId, String lineName, String lineDescription, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.lineId = lineId;
            this.lineName = lineName;
            this.lineDescription = lineDescription;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }
         /// <summary>
        /// add by  weixia  on  2014/12/31
        /// </summary>
        /// <param name="lineId"></param>
        /// <param name="lineName"></param>
        public LineInfo(Int32  lineId,String lineName) 
        {
            this.lineId = lineId;
            this.lineName = lineName;
        }
     

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 获取或设置线描述
        /// </summary>
        public String LineDescription
        {
            get { return this.lineDescription; }
            set { this.lineDescription = value; }
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
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 临界值
        /// </summary>
        public Decimal LimitValue
        {
            get { return this.limitValue; }
            set { this.limitValue = value; }
        }
        /// <summary>
        /// 经济批量
        /// </summary>
        public Decimal EcPatch
        {
            get { return this.ecPatch; }
            set { this.ecPatch = value; }
        }

        /// <summary>
        /// 系列号
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }
        /// <summary>
        /// 产线库存量
        /// </summary>
        public Decimal BalanceQty
        {
            get { return this.balanceQuatity; }
            set { this.balanceQuatity = value; }
        }
        /// <summary>
        /// 线别设备类型
        /// </summary>
        public string LineMachineRelation { get; set; }

        /// <summary>
        /// 线别编码
        /// </summary>
        public string LineCode { get; set; }
    }
}