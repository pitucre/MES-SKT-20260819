using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ESOP.Model
{
    public class ESOPFileInfo
    {
        private Int32 esopFileId;
        private string esopFileName = string.Empty;
        private string esopFileUrl = string.Empty;
        private int itemId;
        //private int stationId;
        private string itemName = string.Empty;
        //private string station = string.Empty;
        private bool isCurrent = false;
        private string remark = string.Empty;
        private string createBy = string.Empty;
        private DateTime createDate = DateTime.MinValue;
        private string modifyBy = string.Empty;
        private DateTime modifyDate = DateTime.MinValue;
        private string isCurrent_CN = string.Empty;
        private bool isVideo = false;
        private string isVideo_CN = string.Empty;
        private int esopId = 0;
        private string fileType = string.Empty;
        private int sequence = 0;
        public int CutTime { get; set; }
        public string ItemSpec { get; set; }

        public ESOPFileInfo()
        {
        }


        public ESOPFileInfo(Int32 esopFileId, string esopFileName, string esopFileUrl, int itemId,
          string remark, bool isCurrent, string modifyBy, DateTime modifyDate, string createBy, DateTime createDate, string itemName, string isCurrent_CN, bool isVideo, string isVideo_CN, string fileType, int sequence, int esopId)
        {
            this.EsopFileId = esopFileId;
            this.EsopFileName = esopFileName;
            this.EsopFileUrl = esopFileUrl;
            this.ItemId = itemId;
            //this.stationId = stationId;
            this.IsCurrent = isCurrent;
            this.Remark = remark;
            this.CreateBy = createBy;
            this.CreateDate = createDate;
            this.ModifyBy = modifyBy;
            this.ModifyDate = modifyDate;
            this.ItemName = itemName;
            //this.station = station;
            this.IsCurrent_CN = isCurrent_CN;
            this.IsVideo = isVideo;
            this.IsVideo_CN = isVideo_CN;
            this.ESOPID = esopId;
            this.FileType = fileType;
            this.Sequence = sequence;
        }

        /// <summary>
        /// 文件Id，主键
        /// </summary>
        public Int32 EsopFileId
        {
            set { this.esopFileId = value; }
            get { return this.esopFileId; }
        }

        /// <summary>
        /// 文件名
        /// </summary>
        public string EsopFileName
        {
            set { this.esopFileName = value; }
            get { return this.esopFileName; }
        }

        /// <summary>
        /// 文件路径
        /// </summary>
        public string EsopFileUrl
        {
            set { this.esopFileUrl = value; }
            get { return this.esopFileUrl; }
        }
        /// <summary>
        /// 产品编号
        /// </summary>
        public string ItemName
        {
            set { this.itemName = value; }
            get { return this.itemName; }
        }

        /// <summary>
        /// 工位
        /// </summary>
        //public string Station
        //{
        //    set { this.station = value; }
        //    get { return this.station; }

        //}

        /// <summary>
        /// 是否当前版本
        /// </summary>
        public bool IsCurrent
        {
            set { this.isCurrent = value; }
            get { return this.isCurrent; }
        }

        /// <summary> 
        /// 备注
        /// </summary>
        public string Remark
        {
            set { this.remark = value; }
            get { return this.remark; }
        }
        /// <summary>
        /// 创建人 
        /// </summary>
        public string CreateBy
        {
            set { this.createBy = value; }
            get { return this.createBy; }
        }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime CreateDate
        {
            set { this.createDate = value; }
            get { return this.createDate; }
        }
        /// <summary>
        /// 修改人
        /// </summary>
        public string ModifyBy
        {
            set { this.modifyBy = value; }
            get { return this.modifyBy; }
        }

        /// <summary>
        /// 修改时间
        /// </summary>
        public DateTime ModifyDate
        {
            set { this.modifyDate = value; }
            get { return this.modifyDate; }
        }
        /// <summary>
        /// 产品Id
        /// </summary>
        public Int32 ItemId
        {
            set { this.itemId = value; }
            get { return this.itemId; }
        }

        /// <summary>
        /// 工位Id
        /// </summary>
        //public Int32 StationId
        //{
        //    set { this.stationId = value;}
        //    get { return this.stationId; }
        //}

        /// <summary>
        /// 是否是当前版本字符显示
        /// </summary>
        public string IsCurrent_CN
        {
            set { this.isCurrent_CN = value; }
            get { return this.isCurrent_CN; }
        }



        /// <summary>
        /// 是否是视频
        /// </summary>
        public bool IsVideo
        {
            set { this.isVideo = value; }
            get { return this.isVideo; }
        }

        /// <summary>
        /// 是否是视频(字符串)
        /// </summary>
        public string IsVideo_CN
        {
            set { this.isVideo_CN = value; }
            get { return this.isVideo_CN; }
        }

        public int ESOPID
        {
            set { this.esopId = value; }
            get { return this.esopId; }
        }

        public string FileType
        {
            set { this.fileType = value; }
            get { return this.fileType; }
        }

        public int Sequence
        {
            set { this.sequence = value; }
            get { return this.sequence; }
        }

    }
}
