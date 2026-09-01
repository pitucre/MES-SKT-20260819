using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SKT.LeanMES.CommonDataSource.Model;
using SKT.LeanMES.Web.AjaxServices;

namespace SKT.LeanMES.Web.CommonDataSource
{
    public partial class CommonDataSourceEdit : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AjaxPro.Utility.RegisterTypeForAjax(typeof(AjaxCommDataSource));
            Int32 DataSourceId = Convert.ToInt32(Request.QueryString["ID"]);

            if (DataSourceId > -1)
            {
                CommonDataSourceInfo model = null;
                var bll = new SKT.LeanMES.CommonDataSource.BLL.DataSource();
                model = bll.GetInfo(DataSourceId);
                if (model != null)
                {
                    PageData = model;
                }
            }
        }


        private CommonDataSourceInfo PageData
        {
            set
            {
                ddlDbType.Value = value.SQLType;
                ddlUseType.Value = value.UseType;
                ddlLogicType.Value = value.DataSourceType;
                txtName.Text = value.DataSourceName;
                txtSQL.Text = value.SQLInfo;
                txtRemark.Text = value.DataSourceDesc;
            }
        }

    }
}