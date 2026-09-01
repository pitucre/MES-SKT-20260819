using System;

namespace SKT.LeanMES.SerialNumber.Model
{
    [Serializable]
    public class DictionaryInfo
    {
        private Int32 dictionaryDataId;
        private String name;
        private String property;
        private String description;
        private String value;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        public string Code { get; set; }
        public string FNType { get; set; }

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.DictionaryInfo 类的新实例。
        /// </summary>
        public DictionaryInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.SerialNumber.Model.DictionaryInfo 类的新实例。
        /// </summary>
        /// <param name="dictionaryDataId">字典ID</param>
        /// <param name="name">名称</param>
        /// <param name="property">属性</param>
        /// <param name="description">描述</param>
        /// <param name="value">取值</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">最后一次修改时间</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public DictionaryInfo(Int32 dictionaryDataId, String name, String property, String description, 
            String value, String remark, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, 
            String createBy)
        {
            this.dictionaryDataId = dictionaryDataId;
            this.name = name;
            this.property = property;
            this.description = description;
            this.value = value;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置字典ID
        /// </summary>
        public Int32 DictionaryDataId
        {
            get { return this.dictionaryDataId; }
            set { this.dictionaryDataId = value; }
        }

        /// <summary>
        /// 获取或设置名称
        /// </summary>
        public String Name
        {
            get { return this.name; }
            set { this.name = value; }
        }

        /// <summary>
        /// 获取或设置属性
        /// </summary>
        public String Property
        {
            get { return this.property; }
            set { this.property = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Description
        {
            get { return this.description; }
            set { this.description = value; }
        }

        /// <summary>
        /// 获取或设置取值
        /// </summary>
        public String Value
        {
            get { return this.value; }
            set { this.value = value; }
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
        /// 获取或设置最后一次修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置最后修改者
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
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
    }
}