using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Maintenance.Model
{
    public class MaintenanceDemoSubInfo
    {
        private Int32 demoSubId;
        private Int32 demoId;
        private String demoSubCode;
        private String demoSubName;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceDemoSubInfo 类的新实例。
        /// </summary>
        public MaintenanceDemoSubInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Factory.Model.MaintenanceDemoSubInfo 类的新实例。
        /// </summary>
        /// <param name="demoSubId">主键id</param>
        /// <param name="demoId">保养项目id</param>
        /// <param name="demoSubCode">作业编号</param>
        /// <param name="demoSubName">作业名称</param>
        /// <param name="remark">作业说明</param>
        public MaintenanceDemoSubInfo(Int32 demoSubId, Int32 demoId, String demoSubCode, String demoSubName,
            String remark)
        {
            this.demoSubId = demoSubId;
            this.demoId = demoId;
            this.demoSubCode = demoSubCode;
            this.demoSubName = demoSubName;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置主键id
        /// </summary>
        public Int32 DemoSubId
        {
            get { return this.demoSubId; }
            set { this.demoSubId = value; }
        }

        /// <summary>
        /// 获取或设置保养项目id
        /// </summary>
        public Int32 DemoId
        {
            get { return this.demoId; }
            set { this.demoId = value; }
        }

        /// <summary>
        /// 获取或设置作业编号
        /// </summary>
        public String DemoSubCode
        {
            get { return this.demoSubCode; }
            set { this.demoSubCode = value; }
        }

        /// <summary>
        /// 获取或设置作业名称
        /// </summary>
        public String DemoSubName
        {
            get { return this.demoSubName; }
            set { this.demoSubName = value; }
        }

        /// <summary>
        /// 获取或设置作业说明
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public string SaveFileName { get; set; }
    }
}
