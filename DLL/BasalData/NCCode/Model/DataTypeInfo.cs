using System;

namespace SKT.LeanMES.NCCode.Model
{
    [Serializable]
    public class DataTypeInfo
    {
        private Int32 dataTypeId;
        private String category;
        private String data_Type_Name;
        private String description;
        private String validation_Activity;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DataTypeInfo 类的新实例。
        /// </summary>
        public DataTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.DataTypeInfo 类的新实例。
        /// </summary>
        /// <param name="dataTypeId">编号ID</param>
        /// <param name="category">种类(Assembly,NC, Container, Pack SFC)</param>
        /// <param name="data_Type_Name">名称</param>
        /// <param name="description">描述</param>
        /// <param name="validation_Activity">验证行为</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public DataTypeInfo(Int32 dataTypeId, String category, String data_Type_Name, String description, 
            String validation_Activity, String remark, DateTime modifyDateTime, String modifyBy, DateTime createDateTime, 
            String createBy)
        {
            this.dataTypeId = dataTypeId;
            this.category = category;
            this.data_Type_Name = data_Type_Name;
            this.description = description;
            this.validation_Activity = validation_Activity;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置编号ID
        /// </summary>
        public Int32 DataTypeId
        {
            get { return this.dataTypeId; }
            set { this.dataTypeId = value; }
        }

        /// <summary>
        /// 获取或设置种类(Assembly,NC, Container, Pack SFC)
        /// </summary>
        public String Category
        {
            get { return this.category; }
            set { this.category = value; }
        }

        /// <summary>
        /// 获取或设置名称
        /// </summary>
        public String Data_Type_Name
        {
            get { return this.data_Type_Name; }
            set { this.data_Type_Name = value; }
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
        /// 获取或设置验证行为
        /// </summary>
        public String Validation_Activity
        {
            get { return this.validation_Activity; }
            set { this.validation_Activity = value; }
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