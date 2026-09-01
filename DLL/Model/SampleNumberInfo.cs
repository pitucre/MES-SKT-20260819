using System;


namespace SKT.LeanMES.SampleNumberManagement.Model
{
    [Serializable]
    public class SampleNumberInfo
    {
        private Int32 id;
        private String sampleNumber;
        private String sampleName;
        private Int32 maxUserCount;
        private Int32 usedCount;
        private String remark;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;
        private Int32 itemID;

        /// <summary>
        /// 初始化 SKT.MES.Model.LISTInfo 类的新实例。
        /// </summary>
        public SampleNumberInfo()
        {
        }
        public SampleNumberInfo(Int32 id, String sampleNumber, String sampleName, Int32 maxUserCount,
            Int32 usedCount, String remark, String createBy, DateTime createTime, String modifyBy,
            DateTime modifyTime, Int32 itemID)
        {
            this.id = id;
            this.sampleNumber = sampleNumber;
            this.sampleName = sampleName;
            this.maxUserCount = maxUserCount;
            this.usedCount = usedCount;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.itemID = itemID;
        }
        public Int32 Id
        {
            get { return this.id; }
            set { this.id = value; }
        }
        public String SampleNumber
        {
            get { return this.sampleNumber; }
            set { this.sampleNumber = value; }
        }
        public String SampleName
        {
            get { return this.sampleName; }
            set { this.sampleName = value; }
        }
        public Int32 MaxUserCount
        {
            get { return this.maxUserCount; }
            set { this.maxUserCount = value; }
        }
        public Int32 UsedCount
        {
            get { return this.usedCount; }
            set { this.usedCount = value; }
        }
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
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
        public Int32 ItemID
        {
            get { return this.itemID; }
            set { this.itemID = value; }
        }
        public String ItemCode { get; set; }
        public String ItemName { get; set; }
        public String ItemSpec { get; set; }
    }
}
