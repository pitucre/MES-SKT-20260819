using System;

namespace SKT.LeanMES.ClientConfig.Model
{
    [Serializable]
    public class UsersInStationInfo
    {
        private Int32 usersInStationId;
        private Int32 userId;
        private Int32 stationId;
        private Int32 lineId;
        private Byte isDefault;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        public int ResId { get; set; }
        public string UserName { get; set; }
        public string Station { get; set; }
        public string LineName { get; set; }
        public string ResName { get; set; }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UsersInStationInfo 类的新实例。
        /// </summary>
        public UsersInStationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.UsersInStationInfo 类的新实例。
        /// </summary>
        /// <param name="usersInStationId"></param>
        /// <param name="userId">用户ID</param>
        /// <param name="stationId">工序ID</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="isDefault">是否默认工位，0：非默认 1：默认</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public UsersInStationInfo(Int32 usersInStationId, Int32 userId, Int32 stationId, Int32 lineId, 
            Byte isDefault, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.usersInStationId = usersInStationId;
            this.userId = userId;
            this.stationId = stationId;
            this.lineId = lineId;
            this.isDefault = isDefault;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 UsersInStationId
        {
            get { return this.usersInStationId; }
            set { this.usersInStationId = value; }
        }

        /// <summary>
        /// 获取或设置用户ID
        /// </summary>
        public Int32 UserId
        {
            get { return this.userId; }
            set { this.userId = value; }
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
        /// 获取或设置线别ID
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置是否默认工位，0：非默认 1：默认
        /// </summary>
        public Byte IsDefault
        {
            get { return this.isDefault; }
            set { this.isDefault = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}