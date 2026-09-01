using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.MobileMat.Model
{
    public class MaterialInfo
    {
        private Int64 materialUnitId;
        private String serialNumber;
        private Decimal balanceQty;
        private String storageDate;

        private Int32 count;
        public Int32 Count
        {
            get { return count; }
            set { count = value; }
        }

        public MaterialInfo() { }

        /// <summary>
        /// 构造
        /// </summary>
        /// <param name="materialUnitId">自增</param>
        /// <param name="serialNumber">SN</param>
        /// <param name="balanceQty">数量</param>
        /// <param name="storageDate">入库日期</param>
        public MaterialInfo(Int64 materialUnitId, String serialNumber, Decimal balanceQty, String storageDate)
        {
            this.materialUnitId = materialUnitId;
            this.serialNumber = serialNumber;
            this.balanceQty = balanceQty;
            this.storageDate = storageDate;
        }

        /// <summary>
        /// 自增
        /// </summary>
        public Int64 MaterialUnitId
        {
            get { return materialUnitId; }
            set { materialUnitId = value; }
        }

        /// <summary>
        /// SN
        /// </summary>
        public String SerialNumber
        {
            get { return serialNumber; }
            set { serialNumber = value; }
        }

        /// <summary>
        /// 数量
        /// </summary>
        public Decimal BalanceQty
        {
            get { return balanceQty; }
            set { balanceQty = value; }
        }

        /// <summary>
        /// 入库日期
        /// </summary>
        public String StorageDate
        {
            get { return storageDate; }
            set { storageDate = value; }
        }
    }
}
