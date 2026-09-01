using System;

namespace SKT.LeanMES.MSD.Model
{
    [Serializable]
    public class MslInfo
    {
        private Int32 mslId;
        private String organizationCode;
        private String mSL;
        private Int32 floorLife;
        private Int32 shelfLife;
        private Int32 bakeCount;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MslInfo 类的新实例。
        /// </summary>
        public MslInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MslInfo 类的新实例。
        /// </summary>
        /// <param name="mslId">潮湿敏感度等级表ID</param>
        /// <param name="organizationCode">ERP组织代码</param>
        /// <param name="mSL">潮湿敏感度等级</param>
        /// <param name="floorLife">暴露时长(小时）</param>
        /// <param name="shelfLife">存储期限(小时）</param>
        /// <param name="bakeCount">烘烤次数</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        public MslInfo(Int32 mslId, String organizationCode, String mSL, Int32 floorLife, 
            Int32 shelfLife, Int32 bakeCount, String createBy, DateTime createDateTime, String modifyBy, 
            DateTime modifyDateTime)
        {
            this.mslId = mslId;
            this.organizationCode = organizationCode;
            this.mSL = mSL;
            this.floorLife = floorLife;
            this.shelfLife = shelfLife;
            this.bakeCount = bakeCount;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
        }

        /// <summary>
        /// 获取或设置潮湿敏感度等级表ID
        /// </summary>
        public Int32 MslId
        {
            get { return this.mslId; }
            set { this.mslId = value; }
        }

        /// <summary>
        /// 获取或设置ERP组织代码
        /// </summary>
        public String OrganizationCode
        {
            get { return this.organizationCode; }
            set { this.organizationCode = value; }
        }

        /// <summary>
        /// 获取或设置潮湿敏感度等级
        /// </summary>
        public String MSL
        {
            get { return this.mSL; }
            set { this.mSL = value; }
        }

        /// <summary>
        /// 获取或设置暴露时长(小时）
        /// </summary>
        public Int32 FloorLife
        {
            get { return this.floorLife; }
            set { this.floorLife = value; }
        }

        /// <summary>
        /// 获取或设置存储期限(小时）
        /// </summary>
        public Int32 ShelfLife
        {
            get { return this.shelfLife; }
            set { this.shelfLife = value; }
        }

        /// <summary>
        /// 获取或设置烘烤次数
        /// </summary>
        public Int32 BakeCount
        {
            get { return this.bakeCount; }
            set { this.bakeCount = value; }
        }

        /// <summary>
        /// 获取或设置创建人
        /// </summary>
        public String CreateBy
        {
            get { return this.createBy; }
            set { this.createBy = value; }
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
        /// 获取或设置修改人
        /// </summary>
        public String ModifyBy
        {
            get { return this.modifyBy; }
            set { this.modifyBy = value; }
        }

        /// <summary>
        /// 获取或设置修改时间
        /// </summary>
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }
    }
}