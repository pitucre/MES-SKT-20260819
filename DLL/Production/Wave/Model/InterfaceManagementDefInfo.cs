using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.Model
{
    [Serializable]
    public class InterfaceManagementDefInfo
    {

        private Int32 iD;
        private Int32 interfaceManagementId;
        private Int32 segment;
        private Int32 rows;
        private String contents;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;

        public InterfaceManagementDefInfo()
        {
        }

        public InterfaceManagementDefInfo(Int32 iD, Int32 interfaceManagementId, Int32 rows, Int32 segment, String contents, String createBy, DateTime createTime)
        {

            this.iD = iD;
            this.interfaceManagementId = interfaceManagementId;
            this.rows = rows;
            this.segment = segment;
            this.contents = contents;
            this.createBy = createBy;
            this.createTime = createTime;
        }


        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        public Int32 InterfaceManagementId
        {
            get { return this.interfaceManagementId; }
            set { this.interfaceManagementId = value; }
        }
        public Int32 Rows
        {
            get { return this.rows; }
            set { this.rows = value; }
        }

        public Int32 Segment
        {
            get { return this.segment; }
            set { this.segment = value; }
        }
        public String Contents
        {
            get { return this.contents; }
            set { this.contents = value; }
        }


        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
        }
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }
    }
}
