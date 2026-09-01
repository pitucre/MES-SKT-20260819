using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Material.Model
{
    /// <summary>
    /// 获取订单信息以及相应物料收料信息
    /// Add  zhibin.Chen  2015-04-29
    /// </summary>
    public class MaterialReceiveInfo
    {
        private Int32 eRPOrderFormId;
        private String orderFormNO;
        private String arrivalFormNO;
        private String supplier;
        private String materialName;
        private Decimal qty;
        private Decimal receiveQty;
        private Decimal receivedQty;
        private String receivePerson;
        private Int32 iQCType;
        private Int32 autoIQCForm;
        private String batchNO;
        private String receiveDate;

        private String supplierCode;
        private String dateCode;
        private String mPN;
        private String invCode;

        private Decimal minPackQty;
        private Int32 autoId;


        public MaterialReceiveInfo()
        {
        }

        /// <summary>
        /// 构造实例
        /// </summary>
        /// <param name="eRPOrderFormId">ERP订单表</param>
        /// <param name="orderFormNO">订单号</param>
        /// <param name="supplier">供应商</param>
        /// <param name="materialName">物料</param>
        /// <param name="qty">订购数量</param>
        /// <param name="receiveQty">收入数量</param>
        /// <param name="receivedQty">已收数量</param>
        /// <param name="receivePerson">收料人</param>
        /// <param name="iQCType">IQC检验类型</param>
        /// <param name="autoIQCForm">是否自动生成IQC检验单</param>
        /// <param name="batchNO">批次号</param>
        /// <param name="receiveDate">收料日期</param>
        public MaterialReceiveInfo(Int32 eRPOrderFormId, String orderFormNO, String supplier, String materialName, Decimal qty, Decimal receiveQty,
            Decimal receivedQty, String receivePerson, Int32 iQCType, Int32 autoIQCForm, String batchNO, String receiveDate)
        {
            this.eRPOrderFormId = eRPOrderFormId;
            this.orderFormNO = orderFormNO;
            this.supplier = supplier;
            this.materialName = materialName;
            this.qty = qty;
            this.receiveQty = receiveQty;
            this.receivedQty = receivedQty;
            this.receivePerson = receivePerson;
            this.iQCType = iQCType;
            this.autoIQCForm = autoIQCForm;
            this.batchNO = batchNO;
            this.receiveDate = receiveDate;
        }

        /// <summary>
        /// ERP订单表Id
        /// </summary>
        public Int32 ERPOrderFormId
        {
            set { eRPOrderFormId = value; }
            get { return eRPOrderFormId; }
        }


        /// <summary>
        /// 订单号
        /// </summary>
        public String OrderFormNO
        {
            set { orderFormNO = value; }
            get { return orderFormNO; }
        }


        /// <summary>
        /// 到货单单号
        /// </summary>
        public String ArrivalFormNO
        {
            set { arrivalFormNO = value; }
            get { return arrivalFormNO; }
        }


        /// <summary>
        /// 供应商
        /// </summary>
        public String Supplier
        {
            set { supplier = value; }
            get { return supplier; }
        }

        /// <summary>
        /// 物料名称
        /// </summary>
        public String MaterialName
        {
            set { materialName = value; }
            get { return materialName; }
        }

        /// <summary>
        /// 订单订购总数量
        /// </summary>
        public Decimal Qty
        {
            set { qty = value; }
            get { return qty; }
        }

        /// <summary>
        /// 收入数量
        /// </summary>
        public Decimal ReceiveQty
        {
            set { receiveQty = value; }
            get { return receiveQty; }
        }

        /// <summary>
        /// 已收数量
        /// </summary>
        public Decimal ReceivedQty
        {
            set { receivedQty = value; }
            get { return receivedQty; }
        }

        /// <summary>
        /// 最小包装数量
        /// </summary>
        public Decimal MinPackQty
        {
            set { minPackQty = value; }
            get { return minPackQty; }
        }


        
        /// <summary>
        /// 收料人
        /// </summary>
        public String ReceivePerson
        {
            set { receivePerson = value; }
            get { return receivePerson; }
        }

        /// <summary>
        /// 抽检类型 1 全检   2 抽检   3 免检
        /// </summary>
        public Int32 IQCType
        {
            set { iQCType = value; }
            get { return iQCType; }
        }

        /// <summary>
        /// 是否自动生成IQC检验单  1 是  0 否
        /// </summary>
        public Int32 AutoIQCForm
        {
            set { autoIQCForm = value; }
            get { return autoIQCForm; }
        }

        /// <summary>
        /// 批次号
        /// </summary>
        public String BatchNO
        {
            set { batchNO = value; }
            get { return batchNO; }
        }

        /// <summary>
        /// 收料日期
        /// </summary>
        public String ReceiveDate
        {
            set { receiveDate = value; }
            get { return receiveDate; }
        }

        /// <summary>
        /// 供应商代码
        /// </summary>
        public String SupplierCode
        {
            set { supplierCode = value; }
            get { return supplierCode; }
        }

        /// <summary>
        /// 日期代码
        /// </summary>
        public String DateCode
        {
            set { dateCode = value; }
            get { return dateCode; }
        }

        /// <summary>
        /// MPN
        /// </summary>
        public String MPN
        {
            set { mPN = value; }
            get { return mPN; }
        }

        /// <summary>
        /// 物料编码
        /// </summary>
        public String InvCode
        {
            set { invCode = value; }
            get { return invCode; }
        }


        /// <summary>
        /// 到货单子表Id
        /// </summary>
        public Int32 AutoId
        {
            set { autoId = value; }
            get { return autoId; }
        }
    }
}
