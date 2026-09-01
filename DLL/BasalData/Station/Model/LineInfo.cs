using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class LineInfo
    {
        private Int32 lineId;
        private String lineName;
        private String lineDescription;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.LineInfo 类的新实例。
        /// </summary>
        public LineInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.LineInfo 类的新实例。
        /// </summary>
        /// <param name="lineId">Unique Identifier</param>
        /// <param name="lineName">线名</param>
        /// <param name="lineDescription">线描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public LineInfo(Int32 lineId, String lineName, String lineDescription, String createBy, 
             String modifyBy, String remark)
        {
            this.lineId = lineId;
            this.lineName = lineName;
            this.lineDescription = lineDescription;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 LineId
        {
            get { return this.lineId; }
            set { this.lineId = value; }
        }

        /// <summary>
        /// 获取或设置线名
        /// </summary>
        public String LineName
        {
            get { return this.lineName; }
            set { this.lineName = value; }
        }

        /// <summary>
        /// 获取或设置线描述
        /// </summary>
        public String LineDescription
        {
            get { return this.lineDescription; }
            set { this.lineDescription = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
    }
}