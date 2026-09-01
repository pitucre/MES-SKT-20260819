using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.ESOP.Model
{
    [Serializable]
    public class ESOPInfo
    {
        private int eSOPID;
        private int stationId;
        private string eSOPName;
        private string modifyBy;
        private DateTime modifyDate;
        private string createBy;
        private DateTime createDate;
        private string remark;
        private List<ESOPFileInfo> fileList;
        private List<ESOPFileItemRelation> fileItemList;
        public int cutTime;

        public ESOPInfo()
        {
        }

        public ESOPInfo(int eSOPID, int stationId, string eSOPName, string modifyBy, DateTime modifyDate, string createBy, DateTime CreateDate, string remark, int cutTime)
        {
            this.ESOPID = eSOPID;
            this.StationId = stationId;
            this.ESOPName = eSOPName;
            this.ModifyBy = modifyBy;
            this.ModifyDate = modifyDate;
            this.CreateBy = createBy;
            this.CreateDate = this.createDate;
            this.Remark = remark;
            this.CutTime = cutTime;
        }

        public List<ESOPFileItemRelation> FileItemList
        {
            get { return this.fileItemList; }
            set { this.fileItemList = value; }
        }

        public List<ESOPFileInfo> FileList
        {
            get { return this.fileList; }
            set { this.fileList = value; }
        }

        public int ESOPID
        {
            get { return this.eSOPID; }
            set { this.eSOPID = value; }
        }
        public int StationId
        {
            get { return this.stationId; }
            set { this.stationId = value; }
        }
        public string ESOPName
        {
            get { return this.eSOPName; }
            set { this.eSOPName = value; }
        }
        public string ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }
        public DateTime ModifyDate
        {
            get { return this.modifyDate; }
            set { this.modifyDate = value; }
        }
        public string CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }
        public DateTime CreateDate
        {
            get { return this.createDate; }
            set { this.createDate = value; }
        }
        public string Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public int CutTime
        {
            get { return this.cutTime; }
            set { this.cutTime = value; }
        }

    }
}
