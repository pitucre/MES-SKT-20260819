using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.SDP.Model
{
    public class RouteDetail
    {
        private Int32 _rd_Id;
        private Int32 _rId;
        private string _rName;
        private Int32 _stationId;
        private String _rDescription;
        private String _station;
        private String _stationDesc;
        private Int32? _tmplId;
        private Int32? _modelId;
        private string stationType;

        public RouteDetail() { }

        public RouteDetail(int rd_Id, int r_ID, int stationId, string R_Name, string R_Description,
            string Station, string StationDesc, int TmplID, int? ModelId)
        {
            this._rd_Id = rd_Id;
            this._rId = r_ID;
            this._stationId = stationId;
            this._rName = R_Name;
            this._rDescription = R_Description;
            this._station = Station;
            this._stationDesc = StationDesc;
            this._tmplId = TmplID;
            this._modelId = ModelId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 RD_Id
        {
            get { return this._rd_Id; }
            set { this._rd_Id = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 R_Id
        {
            get { return this._rId; }
            set { this._rId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StationId
        {
            get { return this._stationId; }
            set { this._stationId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string R_Name
        {
            get { return this._rName; }
            set { this._rName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public string R_Description
        {
            get { return this._rDescription; }
            set { this._rDescription = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public string Station
        {
            get { return this._station; }
            set { this._station = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public string StationDesc
        {
            get { return this._stationDesc; }
            set { this._stationDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public int? TmpId
        {
            get { return this._tmplId; }
            set { this._tmplId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public int? ModelId
        {
            get { return this._modelId; }
            set { this._modelId = value; }
        }

        public string StationType
        {
            get { return this.stationType; }
            set { this.stationType = value; }
        }
    }
}
