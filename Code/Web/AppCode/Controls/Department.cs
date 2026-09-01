using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.ComponentModel;
using System.Web.Caching;
using SKT.Common.Account.Model;

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 工厂下拉列表控件。
    /// </summary>
    [ToolboxData("<{0}:Department runat=\"server\"></{0}:Department>")]
    [Description("部门下拉列表。")]
    [Localizable(false)]
    public class Department : DropDownListBase
    {
        private static readonly String cacheKey = "Department";
        private String dataTextField = "DepartmentName";
        private String dataValueField = "DepartmentID";

        /// <summary>
        /// 设置为列表项提供文本内容的数据源字段。
        /// </summary>
        [DefaultValue("DepartmentName")]
        [Description("设置为列表项提供文本内容的数据源字段。")]
        public String BindTextField
        {
            get { return this.dataTextField; }
            set { this.dataTextField = value; }
        }

        /// <summary>
        /// 设置为列表项提供值的数据源字段。
        /// </summary>
        [DefaultValue("DepartmentID")]
        [Description("设置为列表项提供值的数据源字段。")]
        public String BindValueField
        {
            get { return this.dataValueField; }
            set { this.dataValueField = value; }
        }

        /// <summary>
        /// 绑定列表。
        /// </summary>
        protected override void BindControl()
        {
            #region 注释 Alen 2014-02-18 测试时注释，正式时开起
            //Cache cache = HttpContext.Current.Cache;
            //List<DepartmentInfo> departmentList = cache.Get(cacheKey) as List<DepartmentInfo>;

            //if (departmentList == null)
            //{
            //    departmentList = (new SKT.MES.User.BLL.Department()).GetAll(0, -1, "DepartmentName", null);

            //    cache.Insert(cacheKey, departmentList, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
            //}
            #endregion
            //List<DepartmentInfo>  departmentList = (new SKT.MES.User.BLL.Department()).GetAll(0, -1, "DepartmentName", null);
            //this.DataSource = departmentList;
            //this.DataTextField = dataTextField;
            //this.DataValueField = dataValueField;
            //this.DataBind();
        }
    }
}