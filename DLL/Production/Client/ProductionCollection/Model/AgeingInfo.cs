using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ProductionCollection.Model
{
    public class AgeingInfo
    {
        public int AgeingType { get; set; }
        public decimal AgeingTime { get; set; }
        public string ItemCode { get; set; }

        public string BadCode { get; set; }




        private Int32 id;
        private Int32 orderId;
        private String orderNo;
        private String itemCode;
        private Int32 itemId;
        private Int32 status;
        private String sN;
        private String ageingRack;
        private Int32 startLineId;
        private Int32 startStationId;
        private Int32 startResourceId;
        private DateTime startTime;
        private String startUser;
        private Int32 endLineId;
        private Int32 endStationId;
        private Int32 endResourceId;
        private DateTime endTime;
        private String endUser;
        private String creteBy;
        private DateTime createTime;
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 OrderId
        {
            get { return this.orderId; }
            set { this.orderId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String OrderNo
        {
            get { return this.orderNo; }
            set { this.orderNo = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 Status
        {
            get { return this.status; }
            set { this.status = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SN
        {
            get { return this.sN; }
            set { this.sN = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AgeingRack
        {
            get { return this.ageingRack; }
            set { this.ageingRack = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StartLineId
        {
            get { return this.startLineId; }
            set { this.startLineId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StartStationId
        {
            get { return this.startStationId; }
            set { this.startStationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StartResourceId
        {
            get { return this.startResourceId; }
            set { this.startResourceId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime StartTime
        {
            get { return this.startTime; }
            set { this.startTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StartUser
        {
            get { return this.startUser; }
            set { this.startUser = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EndLineId
        {
            get { return this.endLineId; }
            set { this.endLineId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EndStationId
        {
            get { return this.endStationId; }
            set { this.endStationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 EndResourceId
        {
            get { return this.endResourceId; }
            set { this.endResourceId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime EndTime
        {
            get { return this.endTime; }
            set { this.endTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String EndUser
        {
            get { return this.endUser; }
            set { this.endUser = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreteBy
        {
            get { return this.creteBy; }
            set { this.creteBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
    }

}

