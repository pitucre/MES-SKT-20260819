using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SKT.LeanMES.Router.Model
{
    [Serializable]
    public class RouterInfo
    {
        private Int32 r_ID;
        private String r_Name;
        private String r_Description;
        private String r_JSON;
        private String routerJson;
        private Int32 r_Status;
        private String createBy;
        private DateTime createDateTime;
        private String modifyBy;
        private DateTime modifyDateTime;
        private String remark;

        private Int32 itemId;
        private String itemName;
        private String itemRev;
        private String itemCode;
        private String site;
        private String url;

        //2017-2-9 zhiman.yuan 添加是否检查开拉字段
        public bool IsCheckPull { get; set; }
        // 无用则删除
        private String formNO;
        private Decimal qty;


        /// <summary>
        /// 初始化 SKT.MES.User.Model.ROUTERInfo 类的新实例。
        /// </summary>
        public RouterInfo()
        {
        }

        /// <summary>
        /// 初始化 SKT.MES.User.Model.ROUTERInfo 类的新实例。
        /// </summary>
        /// <param name="r_ID"></param>
        /// <param name="r_Name">路由名称</param>
        /// <param name="r_Description">路由描述</param>
        /// <param name="r_JSON">路由JSON数据</param>
        /// <param name="r_Status">路由状态</param>
        /// <param name="createBy"></param>
        /// <param name="createDateTime"></param>
        /// <param name="modifyBy"></param>
        /// <param name="modifyDateTime"></param>
        /// <param name="remark"></param>
        public RouterInfo(Int32 r_ID, String r_Name, String r_Description, String r_JSON,
            Int32 r_Status, String createBy, DateTime createDateTime, String modifyBy, DateTime modifyDateTime,
            String remark,string routerJson=null)
        {
            this.r_ID = r_ID;
            this.r_Name = r_Name;
            this.r_Description = r_Description;
            this.r_JSON = r_JSON;
            this.r_Status = r_Status;
            this.createBy = createBy;
            this.createDateTime = createDateTime;
            this.modifyBy = modifyBy;
            this.modifyDateTime = modifyDateTime;
            this.remark = remark;
            this.routerJson = routerJson;
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public Int32 R_ID
        {
            get { return this.r_ID; }
            set { this.r_ID = value; }
        }

        /// <summary>
        /// 获取或设置路由名称
        /// </summary>
        public String R_Name
        {
            get { return this.r_Name; }
            set { this.r_Name = value; }
        }

        /// <summary>
        /// 获取或设置路由描述
        /// </summary>
        public String R_Description
        {
            get { return this.r_Description; }
            set { this.r_Description = value; }
        }

        /// <summary>
        /// 获取或设置路由JSON数据
        /// </summary>
        public String R_JSON
        {
            get { return this.r_JSON; }
            set { this.r_JSON = value; }
        }

        /// <summary>
        /// 获取或设置路由JSON数据
        /// </summary>
        public String RouterJson
        {
            get { return this.routerJson; }
            set { this.routerJson = value; }
        }

        /// <summary>
        /// 获取或设置路由状态
        /// </summary>
        public Int32 R_Status
        {
            get { return this.r_Status; }
            set { this.r_Status = value; }
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
        public DateTime CreateDateTime
        {
            get { return this.createDateTime; }
            set { this.createDateTime = value; }
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
        public DateTime ModifyDateTime
        {
            get { return this.modifyDateTime; }
            set { this.modifyDateTime = value; }
        }

        /// <summary>
        /// 获取或设置
        /// </summary>
        public String Remark
        {
            get { return this.remark; }
            set { this.remark = value; }
        }

        public Int32 ItemId
        {
            get { return this.itemId; }
            set { this.itemId = value; }
        }

        public String ItemName
        {
            get { return this.itemName; }
            set { this.itemName = value; }
        }

        public String ItemRev
        {
            get { return this.itemRev; }
            set { this.itemRev = value; }
        }
        public String FormNO
        {
            get { return this.formNO; }
            set { this.formNO = value; }
        }
        public Decimal Qty
        {
            get { return this.qty; }
            set { this.qty = value; }
        }

        public String ItemCode
        {
            get { return this.itemCode; }
            set { this.itemCode = value; }
        }

        public String Site
        {
            get { return this.site; }
            set { this.site = value; }
        }

        public String Url
        {
            get { return this.url; }
            set { this.url = value; }
        }

        /// <summary>
        /// 动作   2：复制 其它：新增或编辑
        /// </summary>
        public int Action { get; set; }

        /// <summary>
        /// 归属编码
        /// </summary>
        public String AttributionCode { get; set; }
    }
}