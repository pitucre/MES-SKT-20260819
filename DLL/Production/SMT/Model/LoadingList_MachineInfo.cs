
using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class LoadingList_MACHINEInfo
    {
        private Int32 iD;
        private Int32 loadingListID;
        private Int32 machineID;
        private Byte statusID;
        private Boolean currentPanelSide;
        private Boolean isConsumeByQty;
        private String machineNo;
        private String statusStr;

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_MACHINEInfo 类的新实例。
        /// </summary>
        public LoadingList_MACHINEInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.LIST_MACHINEInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="loadingListID"></param>
        /// <param name="machineID"></param>
        /// <param name="statusID"></param>
        /// <param name="currentPanelSide"></param>
        /// <param name="isConsumeByQty"></param>
        /// <param name="machineNo"></param>
        public LoadingList_MACHINEInfo(Int32 iD, Int32 loadingListID, String machineNo, String statusStr)
        {
            this.iD = iD;
            this.loadingListID = loadingListID;
            this.statusStr = statusStr;
            this.machineNo = machineNo;
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
        public Int32 LoadingListID
        {
            get { return this.loadingListID; }
            set { this.loadingListID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MachineID
        {
            get { return this.machineID; }
            set { this.machineID = value; }
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
        public Boolean CurrentPanelSide
        {
            get { return this.currentPanelSide; }
            set { this.currentPanelSide = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Boolean IsConsumeByQty
        {
            get { return this.isConsumeByQty; }
            set { this.isConsumeByQty = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String MachineNo
        {
            get { return this.machineNo; }
            set { this.machineNo = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String StatusStr
        {
            get { return this.statusStr; }
            set { this.statusStr = value; }
        }
    }
}