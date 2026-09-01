using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Transfers.Model
{
    /// <summary>
    /// 调拨单主表实例类 add by zhi.li 2018-06-08
    /// </summary>
    [Serializable]
    public class TransfersStorageInfo
    {
        private Int32 transfersstorageid;
        private Int32 transfersid;
        private Int32 transfersdtlid;
        private String erpcode;
        private String itemcode;
        private Decimal transfersqty;
        private String serialnumber;
        private String barcodein;
        private String barcodeout;
        private String whcode;
        private String createby;
        private DateTime createdatetime;
        private Int32 receiveuser;
        private DateTime receivedata;


        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProdTransfersInfo 类的新实例。
        /// </summary>
        public TransfersStorageInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.ProdTransfersStorageInfo 类的新实例。
        /// </summary>
        /// <param name="transfersstorageid"></param>
        /// <param name="transfersid"></param>
        /// <param name="transfersdtlid"></param>
        /// <param name="erpcode"></param>
        /// <param name="itemcode"></param>
        /// <param name="transfersqty"></param>
        /// <param name="serialnumber"></param>
        /// <param name="barcodein"></param>
        /// <param name="barcodeout"></param>
        /// <param name="whcode"></param>
        /// <param name="createby"></param>
        /// <param name="createdatetime"></param>
        /// <param name="receiveuser"></param>
        /// <param name="receivedata"></param>
        public TransfersStorageInfo(int transfersstorageid, int transfersid, int transfersdtlid, string erpcode, string itemcode, 
            decimal transfersqty, string serialnumber, string barcodein, string barcodeout, string whcode, string createby, 
            DateTime createdatetime, int receiveuser, DateTime receivedata)
        {
            this.transfersstorageid = transfersstorageid;
            this.transfersid = transfersid;
            this.transfersdtlid = transfersdtlid;
            this.erpcode = erpcode;
            this.itemcode = itemcode;
            this.transfersqty = transfersqty;
            this.serialnumber = serialnumber;
            this.barcodein = barcodein;
            this.barcodeout = barcodeout;
            this.whcode = whcode;
            this.createby = createby;
            this.createdatetime = createdatetime;
            this.receiveuser = receiveuser;
            this.receivedata = receivedata;
        }

        public int Transfersstorageid
        {
            get
            {
                return transfersstorageid;
            }

            set
            {
                transfersstorageid = value;
            }
        }

        public int Transfersid
        {
            get
            {
                return transfersid;
            }

            set
            {
                transfersid = value;
            }
        }

        public int Transfersdtlid
        {
            get
            {
                return transfersdtlid;
            }

            set
            {
                transfersdtlid = value;
            }
        }

        public string Erpcode
        {
            get
            {
                return erpcode;
            }

            set
            {
                erpcode = value;
            }
        }

        public string Itemcode
        {
            get
            {
                return itemcode;
            }

            set
            {
                itemcode = value;
            }
        }

        public decimal Transfersqty
        {
            get
            {
                return transfersqty;
            }

            set
            {
                transfersqty = value;
            }
        }

        public string Serialnumber
        {
            get
            {
                return serialnumber;
            }

            set
            {
                serialnumber = value;
            }
        }

        public string Barcodein
        {
            get
            {
                return barcodein;
            }

            set
            {
                barcodein = value;
            }
        }

        public string Barcodeout
        {
            get
            {
                return barcodeout;
            }

            set
            {
                barcodeout = value;
            }
        }

        public string Whcode
        {
            get
            {
                return whcode;
            }

            set
            {
                whcode = value;
            }
        }

        public string Createby
        {
            get
            {
                return createby;
            }

            set
            {
                createby = value;
            }
        }

        public DateTime Createdatetime
        {
            get
            {
                return createdatetime;
            }

            set
            {
                createdatetime = value;
            }
        }

        public int Receiveuser
        {
            get
            {
                return receiveuser;
            }

            set
            {
                receiveuser = value;
            }
        }

        public DateTime Receivedata
        {
            get
            {
                return receivedata;
            }

            set
            {
                receivedata = value;
            }
        }
    }
}
