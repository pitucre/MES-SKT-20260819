
using System;

namespace SKT.LeanMES.SMT.Model
{
    [Serializable]
    public class FeederInfo
    {
        private Int32 iD;
        private String serialNumber;
        private String description;
        private Int32 feederTypeID;
        private String feederType;
        private Int32 pickUp;
        private Int32 accumulatedErrPickUp;
        private Int32 accumulatedPickUp;
        private DateTime startUseTime;
        private DateTime lastUnuseTime;
        private Int32 maxReel;
        private Int32 stationID;
        private Int32 userID;
        private String user;
        private DateTime creationTime;
        private DateTime lastUpdate;
        private Int32 statusID;
        private String status;
        private Int32 machineModelID;
        private String modelName;
        private Int32 maxUseDuration;
        private Int32 maxUnuseDuration;
        private Int32 maxPickUp;
        private Int32 maxPickUpErr;
        private Int32 pickUpErrRatio;
        private Int32 feederCategoryID;
        private String feederCategory;
        private Int32 needMaintenance;

        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERInfo 类的新实例。
        /// </summary>
        public FeederInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.SMT.Model.FEEDERInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="serialNumber">序列号</param>
        /// <param name="description">描述</param>
        /// <param name="feederTypeID">类型ID</param>
        /// <param name="pickUp">使用次数，保养后清0</param>
        /// <param name="accumulatedErrPickUp">发生错误累加次数</param>
        /// <param name="accumulatedPickUp">使用的累加次数</param>
        /// <param name="startUseTime">开始使用时间</param>
        /// <param name="lastUnuseTime">最后一次使用时间</param>
        /// <param name="maxReel">最大料盘数</param>
        /// <param name="stationID"></param>
        /// <param name="userID">创建者ID</param>
        /// <param name="creationTime">创建时间</param>
        /// <param name="lastUpdate">最后更新时间</param>
        /// <param name="statusID">状态</param>
        /// <param name="machineModelID">机器ID</param>
        /// <param name="maxUseDuration">最大使用天数</param>
        /// <param name="maxUnuseDuration">最大未使用天数</param>
        /// <param name="maxPickUp">最大使用次数</param>
        /// <param name="maxPickUpErr">最大使用错误数</param>
        /// <param name="pickUpErrRatio">使用错误率</param>
        /// <param name="feederCategoryID">使用机型</param>
        /// <param name="needMaintenance">需要保养的天数</param>
        public FeederInfo(Int32 iD, String serialNumber, String description, Int32 feederTypeID, 
            Int32 pickUp, Int32 accumulatedErrPickUp, Int32 accumulatedPickUp, DateTime startUseTime, DateTime lastUnuseTime, 
            Int32 maxReel, Int32 stationID, Int32 userID, DateTime creationTime, DateTime lastUpdate, 
            Int32 statusID, Int32 machineModelID, Int32 maxUseDuration, Int32 maxUnuseDuration, Int32 maxPickUp, 
            Int32 maxPickUpErr, Int32 pickUpErrRatio, Int32 feederCategoryID, Int32 needMaintenance)
        {
            this.iD = iD;
            this.serialNumber = serialNumber;
            this.description = description;
            this.feederTypeID = feederTypeID;
            this.pickUp = pickUp;
            this.accumulatedErrPickUp = accumulatedErrPickUp;
            this.accumulatedPickUp = accumulatedPickUp;
            this.startUseTime = startUseTime;
            this.lastUnuseTime = lastUnuseTime;
            this.maxReel = maxReel;
            this.stationID = stationID;
            this.userID = userID;
            this.creationTime = creationTime;
            this.lastUpdate = lastUpdate;
            this.statusID = statusID;
            this.machineModelID = machineModelID;
            this.maxUseDuration = maxUseDuration;
            this.maxUnuseDuration = maxUnuseDuration;
            this.maxPickUp = maxPickUp;
            this.maxPickUpErr = maxPickUpErr;
            this.pickUpErrRatio = pickUpErrRatio;
            this.feederCategoryID = feederCategoryID;
            this.needMaintenance = needMaintenance;
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
        /// 获取或设置序列号
        /// </summary>
        public String SerialNumber
        {
            get { return this.serialNumber; }
            set { this.serialNumber = value; }
        }

        /// <summary>
        /// 获取或设置机器名称
        /// </summary>
        public String ModelName
        {
            get { return this.modelName; }
            set { this.modelName = value; }
        }

        /// <summary>
        /// 获取或设置类型名称
        /// </summary>
        public String FeederType
        {
            get { return this.feederType; }
            set { this.feederType = value; }
        }


        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String User
        {
            get { return this.user; }
            set { this.user = value; }
        }


        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public String Status
        {
            get { return this.status; }
            set { this.status = value; }
        }


        /// <summary>
        /// 获取或设置机器类型
        /// </summary>
        public String FeederCategory
        {
            get { return this.feederCategory; }
            set { this.feederCategory = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
        /// <summary>
        /// 获取或设置类型ID
        /// </summary>
        public Int32 FeederTypeID
        {
            get { return this.feederTypeID; }
            set { this.feederTypeID = value; }
        }

        /// <summary>
        /// 获取或设置使用次数，保养后清0
        /// </summary>
        public Int32 PickUp
        {
            get { return this.pickUp; }
            set { this.pickUp = value; }
        }

        /// <summary>
        /// 获取或设置发生错误累加次数
        /// </summary>
        public Int32 AccumulatedErrPickUp
        {
            get { return this.accumulatedErrPickUp; }
            set { this.accumulatedErrPickUp = value; }
        }

        /// <summary>
        /// 获取或设置使用的累加次数
        /// </summary>
        public Int32 AccumulatedPickUp
        {
            get { return this.accumulatedPickUp; }
            set { this.accumulatedPickUp = value; }
        }

        /// <summary>
        /// 获取或设置开始使用时间
        /// </summary>
        public DateTime StartUseTime
        {
            get { return this.startUseTime; }
            set { this.startUseTime = value; }
        }

        /// <summary>
        /// 获取或设置最后一次使用时间
        /// </summary>
        public DateTime LastUnuseTime
        {
            get { return this.lastUnuseTime; }
            set { this.lastUnuseTime = value; }
        }

        /// <summary>
        /// 获取或设置最大料盘数
        /// </summary>
        public Int32 MaxReel
        {
            get { return this.maxReel; }
            set { this.maxReel = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationID
        {
            get { return this.stationID; }
            set { this.stationID = value; }
        }

        /// <summary>
        /// 获取或设置创建者ID
        /// </summary>
        public Int32 UserID
        {
            get { return this.userID; }
            set { this.userID = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreationTime
        {
            get { return this.creationTime; }
            set { this.creationTime = value; }
        }

        /// <summary>
        /// 获取或设置最后更新时间
        /// </summary>
        public DateTime LastUpdate
        {
            get { return this.lastUpdate; }
            set { this.lastUpdate = value; }
        }

        /// <summary>
        /// 获取或设置状态
        /// </summary>
        public Int32 StatusID
        {
            get { return this.statusID; }
            set { this.statusID = value; }
        }

        /// <summary>
        /// 获取或设置机器ID
        /// </summary>
        public Int32 MachineModelID
        {
            get { return this.machineModelID; }
            set { this.machineModelID = value; }
        }

        /// <summary>
        /// 获取或设置最大使用天数
        /// </summary>
        public Int32 MaxUseDuration
        {
            get { return this.maxUseDuration; }
            set { this.maxUseDuration = value; }
        }

        /// <summary>
        /// 获取或设置最大未使用天数
        /// </summary>
        public Int32 MaxUnuseDuration
        {
            get { return this.maxUnuseDuration; }
            set { this.maxUnuseDuration = value; }
        }

        /// <summary>
        /// 获取或设置最大使用次数
        /// </summary>
        public Int32 MaxPickUp
        {
            get { return this.maxPickUp; }
            set { this.maxPickUp = value; }
        }

        /// <summary>
        /// 获取或设置最大使用错误数
        /// </summary>
        public Int32 MaxPickUpErr
        {
            get { return this.maxPickUpErr; }
            set { this.maxPickUpErr = value; }
        }

        /// <summary>
        /// 获取或设置使用错误率
        /// </summary>
        public Int32 PickUpErrRatio
        {
            get { return this.pickUpErrRatio; }
            set { this.pickUpErrRatio = value; }
        }

        /// <summary>
        /// 获取或设置使用机型
        /// </summary>
        public Int32 FeederCategoryID
        {
            get { return this.feederCategoryID; }
            set { this.feederCategoryID = value; }
        }

        /// <summary>
        /// 获取或设置需要保养的天数
        /// </summary>
        public Int32 NeedMaintenance
        {
            get { return this.needMaintenance; }
            set { this.needMaintenance = value; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }
        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime{ get; set; }
    }
}