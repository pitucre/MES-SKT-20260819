using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.PackPrint.Model
{
   public class ListPrintHistoryInfo
    {
        private int printHistoryId;
        private int listingTypeId;
        private int itemId;
        private string opertor;
        private DateTime operDate = DateTime.MinValue;


        public ListPrintHistoryInfo()
        {
        }



        public ListPrintHistoryInfo(int printHistoryId, int listingTypeId, int itemId, string opertor,DateTime operDate )
        {
            this.printHistoryId = printHistoryId;
            this.listingTypeId = listingTypeId;
            this.itemId = itemId;
            this.opertor = opertor;
            this.operDate = operDate;
        }

     
        /// <summary>
        /// 主键
        /// </summary>
        public int PrintHistoryId
        {
            set { this.printHistoryId = value; }
            get { return this.printHistoryId; }
        }


        /// <summary>
        /// 清单类型
        /// </summary>
        public int ListingTypeId
        {
            set { this.listingTypeId = value; }
            get { return this.listingTypeId; }
        }

        /// <summary>
        /// 打印的itemId
        /// </summary>
        public int ItemId
        {
            set { this.itemId = value; }
            get { return this.itemId; }
        }

        /// <summary>
        /// 打印人
        /// </summary>
        public string Opertor
        {
            set { this.opertor = value; }
            get { return this.opertor; }
        }

        /// <summary>
        /// 打印人
        /// </summary>
        public DateTime OperDate
        {
            set { this.operDate = value; }
            get { return this.operDate; }
        }

    }
}
