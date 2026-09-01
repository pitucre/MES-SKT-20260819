using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class StationCertInfo
    {
        private Int32 stationCertId;
        private Int32 stationId;
        private Int32 certificationId;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationCertInfo 类的新实例。
        /// </summary>
        public StationCertInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.StationCertInfo 类的新实例。
        /// </summary>
        /// <param name="stationCertId"></param>
        /// <param name="stationId">操作工位ID</param>
        /// <param name="certificationId">认证资格ID</param>
        public StationCertInfo(Int32 stationCertId, Int32 stationId, Int32 certificationId)
        {
            this.stationCertId = stationCertId;
            this.stationId = stationId;
            this.certificationId = certificationId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationCertId
        {
            get { return this.stationCertId; }
            set { this.stationCertId = value; }
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
        /// 获取或设置认证资格ID
        /// </summary>
        public Int32 CertificationId
        {
            get { return this.certificationId; }
            set { this.certificationId = value; }
        }
    }
}