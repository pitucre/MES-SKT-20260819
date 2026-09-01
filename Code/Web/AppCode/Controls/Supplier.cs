using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.ComponentModel;
using System.Web.Caching;
using System.Web.UI.WebControls;

namespace SKT.LeanMES.Web.Controls
{
    /// <summary>
    /// 工厂下拉列表控件。
    /// </summary>
    [ToolboxData("<{0}:Supplier runat=\"server\"></{0}:Supplier>")]
    [Description("供应商下拉列表。")]
    [Localizable(false)]
    public class Supplier : DropDownListBase
    {
        private static readonly String cacheKey = "Supplier";
        private String dataTextField = "VendorCode";
        private String dataValueField = "SupplierId";

        /// <summary>
        /// 设置为列表项提供文本内容的数据源字段。
        /// </summary>
        [DefaultValue("VendorCode")]
        [Description("设置为列表项提供文本内容的数据源字段。")]
        public String BindTextField
        {
            get { return this.dataTextField; }
            set { this.dataTextField = value; }
        }

        /// <summary>
        /// 设置为列表项提供值的数据源字段。
        /// </summary>
        [DefaultValue("SupplierId")]
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
            Cache cache = HttpContext.Current.Cache;
            List<LeanMES.Supplier.Model.SuppliersInfo> supplierList = cache.Get(cacheKey) as List<LeanMES.Supplier.Model.SuppliersInfo>;

            if (supplierList == null)
            {
                supplierList = (new LeanMES.Supplier.BLL.Suppliers()).GetSupplierList("VendorCode");

                cache.Insert(cacheKey, supplierList, null, Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
            }
            #endregion
            this.DataSource = supplierList;
            this.DataTextField = dataTextField;
            this.DataValueField = dataValueField;
            this.DataBind();
            this.Items.Insert(0, new ListItem("", "-1"));
        }
    }
}