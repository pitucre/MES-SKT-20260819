using System;

namespace SKT.LeanMES.ClientConfig.Model
{
    [Serializable]
    public class PopedomInStationInfo
    {
        private Int32 popedomInStationId;
        private Int32 stationId;
        private Int32 popedom;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 stationTypeId;

        /// <summary>
        /// 以下为扩展显示信息
        /// </summary>
        private string stationName;
        private string stationTypeName;
        private string popedomName;

        /// <summary>
        /// 初始化 SKT.LeanMES.ClientConfig.Model.PopedomInStationInfo 类的新实例。
        /// </summary>
        public PopedomInStationInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.ClientConfig.Model.PopedomInStationInfo 类的新实例。
        /// </summary>
        /// <param name="popedomInStationId">Id</param>
        /// <param name="stationId">站位Id</param>
        /// <param name="popedom">权限</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public PopedomInStationInfo(Int32 popedomInStationId, Int32 stationId, Int32 popedom, String createBy, 
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime,Int32 stationTypeId)
        {
            this.popedomInStationId = popedomInStationId;
            this.stationId = stationId;
            this.popedom = popedom;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.stationTypeId = stationTypeId;
        }

        /// <summary>
        /// 获取或设置Id
        /// </summary>
        public Int32 PopedomInStationId
        {
            get { return this.popedomInStationId; }
            set { this.popedomInStationId = value; }
        }

        /// <summary>
        /// 获取或设置站位Id
        /// </summary>
        public Int32 StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }

        /// <summary>
        /// 获取或设置权限
        /// </summary>
        public Int32 Popedom
        {
            get { return this.popedom; }
            set { this.popedom = value; }
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

        /// <summary>
        /// 获取或设置工序类型
        /// </summary>
        public Int32 StationTypeId
        {
            get { return this.stationTypeId; }
            set { this.stationTypeId = value; }
        }

        // 以下为扩展显示信息
        /// <summary>
        /// 获取或设置工序名称
        /// </summary>
        public string StationName
        {
            get { return this.stationName; }
            set { this.stationName = value; }
        }

        /// <summary>
        /// 获取或设置工序类型名称
        /// </summary>
        public string StationTypeName
        {
            get { return this.stationTypeName; }
            set { this.stationTypeName = value; }
        }

        /// <summary>
        /// 获取或设置page权限名称
        /// </summary>
        public string PopedomName 
        {
            get { return this.popedomName; }
            set { this.popedomName = value; }
        }
    }
}