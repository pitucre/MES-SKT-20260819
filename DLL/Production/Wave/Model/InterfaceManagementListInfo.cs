using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Wave.Model
{
    [Serializable]
    public class InterfaceManagementListInfo
    {

        private Int32 iD;
        private String deviceType;
        private String brandType;
        private String split;
        private String fileType;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;
        public string OKStr { get; set; }
        public string NGStr { get; set; }

        public InterfaceManagementListInfo()
        {
        }

        public InterfaceManagementListInfo(Int32 iD, String deviceType, String brandType, String split, String fileType, String createBy, DateTime createTime)
        {

            this.iD = iD;
            this.deviceType = deviceType;
            this.brandType = brandType;
            this.split = split;
            this.fileType = fileType;
            this.createBy = createBy;
            this.createTime = createTime;
        }


        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        public String DeviceType
        {
            get { return this.deviceType; }
            set { this.deviceType = value; }
        }
        public String BrandType
        {
            get { return this.brandType; }
            set { this.brandType = value; }
        }

        public String Split
        {
            get { return this.split; }
            set { this.split = value; }
        }

        public String FileType
        {
            get { return this.fileType; }
            set { this.fileType = value; }
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
