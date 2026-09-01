using System;
using System.Security.Cryptography;
using System.Xml.Linq;

namespace SKT.LeanMES.Kanban.Model
{
    [Serializable]
    public class MasterInfo  
    {
        //看板(播放器)Kanban_Master
        private Int32 kanbanMasterId;
        private Int32 rptTemplateId;
        private String title;
        private String remark;
        private String createBy;
        private DateTime createTime;
        private String modifyBy;
        private DateTime modifyTime;
        private Int32 statusFlag;
        public string TitleLValue { set; get; }
        public string TitleLCss { set; get; }
        public string TitleMValue { set; get; }
        public string TitleMCss { set; get; }
        public string TitleRValue { set; get; }
        public string TitleRCss { set; get; }
        public int TitleLType { set; get; }
        public int TitleMType { set; get; }
        public int TitleRType { set; get; }
        public string BindContList { set; get; }
        public string ContPlayTimeList { set; get; }
        public string FootHtml { set; get; }
        //看板容器Kanban_Container
        public int KanbanContainerId { set; get; }
        public string ContainerName { set; get; }
        public string LayoutType { set; get; }
        public string EditOption { set; get; }
        public int ShowSeq { set; get; }
        public dynamic PlayMinutes { set; get; }
        public string IconSrc { set; get; }
        public int ContainerTypeId { set; get; }
        public int PositionType { set; get; }

        //看板控件KanbanComponent
        public int KanbanComponentId { set; get; }
        public string ComponentName { set; get; }
        public string DataSource { set; get; }
        public string SourceType { set; get; }
        public dynamic RefreshSec { set; get; }
        public int ComponentTypeId { set; get; }
        public string TypeName { set; get; }
        public string RawCode { set; get; }
        public string Param1 { set; get; }
        public string Param2 { set; get; }
        public string Param3 { set; get; }

        //继承报表部分,用于新增看板类型
        public string RTModuleName { get; set; }
        public string RTModuleCNValue { get; set; }
        public string RTModuleENValue { get; set; }
        public string RTDescription { get; set; }
        public DateTime CreateDateTime { get; set; }
        public DateTime ModifyDateTime { get; set; }
        public string ReportCNName { get; set; }
        public string ReportENName { get; set; }
        public string ReportType { get; set; }
        public string ReportIcon { get; set; }
        public string ReportUrl { get; set; }
        public float ReportSequence { get; set; }

        public Int32 TemplateId { get; set; }
        public string TemplateName { get; set; }
        public string TemplateDesc { get; set; }
        public string TemplateContent { get; set; }
        public string DesignJson { get; set; }
        //---------------------------------------------

        /// <summary>
        /// 初始化 SKT.LeanMES.Kanban.Model.MasterInfo 类的新实例。
        /// </summary>
        public MasterInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.Kanban.Model.MasterInfo 类的新实例。
        /// </summary>
        /// <param name="kanbanMasterId"></param>
        /// <param name="rptTemplateId">对应ReportTemplate表</param>
        /// <param name="title">播放器title</param>
        /// <param name="playTimeMinutes">容器播放时间(分钟)</param>
        /// <param name="remark"></param>
        /// <param name="createBy"></param>
        /// <param name="createTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyTime"></param>
        /// <param name="statusFlag"></param>
        public MasterInfo(Int32 kanbanMasterId, Int32 rptTemplateId, String title,  
            String remark, String createBy, DateTime createTime, String modifyBy, DateTime modifyTime, 
            Int32 statusFlag)
        {
            this.kanbanMasterId = kanbanMasterId;
            this.rptTemplateId = rptTemplateId;
            this.title = title;
            this.remark = remark;
            this.createBy = createBy;
            this.createTime = createTime;
            this.modifyBy = modifyBy;
            this.modifyTime = modifyTime;
            this.statusFlag = statusFlag;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 KanbanMasterId
        {
            get { return this.kanbanMasterId; }
            set { this.kanbanMasterId = value; }
        }

        /// <summary>
        /// 获取或设置对应ReportTemplate表
        /// </summary>
        public Int32 RptTemplateId
        {
            get { return this.rptTemplateId; }
            set { this.rptTemplateId = value; }
        }

        /// <summary>
        /// 获取或设置播放器title
        /// </summary>
        public String Title
        {
            get { return this.title; }
            set { this.title = value; }
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
        public DateTime CreateTime
        {
            get { return this.createTime; }
            set { this.createTime = value; }
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
        public DateTime ModifyTime
        {
            get { return this.modifyTime; }
            set { this.modifyTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 StatusFlag
        {
            get { return this.statusFlag; }
            set { this.statusFlag = value; }
        }
    }
}