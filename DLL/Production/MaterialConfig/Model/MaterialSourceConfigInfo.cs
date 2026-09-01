using System;

namespace SKT.LeanMES.MaterialConfig.Model
{
    [Serializable]
    public class MaterialSourceConfigInfo
    {
        private Int32 iD;
        private Int32 configTypeId;
        private String configType;
        private Int32 choosePageId;
        private String choosePageName;
        private String searchCondition;
        private String sourceName;
        private String remark;

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSourceConfigInfo 类的新实例。
        /// </summary>
        public MaterialSourceConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Model.MaterialSourceConfigInfo 类的新实例。
        /// </summary>
        /// <param name="iD"></param>
        /// <param name="configTypeId">数据源类型id</param>
        /// <param name="configType">数据源类型</param>
        /// <param name="choosePageId">绑定的选中的数据源id</param>
        /// <param name="choosePageName">数据源名称</param>
        /// <param name="remark">备注</param>
        public MaterialSourceConfigInfo(Int32 iD, Int32 configTypeId, String configType, Int32 choosePageId, 
            String choosePageName, String remark)
        {
            this.iD = iD;
            this.configTypeId = configTypeId;
            this.configType = configType;
            this.choosePageId = choosePageId;
            this.choosePageName = choosePageName;
            this.remark = remark;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SearchCondition
        {
            get { return this.searchCondition; }
            set { this.searchCondition = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SourceName
        {
            get { return this.sourceName; }
            set { this.sourceName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 ID
        {
            get { return this.iD; }
            set { this.iD = value; }
        }

        /// <summary>
        /// 获取或设置数据源类型id
        /// </summary>
        public Int32 ConfigTypeId
        {
            get { return this.configTypeId; }
            set { this.configTypeId = value; }
        }

        /// <summary>
        /// 获取或设置数据源类型
        /// </summary>
        public String ConfigType
        {
            get { return this.configType; }
            set { this.configType = value; }
        }

        /// <summary>
        /// 获取或设置绑定的选中的数据源id
        /// </summary>
        public Int32 ChoosePageId
        {
            get { return this.choosePageId; }
            set { this.choosePageId = value; }
        }

        /// <summary>
        /// 获取或设置数据源名称
        /// </summary>
        public String ChoosePageName
        {
            get { return this.choosePageName; }
            set { this.choosePageName = value; }
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