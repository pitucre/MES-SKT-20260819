using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class SerialNumberInfo
    {
        private Int32 serialNumberID;
        private String serialNumber_Source;
        private String next_Number_Type;
        private String apply_Type;
        private String type_Value;
        private String revision;
        private String prefix;
        private String suffix;
        private String remark;
        private DateTime createDateTime;
        private String createBy;
        private DateTime modifyDateTime;
        private String modifyBy;

        private String serialNumberType;
        private String sampleSerialNumber;
        private String description;
        //private bool isAccordOrderReset;

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.SerialNumberInfo 类的新实例。
        /// </summary>
        public SerialNumberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.SerialNumberInfo 类的新实例。
        /// </summary>
        /// <param name="serialNumberID">唯一编码ID</param>
        /// <param name="serialNumber_Source">产生序列号大类</param>
        /// <param name="next_Number_Type">产生序列号小类</param>
        /// <param name="apply_Type">对象类型</param>
        /// <param name="type_Value">产品或产品组</param>
        /// <param name="revision">版本</param>
        /// <param name="prefix">前缀</param>
        /// <param name="suffix">后缀</param>
        /// <param name="remark">备注</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        public SerialNumberInfo(Int32 serialNumberID, String serialNumber_Source, String next_Number_Type, String apply_Type,
            String type_Value, String revision, String prefix, String suffix, String remark, String sampleSerialNumber, 
            String description, DateTime createDateTime, String createBy, DateTime modifyDateTime, String modifyBy)
        {
            this.serialNumberID = serialNumberID;
            this.serialNumber_Source = serialNumber_Source;
            this.next_Number_Type = next_Number_Type;
            this.apply_Type = apply_Type;
            this.type_Value = type_Value;
            this.revision = revision;
            this.prefix = prefix;
            this.suffix = suffix;
            this.remark = remark;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.sampleSerialNumber = sampleSerialNumber;
            this.description = description;
        }

        /// <summary>
        /// 获取或设置唯一编码ID
        /// </summary>
        public Int32 SerialNumberID
        {
            get { return this.serialNumberID; }
            set { this.serialNumberID = value; }
        }

        /// <summary>
        /// 获取或设置产生序列号大类
        /// </summary>
        public String SerialNumber_Source
        {
            get { return this.serialNumber_Source; }
            set { this.serialNumber_Source = value; }
        }

        /// <summary>
        /// 获取或设置产生序列号小类
        /// </summary>
        public String Next_Number_Type
        {
            get { return this.next_Number_Type; }
            set { this.next_Number_Type = value; }
        }

        /// <summary>
        /// 获取或设置对象类型
        /// </summary>
        public String Apply_Type
        {
            get { return this.apply_Type; }
            set { this.apply_Type = value; }
        }

        /// <summary>
        /// 获取或设置产品或产品组
        /// </summary>
        public String Type_Value
        {
            get { return this.type_Value; }
            set { this.type_Value = value; }
        }

        /// <summary>
        /// 获取或设置版本
        /// </summary>
        public String Revision
        {
            get { return this.revision; }
            set { this.revision = value; }
        }

        /// <summary>
        /// 获取或设置前缀
        /// </summary>
        public String Prefix
        {
            get { return this.prefix; }
            set { this.prefix = value; }
        }

        /// <summary>
        /// 获取或设置后缀
        /// </summary>
        public String Suffix
        {
            get { return this.suffix; }
            set { this.suffix = value; }
        }

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置创建时间
        /// </summary>
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
        }

        /// <summary>
        /// 获取或设置创建者
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置分类类型
        /// </summary>
        public String SerialNumberType
        {
            get { return this.serialNumberType; }
            set { this.serialNumberType = value; }
        }

        /// <summary>
        /// 获取或设置序列号样例
        /// </summary>
        public String SampleSerialNumber
        {
            get { return this.sampleSerialNumber; }
            set { this.sampleSerialNumber = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }
    }
}