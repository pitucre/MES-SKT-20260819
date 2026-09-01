using System;

namespace SKT.LeanMES.Station.Model
{
    [Serializable]
    public class ResourceTypeMemberInfo
    {
        private Int32 resourceTypeMemberId;
        private Int32 resourceTypeId;
        private Int32 resourceId;

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceTypeMemberInfo 类的新实例。
        /// </summary>
        public ResourceTypeMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Station.Model.ResourceTypeMemberInfo 类的新实例。
        /// </summary>
        /// <param name="resourceTypeMemberId"></param>
        /// <param name="resourceTypeId">资源类型ID</param>
        /// <param name="resourceId">资源ID</param>
        public ResourceTypeMemberInfo(Int32 resourceTypeMemberId, Int32 resourceTypeId, Int32 resourceId)
        {
            this.resourceTypeMemberId = resourceTypeMemberId;
            this.resourceTypeId = resourceTypeId;
            this.resourceId = resourceId;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ResourceTypeMemberId
        {
            get { return this.resourceTypeMemberId; }
            set { this.resourceTypeMemberId = value; }
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
        /// 获取或设置资源ID
        /// </summary>
        public Int32 ResourceId
        {
            get { return this.resourceId; }
            set { this.resourceId = value; }
        }
    }
}