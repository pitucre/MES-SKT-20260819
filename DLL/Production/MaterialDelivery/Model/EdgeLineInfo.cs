using System;

namespace SKT.LeanMES.MaterialDelivery.Model
{
    [Serializable]
    public class EdgeLineInfo
    {
        private Int32 edgeId;
        private String edgeName;
        private String lineIdStr;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private string serialNumber;
        private Decimal balanceQty;
        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.EdgeLineInfo 类的新实例。
        /// </summary>
        public EdgeLineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.EdgeLineInfo 类的新实例。
        /// </summary>
        /// <param name="edgeId">主键编号</param>
        /// <param name="edgeName">线边仓名</param>
        /// <param name="lineIdStr">线别字符串</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public EdgeLineInfo(Int32 edgeId, String edgeName, String lineIdStr,String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.edgeId = edgeId;
            this.edgeName = edgeName;
            this.lineIdStr = lineIdStr;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键编号
        /// </summary>
        public Int32 EdgeId
        {
            get { return this.edgeId; }
            set { this.edgeId = value; }
        }

        /// <summary>
        /// 获取或设置线边仓名
        /// </summary>
        public String EdgeName
        {
            get { return this.edgeName; }
            set { this.edgeName = value; }
        }
        /// <summary>
        /// 获取或设置产线字符串
        /// </summary>
        public String LineIdStr
        {
            get { return this.lineIdStr; }
            set { this.lineIdStr = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        /// 物料编码
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }
        /// <summary>
        /// 现存库存量
        /// </summary>
        public Decimal BalanceQty
        {
            get { return this.balanceQty; }
            set { this.balanceQty = value; }
        }
    }
}