using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class StationTypeInfo
    {
        private Int32 stationTypeId;
        private String stationType;
        private String stationDesc;
        private Int32 tempId;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private String tempName;
        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationTypeInfo 类的新实例。
        /// </summary>
        public StationTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationTypeInfo 类的新实例。
        /// </summary>
        /// <param name="stationTypeId"></param>
        /// <param name="stationType">工位类型</param>
        /// <param name="stationDesc">描述</param>
        /// <param name="tempId"></param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">(getdate())</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public StationTypeInfo(Int32 stationTypeId, String stationType, String stationDesc, Int32 tempId, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.stationTypeId = stationTypeId;
            this.stationType = stationType;
            this.stationDesc = stationDesc;
            this.tempId = tempId;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationTypeId
        {
            get { return this.stationTypeId; }
            set { this.stationTypeId = value; }
        }

        /// <summary>
        /// 获取或设置工位类型
        /// </summary>
        public String StationType
        {
            get { return this.stationType; }
            set { this.stationType = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String StationDesc
        {
            get { return this.stationDesc; }
            set { this.stationDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 TempId
        {
            get { return this.tempId; }
            set { this.tempId = value; }
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
        /// 获取或设置(getdate())
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
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public String TempName
        {
            get { return this.tempName; }
            set { this.tempName = value; }
        }
    }
}