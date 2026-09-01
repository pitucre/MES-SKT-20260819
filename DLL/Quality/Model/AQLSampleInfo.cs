using System;

namespace SKT.LeanMES.Quality.Model
{
    [Serializable]
    public class AQLSampleInfo
    {
        private Int32 aQLSampleId;
        private String aQLSampleName;
        private double aQLSampleValue;
        private String aQLSampleDescription;
        private String createrBy;
        private String modifyBy;
        private DateTime createDate;
        private DateTime modifyDate;

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLSampleInfo 类的新实例。
        /// </summary>
        public AQLSampleInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.AQLSampleInfo 类的新实例。
        /// </summary>
        /// <param name="aQLSampleId"></param>
        /// <param name="aQLSampleName"></param>
        /// <param name="aQLSampleValue"></param>
        /// <param name="aQLSampleDescription"></param>
        /// <param name="createrBy"></param>
        /// <param name="modifyBy"></param>
        /// <param name="createDate"></param>
        /// <param name="modifyDate"></param>
        public AQLSampleInfo(Int32 aQLSampleId, String aQLSampleName, double aQLSampleValue, String aQLSampleDescription, 
            String createrBy, String modifyBy, DateTime createDate, DateTime modifyDate)
        {
            this.aQLSampleId = aQLSampleId;
            this.aQLSampleName = aQLSampleName;
            this.aQLSampleValue = aQLSampleValue;
            this.aQLSampleDescription = aQLSampleDescription;
            this.createrBy = createrBy;
            this.modifyBy = modifyBy;
            this.createDate = createDate;
            this.modifyDate = modifyDate;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AQLSampleId
        {
            get { return this.aQLSampleId; }
            set { this.aQLSampleId = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AQLSampleName
        {
            get { return this.aQLSampleName; }
            set { this.aQLSampleName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public double AQLSampleValue
        {
            get { return this.aQLSampleValue; }
            set { this.aQLSampleValue = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String AQLSampleDescription
        {
            get { return this.aQLSampleDescription; }
            set { this.aQLSampleDescription = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String CreaterBy
        {
            get { return this.createrBy; }
            set { this.createrBy = value; }
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
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }
    }
}