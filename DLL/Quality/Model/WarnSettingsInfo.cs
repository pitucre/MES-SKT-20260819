using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class WarnSettingsInfo
    {
        private Int32 warnSettingsId;
        private Int32 itemId;
        private Int32 lineId;
        private Int32 stationId;
        private Byte warnType;
        private Byte warnLevel;
        private Decimal yield;
        private String reciveUsers;
        private String reciveUsersId;
        private String contents;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        private String lineName;
        private String itemName;
        private String stationName;
      
        /// <summary>
        /// 初始化 SKT.LeanMES.Quality.Model.WarnSettingsInfo 类的新实例。
        /// </summary>
        public WarnSettingsInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Quality.Model.WarnSettingsInfo 类的新实例。
        /// </summary>
        /// <param name="warnSettingsId"></param>
        /// <param name="itemId">产品ID</param>
        /// <param name="lineId">线别ID</param>
        /// <param name="stationId">操作工位ID</param>
        /// <param name="warnType">预警类型（1：班次  2：天）</param>
        /// <param name="warnLevel">预警级别（1,2,3）</param>
        /// <param name="yield">良品率</param>
        /// <param name="reciveUsers">预警通知接收用户id字符串(如：1,2,3)</param>
        /// <param name="contents">通知内容</param>
        /// <param name="createDateTime"></param>
        /// <param name="createBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="modifyBy"></param>
        public WarnSettingsInfo(Int32 warnSettingsId, Int32 itemId, Int32 lineId, Int32 stationId, 
            Byte warnType, Byte warnLevel, Decimal yield, String reciveUsers, String contents, 
            DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy)
        {
            this.warnSettingsId = warnSettingsId;
            this.itemId = itemId;
            this.lineId = lineId;
            this.stationId = stationId;
            this.warnType = warnType;
            this.warnLevel = warnLevel;
            this.yield = yield;
            this.reciveUsers = reciveUsers;
            this.contents = contents;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 WarnSettingsId
        {
            get { return this.warnSettingsId; }
            set { this.warnSettingsId = value; }
        }

        /// <summary>
        /// 获取或设置产品ID
        /// </summary>
        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
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
        /// 获取或设置操作工位ID
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置预警类型（1：班次  2：天）
        /// </summary>
        public Byte WarnType
        {
            get { return this.warnType; }
            set { this.warnType = value; }
        }

        /// <summary>
        /// 获取或设置预警级别（1,2,3）
        /// </summary>
        public Byte WarnLevel
        {
            get { return this.warnLevel; }
            set { this.warnLevel = value; }
        }

        /// <summary>
        /// 获取或设置良品率
        /// </summary>
        public Decimal Yield
        {
            get { return this.yield; }
            set { this.yield = value; }
        }

        /// <summary>
        /// 获取或设置预警通知接收用户名字符串
        /// </summary>
        public String ReciveUsers
        {
            get { return this.reciveUsers; }
            set { this.reciveUsers = value; }
        }

        /// <summary>
        /// 获取或设置预警通知接收用户id字符串(如：1,2,3)
        /// </summary>
        public String ReciveUsersId
        {
            get { return this.reciveUsersId; }
            set { this.reciveUsersId = value; }
        }
        

        /// <summary>
        /// 获取或设置通知内容
        /// </summary>
        public String Contents
        {
            get { return this.contents; }
            set { this.contents = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String LineName {
            get { return this.lineName; }
            set { this.lineName = value; }
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
        public String StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }
    }
}