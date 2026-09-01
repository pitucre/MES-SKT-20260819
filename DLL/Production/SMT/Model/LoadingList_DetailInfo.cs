using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable] 
    public class  LoadingList_DetailInfo 
    {
        private Int32 iD;
        private Int32 loadingListMachineID;
        private Int32 machineTableSlotID;
        private Int32 itemId;
        private Int32 topFrequency;
        private String topLocation;
        private Int32 bottomFrequency;
        private String bottomLocation;
        private Byte statusID;
        private Int32 feederTypeID;
        private String machineTableSlotNo;
        private String itemName;
        private String statusStr;

        private string itemCode;
        //add by weixia on 2016.5.3
        private String machineSN;
        private String tableSlotSN;
        private String feedTypeName;
        private Int32 loadingListID;
        private Int32 machineID;
        //private Int32 tableSlotID;

        public string LocationType { get; set; }
        public int LoadingListDetailId { get; set; }
        public int LoadingListId { get; set; }
        public string SetupName { get; set; }
        public string Position { get; set; }
        public string Point{get;set;}
        public string SmtNum { get; set; }
        public string SmtTable { get; set; }
        public string ReplaceNum { get; set; }
        public string FeederType { get; set; }
        public string Area { get; set; }
        public string ElementDescription { get; set; }
        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_DETAILInfo 类的新实例。
        /// </summary>
        public LoadingList_DetailInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_DETAILInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="loadingListMachineID"></param>
        /// <param name="machineTableSlotID"></param>
        /// <param name="itemId"></param>
        /// <param name="topFrequency"></param>
        /// <param name="topLocation"></param>
        /// <param name="bottomFrequency"></param>
        /// <param name="bottomLocation"></param>
        /// <param name="statusID"></param>
        /// <param name="feederTypeID"></param>
        public LoadingList_DetailInfo(Int32 iD, Int32 loadingListMachineID, Int32 machineTableSlotID, Int32 itemId, 
            Int32 topFrequency, String topLocation, Int32 bottomFrequency, String bottomLocation, Byte statusID, 
            Int32 feederTypeID)
        {
            this.iD = iD;
            this.loadingListMachineID = loadingListMachineID;
            this.machineTableSlotID = machineTableSlotID;
            this.itemId = itemId;
            this.topFrequency = topFrequency;
            this.topLocation = topLocation;
            this.bottomFrequency = bottomFrequency;
            this.bottomLocation = bottomLocation;
            this.statusID = statusID;
            this.feederTypeID = feederTypeID;
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_DETAILInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="loadingListMachineID"></param>
        /// <param name="machineTableSlotID"></param>
        /// <param name="itemId"></param>
        /// <param name="topFrequency"></param>
        /// <param name="topLocation"></param>
        /// <param name="bottomFrequency"></param>
        /// <param name="bottomLocation"></param>
        /// <param name="statusID"></param>
        /// <param name="feederTypeID"></param>
        public LoadingList_DetailInfo(Int32 iD, Int32 loadingListMachineID, Int32 machineTableSlotID, Int32 itemId,
            Int32 topFrequency, String topLocation, Int32 bottomFrequency, String bottomLocation, Byte statusID,
            Int32 feederTypeID,String machineTableSlotNo)
        {
            this.iD = iD;
            this.loadingListMachineID = loadingListMachineID;
            this.machineTableSlotID = machineTableSlotID;
            this.itemId = itemId;
            this.topFrequency = topFrequency;
            this.topLocation = topLocation;
            this.bottomFrequency = bottomFrequency;
            this.bottomLocation = bottomLocation;
            this.statusID = statusID;
            this.feederTypeID = feederTypeID;
            this.machineTableSlotNo = machineTableSlotNo;
        }


        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_DETAILInfo 类的新实例。 
        /// <param name="feederTypeID"></param>
        public LoadingList_DetailInfo(Int32 iD, String itemName, Int32 bottomFrequency, String bottomLocation, String statusStr, String machineTableSlotNo)
        {
            this.iD = iD;
            this.itemName = itemName;
            this.machineTableSlotNo = machineTableSlotNo;
            this.bottomFrequency = bottomFrequency;
            this.bottomLocation = bottomLocation;
            this.statusStr = statusStr;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 LoadingListMachineID
        {
            get { return this.loadingListMachineID; }
            set { this.loadingListMachineID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineTableSlotID
        {
            get { return this.machineTableSlotID; }
            set { this.machineTableSlotID = value; }
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
        public Int32 TopFrequency
        {
            get { return this.topFrequency; }
            set { this.topFrequency = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String TopLocation
        {
            get { return this.topLocation; }
            set { this.topLocation = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 BottomFrequency
        {
            get { return this.bottomFrequency; }
            set { this.bottomFrequency = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String BottomLocation
        {
            get { return this.bottomLocation; }
            set { this.bottomLocation = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Byte StatusID
        {
            get { return this.statusID; }
            set { this.statusID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FeederTypeID
        {
            get { return this.feederTypeID; }
            set { this.feederTypeID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineTableSlotNo
        {
            get { return this.machineTableSlotNo; }
            set { this.machineTableSlotNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }
        public Int32 TableSlotID
        {
            get { return this.machineID; }
            set { this.machineID = value; }
        }

        public Int32 MachineID
        {
            get { return this.machineID; }
            set { this.machineID = value; }
        }

        public Int32 LoadingListID
        {
            get { return this.loadingListID; }
            set { this.loadingListID = value; }
        }

        public String FeedTypeName
        {
            get { return this.feedTypeName; }
            set { this.feedTypeName = value; }
        }

        public String TableSlotSN
        {
            get { return this.tableSlotSN; }
            set { this.tableSlotSN = value; }
        }

        public String MachineSN
        {
            get { return this.machineSN; }
            set { this.machineSN = value; }
        }
        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }
    }
}