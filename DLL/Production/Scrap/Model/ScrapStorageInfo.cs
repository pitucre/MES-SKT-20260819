using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.Scrap.Model
{
    /// <summary>
    /// 报废申请单明细表表实例类 add by zhi.li 2018-07-05
    /// </summary>
    [Serializable]
    public class ScrapStorageInfo
    {
        private Int32 scrapStorageId;
        private Int32 scrapId;
        private string scrapNo;
        private Int32 scrapDtlId;
        private String erpCode;
        private String itemCode;
        private Decimal scrapQty;
        private String serialNumber;
        private String barCodeIn;
        private String barCodeOut;
        private DateTime createDateTime;
        private String createBy;
        private String receiveUser;
        private DateTime receiveData;
        private String itemName;
        private String cName;
        private String whName;
        private Int32 statue;
        private String statueName;
        private String remark;
        private DateTime scrapDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Scrap.Model.ScrapStorageInfo 类的新实例。
        /// </summary>
        public ScrapStorageInfo()
        {
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="scrapStorageId"></param>
        /// <param name="scrapId"></param>
        /// <param name="scrapDtlId"></param>
        /// <param name="erpCode"></param>
        /// <param name="itemCode"></param>
        /// <param name="scrapQty"></param>
        /// <param name="serialNumber"></param>
        /// <param name="barCodeIn"></param>
        /// <param name="barCodeOut"></param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="receiveUser"></param>
        /// <param name="receiveData"></param>
        /// <param name="itemName"></param>
        /// <param name="cName"></param>
        /// <param name="inWhName"></param>
        /// <param name="outWhName"></param>
        /// <param name="statue"></param>
        /// <param name="statueName"></param>
        public ScrapStorageInfo(int scrapStorageId, int scrapId,string scrapNo, int scrapDtlId, string erpCode, string itemCode, decimal scrapQty, string serialNumber, string barCodeIn, string barCodeOut, DateTime createDateTime, string createBy, string receiveUser, DateTime receiveData, string itemName, string cName, string whName, int statue, string statueName)
        {
            this.scrapStorageId = scrapStorageId;
            this.scrapId = scrapId;
            this.scrapNo = scrapNo;
            this.scrapDtlId = scrapDtlId;
            this.erpCode = erpCode;
            this.itemCode = itemCode;
            this.scrapQty = scrapQty;
            this.serialNumber = serialNumber;
            this.barCodeIn = barCodeIn;
            this.barCodeOut = barCodeOut;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.receiveUser = receiveUser;
            this.receiveData = receiveData;
            this.itemName = itemName;
            this.cName = cName;
            this.whName = whName;
            this.statue = statue;
            this.statueName = statueName;
        }


        public int ScrapStorageId
        {
            get
            {
                return scrapStorageId;
            }

            set
            {
                scrapStorageId = value;
            }
        }

        public int ScrapId
        {
            get
            {
                return scrapId;
            }

            set
            {
                scrapId = value;
            }
        }

        public int ScrapDtlId
        {
            get
            {
                return scrapDtlId;
            }

            set
            {
                scrapDtlId = value;
            }
        }

        public string ErpCode
        {
            get
            {
                return erpCode;
            }

            set
            {
                erpCode = value;
            }
        }

        public string ItemCode
        {
            get
            {
                return itemCode;
            }

            set
            {
                itemCode = value;
            }
        }

        public decimal ScrapQty
        {
            get
            {
                return scrapQty;
            }

            set
            {
                scrapQty = value;
            }
        }

        public string SerialNumber
        {
            get
            {
                return serialNumber;
            }

            set
            {
                serialNumber = value;
            }
        }

        public string BarCodeIn
        {
            get
            {
                return barCodeIn;
            }

            set
            {
                barCodeIn = value;
            }
        }

        public string BarCodeOut
        {
            get
            {
                return barCodeOut;
            }

            set
            {
                barCodeOut = value;
            }
        }

        public DateTime CreateDateTime
        {
            get
            {
                return createDateTime;
            }

            set
            {
                createDateTime = value;
            }
        }

        public string CreateBy
        {
            get
            {
                return createBy;
            }

            set
            {
                createBy = value;
            }
        }

        public string ReceiveUser
        {
            get
            {
                return receiveUser;
            }

            set
            {
                receiveUser = value;
            }
        }

        public DateTime ReceiveData
        {
            get
            {
                return receiveData;
            }

            set
            {
                receiveData = value;
            }
        }

        public string ItemName
        {
            get
            {
                return itemName;
            }

            set
            {
                itemName = value;
            }
        }

        public string CName
        {
            get
            {
                return cName;
            }

            set
            {
                cName = value;
            }
        }

        public string WhName
        {
            get
            {
                return whName;
            }

            set
            {
                whName = value;
            }
        }

     

        public int Statue
        {
            get
            {
                return statue;
            }

            set
            {
                statue = value;
            }
        }

        public string StatueName
        {
            get
            {
                return statueName;
            }

            set
            {
                statueName = value;
            }
        }

        public string  ScrapNo
        {
            get
            {
                return scrapNo;
            }

            set
            {
                scrapNo = value;
            }
        }

        public string Remark
        {
            get
            {
                return remark;
            }

            set
            {
                remark = value;
            }
        }

        public DateTime ScrapDateTime
        {
            get
            {
                return scrapDateTime;
            }

            set
            {
                scrapDateTime = value;
            }
        }
    }

}
