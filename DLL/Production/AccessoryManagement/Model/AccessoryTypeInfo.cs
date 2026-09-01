using System;

namespace SKT.LeanMES.AccessoryManagement.Model
{
    [Serializable]
    public class AccessoryTypeInfo
    {
        private Int32 accessoryTypeId;
        private String accessoryTypeName;
        private Double thawTime;
        private Double leaveUnusedTime;
        private Double useTime;
        private String createBy;
        private DateTime createTime;


        private Double stirTime;
        private Double stirIdleTime;
        private Int32 stirQty;


        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryTypeInfo 类的新实例。
        /// </summary>
        public AccessoryTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccessoryManagement.Model.AccessoryTypeInfo 类的新实例。
        /// </summary>
        /// <param name="accessoryTypeId"></param>
        /// <param name="accessoryTypeName"></param>
        /// <param name="thawTime"></param>
        /// <param name="leaveUnusedTime"></param>
        /// <param name="useTime"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        public AccessoryTypeInfo(Int32 accessoryTypeId, String accessoryTypeName, Double thawTime, Double leaveUnusedTime,
            Double useTime, String createBy, DateTime createTime, Double stirTime, Double stirIdleTime,Int32 stirQty)
        {
            this.accessoryTypeId = accessoryTypeId;
            this.accessoryTypeName = accessoryTypeName;
            this.thawTime = thawTime;
            this.leaveUnusedTime = leaveUnusedTime;
            this.useTime = useTime;
            this.createBy = createBy;
            this.createTime = createTime;
            this.stirTime = stirTime;
            this.stirIdleTime = stirIdleTime;
            this.stirQty = stirQty;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AccessoryTypeId
        {
            get { return this.accessoryTypeId; }
            set { this.accessoryTypeId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AccessoryTypeName
        {
            get { return this.accessoryTypeName; }
            set { this.accessoryTypeName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double ThawTime
        {
            get { return this.thawTime; }
            set { this.thawTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double LeaveUnusedTime
        {
            get { return this.leaveUnusedTime; }
            set { this.leaveUnusedTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double UseTime
        {
            get { return this.useTime; }
            set { this.useTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double StirTime
        {
            get { return this.stirTime; }
            set { this.stirTime = value; }
        }


        /// <summary>
        /// 获取或设置
        /// </summary>
        public Double StirIdleTime
        {
            get { return this.stirIdleTime; }
            set { this.stirIdleTime = value; }
        }


        public Int32 StirQty {
            get { return this.stirQty; }
            set { this.stirQty = value; }
        }


        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy { get; set; }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime? ModifyTime { get; set; }

    }
}