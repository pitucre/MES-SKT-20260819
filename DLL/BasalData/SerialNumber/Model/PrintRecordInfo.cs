using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class PrintRecordInfo
    {
        private Int32 recordId;
        public dynamic ActionType { get; set; }
        private Int32 printType;
        private String printKey;
        private Int32 stationId;
        private String station;

        private Int32 resourceId;
        private String resource;

        private String printUser;
        private DateTime printTime;

        public int ProdOrderId { get; set; }
        public dynamic OrderNo { get; set; }
        public dynamic OrderType { get; set; }
        public int ItemId { get; set; }
        public string ItemCode { get; set; }
        public string ItemName { get; set; }
        public string CustomerOrder { get; set; }
        public string SerialNumberType { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PrintRecordInfo 类的新实例。
        /// </summary>
        public PrintRecordInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.PrintRecordInfo 类的新实例。
        /// </summary>
        /// <param name="recordId"></param>
        /// <param name="actionType">打印方式(1:正常打 2：重打)</param>
        /// <param name="printType">打印类型：（1：工单 2：物料条码 3：包装条码 4：栈板条码）</param>
        /// <param name="printKey">打印标签</param>
        /// <param name="stationId">工序id</param>
        /// <param name="resourceId">资源id</param>
        /// <param name="printUser">打印人</param>
        /// <param name="printTime">打印时间</param>
        public PrintRecordInfo(Int32 recordId, dynamic actionType, Int32 printType, String printKey,
            Int32 stationId, Int32 resourceId, String printUser, DateTime printTime)
        {
            this.recordId = recordId;
            this.ActionType = actionType;
            this.printType = printType;
            this.printKey = printKey;
            this.stationId = stationId;
            this.resourceId = resourceId;
            this.printUser = printUser;
            this.printTime = printTime;
        }

        /// <summary>
        /// 获取或设置打印记录ID
        /// </summary>
        public Int32 RecordId
        {
            get { return this.recordId; }
            set { this.recordId = value; }
        }

        /// <summary>
        /// 获取或设置打印方式(1:正常打 2：重打)
        /// </summary>
        //public Int32 ActionType
        //{
        //    get { return this.actionType; }
        //    set { this.actionType = value; }
        //}

        /// <summary>
        /// 获取或设置打印类型：（1：工单 2：物料条码 3：包装条码 4：栈板条码）
        /// </summary>
        public Int32 PrintType
        {
            get { return this.printType; }
            set { this.printType = value; }
        }

        /// <summary>
        /// 获取或设置打印标签
        /// </summary>
        public String PrintKey
        {
            get { return this.printKey; }
            set { this.printKey = value; }
        }

        /// <summary>
        /// 获取或设置工序ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resourceId; }
            set { this.resourceId = value; }
        }

        /// <summary>
        /// 获取或设置打印人
        /// </summary>
        public String PrintUser
        {
            get { return this.printUser; }
            set { this.printUser = value; }
        }

        /// <summary>
        /// 获取或设置打印时间
        /// </summary>
        public DateTime PrintTime
        {
            get { return this.printTime; }
            set { this.printTime = value; }
        }

        /// <summary>
        /// 获取或设置工位
        /// </summary>
        public String Station
        {
            get { return this.station; }
            set { this.station = value; }
        }

        /// <summary>
        /// 获取或设置资源
        /// </summary>
        public String Resource
        {
            get { return this.resource; }
            set { this.resource = value; }
        }
    }
}
