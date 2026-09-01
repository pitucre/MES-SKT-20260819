using System;

namespace SKT.LeanMES.DictionaryData.Model
{
    [Serializable]
    public class DictionaryDataInfo
    {
        private Int32 dictionaryDataID;
        private String code;
        private String name;
        private String dicProperty;
        private String description;
        private String value;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Unit.Model.DictionaryDataInfo 类的新实例。
        /// </summary>
        public DictionaryDataInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Unit.Model.DictionaryDataInfo 类的新实例。
        /// </summary>
        /// <param name="dictionaryDataID">字典ID</param>
        /// <param name="code"></param>
        /// <param name="name">名称</param>
        /// <param name="dicProperty">属性(Unit:单位,Cause发生原因,Action解决措施,Attribute项目属性,DefectLocation缺点位置,Judgement判定结果,ProjectPurpose项目用途)</param>
        /// <param name="description">描述</param>
        /// <param name="value">取值</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">最后一次修改时间</param>
        /// <param name="modifyBy">最后修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public DictionaryDataInfo(Int32 dictionaryDataID, String name,
            String description, String value, String remark, DateTime modifyDateTime, String modifyBy, 
            DateTime createDateTime, String createBy)
        {
            this.dictionaryDataID = dictionaryDataID;
            this.name = name;
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
        public Int32 DictionaryDataID
        {
            get { return this.dictionaryDataID; }
            set { this.dictionaryDataID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Code
        {
            get { return this.code; }
            set { this.code = value; }
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
        /// 获取或设置属性(Unit:单位,Cause发生原因,Action解决措施,Attribute项目属性,DefectLocation缺点位置,Judgement判定结果,ProjectPurpose项目用途)
        /// </summary>
        public String DicProperty
        {
            get { return this.dicProperty; }
            set { this.dicProperty = value; }
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