using System;

namespace SKT.LeanMES.Labels.Model
{
    [Serializable]
    public class LabelFieldInfo
    {
        private Int32 fieldDfID;
        private String fieldDfName;
        private String fieldDfDesc;
        private String definition;
        public String Font { get; set; }
        public Boolean IsBold { get; set; }
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.LabelFieldDefInfo 类的新实例。
        /// </summary>
        public LabelFieldInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.BasalData.Model.LabelFieldDefInfo 类的新实例。
        /// </summary>
        /// <param name="fieldDfID"></param>
        /// <param name="fieldDfName"></param>
        /// <param name="fieldDfDesc"></param>
        /// <param name="definition"></param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        public LabelFieldInfo(Int32 fieldDfID, String fieldDfName, String fieldDfDesc, String definition,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime)
        {
            this.fieldDfID = fieldDfID;
            this.fieldDfName = fieldDfName;
            this.fieldDfDesc = fieldDfDesc;
            this.definition = definition;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 FieldDfID
        {
            get { return this.fieldDfID; }
            set { this.fieldDfID = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FieldDfName
        {
            get { return this.fieldDfName; }
            set { this.fieldDfName = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String FieldDfDesc
        {
            get { return this.fieldDfDesc; }
            set { this.fieldDfDesc = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Definition
        {
            get { return this.definition; }
            set { this.definition = value; }
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