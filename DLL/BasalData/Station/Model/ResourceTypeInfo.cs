using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class ResourceTypeInfo
    {
        private Int32 resourceTypeId;
        private String resTypeName;
        private String resTypeDesc;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceTypeInfo 类的新实例。
        /// </summary>
        public ResourceTypeInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceTypeInfo 类的新实例。
        /// </summary>
        /// <param name="resourceTypeId">资源类型ID</param>
        /// <param name="resTypeName">资源类型名称</param>
        /// <param name="resTypeDesc">资源类型描述</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public ResourceTypeInfo(Int32 resourceTypeId, String resTypeName, String resTypeDesc, String createBy, 
           String modifyBy, String remark)
        {
            this.resourceTypeId = resourceTypeId;
            this.resTypeName = resTypeName;
            this.resTypeDesc = resTypeDesc;
            this.createBy = createBy;
            this.modifyBy = modifyBy;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置资源类型ID
        /// </summary>
        public Int32 ResourceTypeId
        {
            get { return this.resourceTypeId; }
            set { this.resourceTypeId = value; }
        }

        /// <summary>
        /// 获取或设置资源类型名称
        /// </summary>
        public String ResTypeName
        {
            get { return this.resTypeName; }
            set { this.resTypeName = value; }
        }

        /// <summary>
        /// 获取或设置资源类型描述
        /// </summary>
        public String ResTypeDesc
        {
            get { return this.resTypeDesc; }
            set { this.resTypeDesc = value; }
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
    }
}