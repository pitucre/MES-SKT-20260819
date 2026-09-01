using System;

namespace SKT.LeanMES.Maintenance.Model
{
    [Serializable]
    public class MaintenanceDemoInfo
    {
        private Int32 demoId;
        private String demoCode;
        private String demoName;
        private String description;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceDemoInfo 类的新实例。
        /// </summary>
        public MaintenanceDemoInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceDemoInfo 类的新实例。
        /// </summary>
        /// <param name="demoId">主键</param>
        /// <param name="demoCode">保养项目代码</param>
        /// <param name="demoName">保养项目名称</param>
        /// <param name="description">描述</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="remark">备注</param>
        public MaintenanceDemoInfo(Int32 demoId, String demoCode, String demoName, String description,
            String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, String remark)
        {
            this.demoId = demoId;
            this.demoCode = demoCode;
            this.demoName = demoName;
            this.description = description;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键
        /// </summary>
        public Int32 DemoId
        {
            get { return this.demoId; }
            set { this.demoId = value; }
        }

        /// <summary>
        /// 获取或设置保养项目代码
        /// </summary>
        public String DemoCode
        {
            get { return this.demoCode; }
            set { this.demoCode = value; }
        }

        /// <summary>
        /// 获取或设置保养项目名称
        /// </summary>
        public String DemoName
        {
            get { return this.demoName; }
            set { this.demoName = value; }
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

        /// <summary>
        /// 获取或设置备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
    }
}