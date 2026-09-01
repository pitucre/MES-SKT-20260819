using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// GRN打印所需的GRN信息
    /// </summary>
    public class GRNLabelsInfo
    {
        private String supplier;
        private String itemName;
        private Decimal qty;
        private DateTime produceDate;
        private DateTime receiveDate;
        private String gRN;
        private String itemDesc;
        private Int32 zplId;
        private String lotCode;
        private String itemCode;
        private String itemSepc;


        public GRNLabelsInfo() { }

        /// <summary>
        /// 默认构造
        /// </summary>
        /// <param name="supplier">供应商</param>
        /// <param name="itemName">物料名</param>
        /// <param name="qty">数量</param>
        /// <param name="produceDate">生产日期</param>
        /// <param name="receiveDate">收料日期</param>
        /// <param name="gRN">GRN</param>
        public GRNLabelsInfo(String supplier, String itemName, Decimal qty, DateTime produceDate, DateTime receiveDate, String gRN)
        {
            this.supplier = supplier;
            this.itemName = itemName;
            this.qty = qty;
            this.produceDate = produceDate;
            this.receiveDate = receiveDate;
            this.gRN = gRN;
        }


        /// <summary>
        /// 产品规格
        /// </summary>
        public String ItemSepc
        {
            get { return this.itemSepc; }
            set { this.itemSepc = value; }
        }
        /// <summary>
        /// 产品编码
        /// </summary>
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
        /// <summary>
        /// 批次号
        /// </summary>
        public String LotCode
        {
            get { return this.lotCode; }
            set { this.lotCode = value; }
        }
        /// <summary>
        /// 供应商
        /// </summary>
        public String Supplier
        {
            get { return this.supplier; }
            set { this.supplier = value; }
        }

        /// <summary>
        /// 物料名
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        /// <summary>
        /// 数量
        /// </summary>
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        /// <summary>
        /// 生产日期
        /// </summary>
        public DateTime ProduceDate
        {
            get { return this.produceDate; }
            set { this.produceDate = value; }
        }

        /// <summary>
        /// 收料日期
        /// </summary>
        public DateTime ReceiveDate
        {
            get { return this.receiveDate; }
            set { this.receiveDate = value; }
        }

        /// <summary>
        /// 物料GRN
        /// </summary>
        public String GRN
        {
            get { return this.gRN; }
            set { this.gRN = value; }
        }


        /// <summary>
        /// 物料描述
        /// </summary>
        public String ItemDesc
        {
            get { return this.itemDesc; }
            set { this.itemDesc = value; }
        }

        /// <summary>
        /// 物料标签模板Id
        /// </summary>
        public Int32 ZPLId
        {
            get { return this.zplId; }
            set { this.zplId = value; }
        }
    }
}
