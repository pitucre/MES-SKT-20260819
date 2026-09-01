using System;

namespace SKT.LeanMES.MaskGroup.Model
{
    [Serializable]
    public class MaskGroupInfo
    {
        private Int32 maskID;
        private String maskGroup;
        private String description;
        private String remark;
        private DateTime modifyDateTime;
        private String modifyBy;
        private DateTime createDateTime;
        private String createBy;

        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.GROUPInfo 类的新实例。
        /// </summary>
        public MaskGroupInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.Model.SYS.GROUPInfo 类的新实例。
        /// </summary>
        /// <param name="maskID"></param>
        /// <param name="mask_Group">掩码名称</param>
        /// <param name="description">描述</param>
        /// <param name="remark">备注</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="modifyBy">修改者</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="createBy">创建者</param>
        public MaskGroupInfo(Int32 maskID, String mask_Group, String description, String remark, 
            DateTime modifyDateTime, String modifyBy, DateTime createDateTime, String createBy)
        {
            this.maskID = maskID;
            this.maskGroup = mask_Group;
            this.description = description;
            this.remark = remark;
            this.modifyDateTime = modifyDateTime;
            this.modifyBy = modifyBy;
            this.createDateTime = createDateTime;
            this.createBy = createBy;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 MaskID
        {
            get { return this.maskID; }
            set { this.maskID = value; }
        }

        /// <summary>
        /// 获取或设置掩码名称
        /// </summary>
        public String MaskGroup
        {
            get { return this.maskGroup; }
            set { this.maskGroup = value; }
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