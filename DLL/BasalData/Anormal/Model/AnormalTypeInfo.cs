using System;

namespace SKT.LeanMES.Anormal.Model
{
    [Serializable]
    public class AnormalTypeInfo
    {
        private Int32 anormalTypeId;
        private String anormalTypeCode;
        private String anormalTypeName;
        private String descriptions;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Int32 anormalGroupId;
        private String anormalGroupName;
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_SubTypeInfo 类的新实例。
        /// </summary>
        public AnormalTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_SubTypeInfo 类的新实例。
        /// </summary>
        /// <param name="anormalTypeId"></param>
        /// <param name="anormalTypeCode">子类编码</param>
        /// <param name="anormalTypeName">异常子类型名称</param>
        /// <param name="descriptions">描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="typeId">类型分组id
        ///</param>
        public AnormalTypeInfo(Int32 anormalTypeId, String anormalTypeCode, String anormalTypeName, String descriptions, 
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark,
            Int32 anormalGroupId)
        {
            this.anormalTypeId = anormalTypeId;
            this.anormalTypeCode = anormalTypeCode;
            this.anormalTypeName = anormalTypeName;
            this.descriptions = descriptions;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.anormalGroupId = anormalGroupId;
        }
        /// <summary>
        /// 初始化 SKT.LeanMES.Model.Anormal_SubTypeInfo 类的新实例。
        /// </summary>
        /// <param name="anormalTypeId"></param>
        /// <param name="anormalTypeCode">子类编码</param>
        /// <param name="anormalTypeName">异常子类型名称</param>
        /// <param name="descriptions">描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        /// <param name="typeId">类型分组id
        ///</param>
        public AnormalTypeInfo(Int32 anormalTypeId, String anormalTypeCode, String anormalTypeName, String descriptions,String anormalGroupName)
        {
            this.anormalTypeId = anormalTypeId;
            this.anormalTypeCode = anormalTypeCode;
            this.anormalTypeName = anormalTypeName;
            this.descriptions = descriptions;
            this.anormalGroupName = anormalGroupName;
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 AnormalTypeId
        {
            get { return this.anormalTypeId; }
            set { this.anormalTypeId = value; }
        }

        /// <summary>
        /// 获取或设置子类编码
        /// </summary>
        public String AnormalTypeCode
        {
            get { return this.anormalTypeCode; }
            set { this.anormalTypeCode = value; }
        }

        /// <summary>
        /// 获取或设置异常子类型名称
        /// </summary>
        public String AnormalTypeName
        {
            get { return this.anormalTypeName; }
            set { this.anormalTypeName = value; }
        }

        /// <summary>
        /// 获取或设置描述
        /// </summary>
        public String Descriptions
        {
            get { return this.descriptions; }
            set { this.descriptions = value; }
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

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        /// <summary>
        /// 获取或设置类型分组id

        /// </summary>
        public Int32 AnormalGroupId
        {
            get { return this.anormalGroupId; }
            set { this.anormalGroupId = value; }
        }

        /// <summary>
        /// 获取或设置类型分组名称

        /// </summary>
        public String AnormalGroupName
        {
            get { return this.anormalGroupName; }
            set { this.anormalGroupName = value; }
        }
    }
}