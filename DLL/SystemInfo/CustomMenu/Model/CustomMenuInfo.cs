using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SKT.LeanMES.CustomMenu.Model
{
    public class CustomMenuInfo
    {
        private String fatherKey;
        private String keyCNValues;
        private String keyENValues;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;
        private Int32 sequence;

        private Int32 pageId;
        private String pageName;
        private String pageCName;
        private String pageEName;
        private String pageDesc;
        private String pageContent;
        private String module;
        private String moduleCName;
        private String moduleEName;
        private String icon;
        private String url;
        private String designJSON;
        private String subSystem;
        private bool isCodeDesign;
        private String pageContentSub;
        private Int32 pType;


        /// <summary>
        /// 初始化新实例
        /// </summary>
        public CustomMenuInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.LeanMES.AccreditLogInfo.Model 类的新实例。
        /// </summary>
        /// <param name="logId"></param>
        /// <param name="userNo"></param>
        /// <param name="userName"></param>
        /// <param name="logContent"></param>
        /// <param name="createDateTime"></param>
        public CustomMenuInfo(String fatherKey, String keyCNValues, String keyENValues, String createBy, 
            DateTime createDateTime,String modifyBy, DateTime modifyDateTime,String remark,Int32 sequence)
        {
            this.fatherKey = fatherKey;
            this.keyCNValues = keyCNValues;
            this.keyENValues = keyENValues;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.sequence = sequence;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 PType
        {
            get { return this.pType; }
            set { this.pType = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageContentSub
        {
            get { return this.pageContentSub; }
            set { this.pageContentSub = value; }
        }

        /// <summary>
        /// 获取或设置一级菜单名称
        /// </summary>
        public String FatherKey
        {
            get { return this.fatherKey; }
            set { this.fatherKey = value; }
        }
        /// <summary>
        /// 获取或设置一级菜单中文名称
        /// </summary>
        public String KeyCNValues
        {
            get { return this.keyCNValues; }
            set { this.keyCNValues = value; }
        }
        /// <summary>
        /// 获取或设置一级菜单英文名称
        /// </summary>
        public String KeyENValues
        {
            get { return this.keyENValues; }
            set { this.keyENValues = value; }
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
        /// 获取或设置菜单备注
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }
        /// <summary>
        /// 获取或设置序号
        /// </summary>
        public Int32 Sequence
        {
            get { return this.sequence; }
            set { this.sequence = value; }
        }

        /// <summary>
        /// 获取或设
        /// </summary>
        public Int32 PageId
        {
            get { return this.pageId; }
            set { this.pageId = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageName
        {
            get { return this.pageName; }
            set { this.pageName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageCName
        {
            get { return this.pageCName; }
            set { this.pageCName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageEName
        {
            get { return this.pageEName; }
            set { this.pageEName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageDesc
        {
            get { return this.pageDesc; }
            set { this.pageDesc = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String PageContent
        {
            get { return this.pageContent; }
            set { this.pageContent = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Module
        {
            get { return this.module; }
            set { this.module = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModuleCName
        {
            get { return this.moduleCName; }
            set { this.moduleCName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String ModuleEName
        {
            get { return this.moduleEName; }
            set { this.moduleEName = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Icon
        {
            get { return this.icon; }
            set { this.icon = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Url
        {
            get { return this.url; }
            set { this.url = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String DesignJSON
        {
            get { return this.designJSON; }
            set { this.designJSON = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public String SubSystem
        {
            get { return this.subSystem; }
            set { this.subSystem = value; }
        }
        /// <summary>
        /// 获取或设置
        /// </summary>
        public Boolean IsCodeDesign
        {
            get { return this.isCodeDesign; }
            set { this.isCodeDesign = value; }
        }
    }
}
