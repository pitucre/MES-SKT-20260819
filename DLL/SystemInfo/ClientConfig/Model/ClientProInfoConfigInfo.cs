/*-------------------------------------------------
// Copyright(C)2016 深圳市深科特信息技术有限公司
// 版权所有
// 
// 文件名:ClientProInfoConfig.cs
// 文件功能描述：生产采集模块中的产品信息以及生产计数的model
// 
// 创建标识：Larry.Lin 2016/07/27
// 
// 
//--------------------------------------------------*/
using System;

namespace SKT.LeanMES.ClientConfig.Model
{
    [Serializable]
    public class ClientProInfoConfigInfo
    {
        private Int32 clientProInfoConfigId;
        private String infoName;
        private String dbName;
        private Boolean isDisplay;
        private Int32 infoType;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private Int32 displayStyle;
        public string Popedom { get; set; }
        private string displayCSS;
        /// <summary>
        /// 初始化 SKT.LeanMES.ClientConfig.Model.ClientProInfoConfigInfo 类的新实例。
        /// </summary>
        public ClientProInfoConfigInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.ClientConfig.Model.ClientProInfoConfigInfo 类的新实例。
        /// </summary>
        /// <param name="clientProInfoConfigId">表Id</param>
        /// <param name="infoName">显示信息标题名称</param>
        /// <param name="dbName">显示信息在数据库数据表中的名字</param>
        /// <param name="isDisplay">该项值是否需要显示在Client端动态信息展示处</param>
        /// <param name="infoType">给信息类型，1表示产品信息，2表示生产计数</param>
        /// <param name="createBy">创建人</param>
        /// <param name="createDateTime">创建时间</param>
        /// <param name="modifyBy">修改人</param>
        /// <param name="modifyDateTime">修改时间</param>
        /// <param name="displayStyle">值的显示方式，1为span方式显示，2为通过textarea显示...亦可通过此扩展配置同一标签，不同style的显示模式。默认为1。</param>
        public ClientProInfoConfigInfo(Int32 clientProInfoConfigId, String infoName, String dbName, Boolean isDisplay, 
            Int32 infoType, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime, 
            Int32 displayStyle, string dispalyCss)
        {
            this.clientProInfoConfigId = clientProInfoConfigId;
            this.infoName = infoName;
            this.dbName = dbName;
            this.isDisplay = isDisplay;
            this.infoType = infoType;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.displayStyle = displayStyle;
            this.displayCSS = dispalyCss;
        }

        /// <summary>
        /// 显示的样式
        /// </summary>
        public string DisplayCSS
        {
            set { this.displayCSS = value; }
            get { return this.displayCSS; }
        }

        /// <summary>
        /// 获取或设置表Id
        /// </summary>
        public Int32 ClientProInfoConfigId
        {
            get { return this.clientProInfoConfigId; }
            set { this.clientProInfoConfigId = value; }
        }

        /// <summary>
        /// 获取或设置显示信息标题名称
        /// </summary>
        public String InfoName
        {
            get { return this.infoName; }
            set { this.infoName = value; }
        }

        /// <summary>
        /// 获取或设置显示信息在数据库数据表中的名字
        /// </summary>
        public String DbName
        {
            get { return this.dbName; }
            set { this.dbName = value; }
        }

        /// <summary>
        /// 获取或设置该项值是否需要显示在Client端动态信息展示处
        /// </summary>
        public Boolean IsDisplay
        {
            get { return this.isDisplay; }
            set { this.isDisplay = value; }
        }

        /// <summary>
        /// 获取或设置给信息类型，1表示产品信息，2表示生产计数
        /// </summary>
        public Int32 InfoType
        {
            get { return this.infoType; }
            set { this.infoType = value; }
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
        /// 获取或设置值的显示方式，1为span方式显示，2为通过textarea显示...亦可通过此扩展配置同一标签，不同style的显示模式。默认为1。
        /// </summary>
        public Int32 DisplayStyle
        {
            get { return this.displayStyle; }
            set { this.displayStyle = value; }
        }
    }
}