using System;

namespace SKT.LeanMES.NCCode.Model
{
    [Serializable]
    public class NCGroupMemberInfo
    {
        private Int32 nCGroupMemberId;
        private Int32 nCGroupId;
        private Int32 nCCodeId;
        private string nCCode;
        private string groupName;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.NCGroupMemberInfo 类的新实例。
        /// </summary>
        public NCGroupMemberInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.NCGroupMemberInfo 类的新实例。
        /// </summary>
        /// <param name="nCGroupMemberId">Unique Identifier</param>
        /// <param name="nCGroupId">不良代码组ID</param>
        /// <param name="nCCodeId">不良代码ID</param>
        public NCGroupMemberInfo(Int32 nCGroupMemberId, Int32 nCGroupId, Int32 nCCodeId)
        {
            this.nCGroupMemberId = nCGroupMemberId;
            this.nCGroupId = nCGroupId;
            this.nCCodeId = nCCodeId;
        }

        /// <summary>
        /// 获取或设置Unique Identifier
        /// </summary>
        public Int32 NCGroupMemberId
        {
            get { return this.nCGroupMemberId; }
            set { this.nCGroupMemberId = value; }
        }

        /// <summary>
        /// 获取或设置不良代码组ID
        /// </summary>
        public Int32 NCGroupId
        {
            get { return this.nCGroupId; }
            set { this.nCGroupId = value; }
        }

        /// <summary>
        /// 获取或设置不良代码ID
        /// </summary>
        public Int32 NCCodeId
        {
            get { return this.nCCodeId; }
            set { this.nCCodeId = value; }
        }

        /// <summary>
        /// 获取或设置不良代码名
        /// </summary>
        public string NCCode
        {
            get { return this.nCCode; }
            set { this.nCCode = value; }
        }

        /// <summary>
        /// 获取或设置不良代码组名
        /// </summary>
        public string GroupName
        {
            get { return this.groupName; }
            set { this.groupName = value; }
        }
    }
}