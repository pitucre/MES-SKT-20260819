using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class SerialNumberTypeInfo
    {
        private Int32 serialNumberTypeId;
        private String serialNumberType;
        private String serialNumberDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SerialNumberTypeInfo 类的新实例。
        /// </summary>
        public SerialNumberTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.SerialNumberTypeInfo 类的新实例。
        /// </summary>
        /// <param name="serialNumberTypeId"></param>
        /// <param name="serialNumberType">序列号分类</param>
        /// <param name="serialNumberDesc">描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public SerialNumberTypeInfo(Int32 serialNumberTypeId, String serialNumberType, String serialNumberDesc, String createBy,
            DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.serialNumberTypeId = serialNumberTypeId;
            this.serialNumberType = serialNumberType;
            this.serialNumberDesc = serialNumberDesc;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 SerialNumberTypeId
        {
            get { return this.serialNumberTypeId; }
            set { this.serialNumberTypeId = value; }
        }

        /// <summary>
        /// 获取或设置序列号分类
        /// </summary>
        public String SerialNumberType
        {
            get { return this.serialNumberType; }
            set { this.serialNumberType = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String SerialNumberDesc
        {
            get { return this.serialNumberDesc; }
            set { this.serialNumberDesc = value; }
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
    }
}